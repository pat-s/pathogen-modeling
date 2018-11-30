# Packages ----------------------------------------------------------------

needs(
  sf, magrittr, raster, purrr, dplyr, lwgeom, forcats, tibble, viridis,
  rasterVis, lattice, latticeExtra, mlr, mlrMBO, glue, parallelMap
)
configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

# Task --------------------------------------------------------------------

armillaria_task <- readRDS("/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task-dummy.rda")

# Learner -----------------------------------------------------------------

lrn_ranger <- readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-ranger.rda")
lrn_xgboost <- readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-xgboost.rda")
lrn_svm <- readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-svm.rda")

# Param sets --------------------------------------------------------------

ps_ranger <- readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-ranger.rda")
ps_xg <- readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-xgboost.rda")
ps_svm <- readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-svm.rda")

# Resampling --------------------------------------------------------------

rdesc_inner <- readRDS("/data/patrick/mod/pathogen-prediction/03-resampling/spcv-5iters-1rep.rda")

# Tuning ctrl -------------------------------------------------------------

tune_ctrl_ranger <- readRDS("/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-ranger.rda")
tune_ctrl_xgboost <- readRDS("/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-xgboost.rda")
tune_ctrl_svm <- readRDS("/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-svm.rda")

# Tune all models ---------------------------------------------------------

models_tuned <- pmap(
  list(
    models = list(lrn_ranger, lrn_xgboost, lrn_svm),
    param_sets = list(ps_ranger, ps_xg, ps_svm),
    names = list("ranger", "xgboost", "svm"),
    tuning_ctrl = list(tune_ctrl_ranger, tune_ctrl_xgboost, tune_ctrl_svm)
  ),
  function(models, param_sets, names, tuning_ctrl) {
    if (!file.exists(glue("/data/patrick/mod/pathogen-prediction/05-tuning/{names}-tuned-armillaria.rda"))) {
      parallelStart(
        mode = "multicore", level = "mlrMBO.feval", cpus = 30,
        mc.set.seed = TRUE
      )
      set.seed(12345)
      out <- tuneParams(models,
        task = armillaria_task, resampling = rdesc_inner,
        par.set = param_sets, control = tuning_ctrl,
        show.info = TRUE, measure = list(brier)
      )
      parallelStop()
      saveRDS(out, glue("/data/patrick/mod/pathogen-prediction/05-tuning/{names}-tuned-armillaria.rda"))
    } else {
      out <- readRDS(glue("/data/patrick/mod/pathogen-prediction/05-tuning/{names}-tuned-armillaria.rda"))
    }
  }
)

# Train all models ---------------------------------------------------------

models_trained <- map(list("ranger", "xgboost", "svm"), ~{
  if (!file.exists(glue("/data/patrick/mod/pathogen-prediction/07-prediction/trained-models/trained-{.x}-armillaria.rda"))) {
    tuned <- readRDS(glue("/data/patrick/mod/pathogen-prediction/05-tuning/{.x}-tuned-armillaria.rda"))

    lrn <- setHyperPars(makeLearner(glue("classif.{.x}"),
      predict.type = "prob"
    ),
    par.vals = tuned$x
    )
    model_armillaria <- train(lrn, armillaria_task)
    saveRDS(model_armillaria, glue("/data/patrick/mod/pathogen-prediction/07-prediction/trained-models/trained-{.x}-armillaria.rda"))
    model_armillaria
  } else {
    model_armillaria <- readRDS(glue("/data/patrick/mod/pathogen-prediction/07-prediction/trained-models/trained-{.x}-armillaria.rda"))
  }
})

# Create prediction data ---------------------------------------------------------

if (!file.exists("/data/patrick/mod/pathogen-prediction/07-prediction/prediction-df.rda")) {
  source("03_scripts/05-prediction/create-prediction-data.R")
} else {
  pred_data <- readRDS("/data/patrick/mod/pathogen-prediction/07-prediction/prediction-df.rda")
}

# Create predictions ---------------------------------------------------

predictions <- map2(models_trained, list("ranger", "xgboost", "svm"), ~{
  if (!file.exists(glue("/data/patrick/mod/pathogen-prediction/07-prediction/predicted-values/predictions-{.y}-armillaria.rda"))) {
    if (.y == "xgboost") {
      pred_data <- pred_data[.x$learner.model$feature_names]
    }
    pred <- predict(.x, newdata = pred_data)
    saveRDS(pred, glue("/data/patrick/mod/pathogen-prediction/07-prediction/predicted-values/predictions-{.y}-armillaria.rda"))
    pred
  } else {
    predictions <- readRDS(glue("/data/patrick/mod/pathogen-prediction/07-prediction/predicted-values/predictions-{.y}-armillaria.rda"))
  }
})

# Create prediction maps ---------------------------------------------------

# this object contains the coordinates that we need to attach to the predictions
df_basque <- readRDS("/data/patrick/mod/prediction/temporary/df_basque.rda")

walk2(predictions, list("ranger", "xgboost", "svm"), ~{

  #' # Visualize all predictors

  # mapview(df_basque)

  # pred_data$x = as.integer(st_coordinates(df_basque)[, 1])
  # pred_data$y = as.integer(st_coordinates(df_basque)[, 2])

  coords <- as.data.frame(st_coordinates(df_basque))
  colnames(coords) <- c("x", "y")
  # we need to make sure that the rownames of `coords` mirror the ones from `df_basque `
  rownames(coords) <- rownames(df_basque)

  # we join the predictions and coordinates based on the rownames of both objects
  pred_xy_xg <- left_join(rownames_to_column(.x$data),
    rownames_to_column(coords),
    by = "rowname"
  )

  pred_xy_xg <- SpatialPixelsDataFrame(
    points = pred_xy_xg[, c("x", "y")],
    data = as.data.frame(pred_xy_xg[, "prob.1"]),
    proj4string = CRS("+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")
  )
  names(pred_xy_xg) <- "probability"

  # mapview(pred_xy_xg, legend = TRUE, zcol = "probability",
  #         at = c(0, 0.25, 0.5, 0.75, 1), layer.name = "probability")

  # write out raster
  raster_xg <- raster(pred_xy_xg)
  raster_xg <- projectRaster(raster_xg, crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ")

  writeRaster(raster_xg, glue("/data/patrick/mod/pathogen-prediction/07-prediction/tiffs/armillaria-{.y}.tif"),
    overwrite = TRUE
  )

  study_area <- st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp",
    quiet = TRUE
  ) %>%
    st_transform(32630) %>%
    as("Spatial")

  study_area %<>%
    st_as_sf() %>%
    st_transform(4326) %>%
    as("Spatial")

  map_xgboost <- levelplot(
    raster_xg[["probability"]],
    main = substitute(paste(
      "Probability of tree infections by ",
      italic("armillaria mellea")
    )),
    margin = FALSE,
    between = list(x = 0.0, y = 0.0),
    at = seq(0, 1, length.out = 100),
    colorkey = list(
      width = 0.75,
      space = "right",
      labels = list(
        at = c(0, 0.25, 0.5, 0.75, 1),
        font = 4
      ),
      axis.line = list(col = "black")
    ),
    par.strip.text = list(col = "white", cex = 1.2),
    col.regions = viridis
  )

  png(glue("/data/patrick/mod/pathogen-prediction/08-imgs/prediction_{.y}_armillaria.png"))
  plot(map_xgboost)
  dev.off()
})
