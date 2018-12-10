prediction_custom = function(task, learner, param_set, tune_ctrl, resampling, prediction_data) {

  configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

  browser()
  # Tune all models ---------------------------------------------------------

  if (learner != rlang::syms("lrn_glm")) {
    parallelStart(
      mode = "multicore", level = "mlrMBO.feval", cpus = 30,
      mc.set.seed = TRUE
    )
    set.seed(12345)
    models_tuned <- tuneParams(learner,
                               task = task, resampling = resampling,
                               par.set = param_set, control = tune_ctrl,
                               show.info = TRUE, measure = list(brier)
    )
    parallelStop()
  }

  # Train all models ---------------------------------------------------------

  learner_tuned %<>% map2(~ setHyperPars(.x,
                                         par.vals = models_tuned[[.y]]$x
  ))

  # append glm learner
  learner_tuned = list(learned_tuned, learner[[5]])


  fit_armillaria <- map(learner_tuned, ~ train(.x, armillaria_task))

  # Create predictions ---------------------------------------------------


  browser()

  if (fit_armillaria$learner.model == "xgboost") {
    fit_armillaria <- fit_armillaria[.x$learner.model$feature_names]
  }
  predictions <- predict(.x, newdata = pred_data)

  # Create prediction maps ---------------------------------------------------

  # this object contains the coordinates that we need to attach to the predictions
  df_basque <- readRDS("/data/patrick/mod/prediction/temporary/df_basque.rda")

  walk2(predictions, list("ranger", "xgboost", "svm", "binomial", "kknn"), ~{

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

    png(glue("/data/patrick/mod/pathogen-prediction/08-imgs/single/prediction_{.y}_armillaria.png"))
    plot(map_xgboost)
    dev.off()
  })

}
