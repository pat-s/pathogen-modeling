prediction_custom = function(..., learner, param_set, tune_ctrl, resampling,
                             prediction_data, prediction_grid) {

  configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

  if (grepl("diplodia", deparse(substitute(learner)))) {
    task = diplodia_task_dummy_prediction
  } else if (grepl("fusarium", deparse(substitute(learner)))) {
    task = fusarium_task_dummy_prediction
  } else if (grepl("armillaria", deparse(substitute(learner)))) {
    task = armillaria_task_dummy_prediction
  } else if (grepl("heterobasidion", deparse(substitute(learner)))) {
    task = heterobasidion_task_dummy_prediction
  }

  tasks = list(...)

  #out = map(tasks[[1]], ~ {

    # Tune all models ---------------------------------------------------------

    if (learner$id != "classif.binomial") {
      parallelStart(
        mode = "multicore", level = "mlrMBO.feval", cpus = 30,
        mc.set.seed = TRUE
      )
      set.seed(12345)
      models_tuned <- tuneParams(learner,
                                 task = tasks[[1]], resampling = resampling,
                                 par.set = param_set, control = tune_ctrl,
                                 show.info = TRUE, measure = list(brier)
      )
      parallelStop()
    }

    # Train all models ---------------------------------------------------------

    if (learner$id != "classif.binomial") {
      learner_tuned %<>% map2(~ setHyperPars(learner,
                                             par.vals = models_tuned[[.y]]$x
      ))
    } else {
      learner_tuned = learner
    }

    fit <- train(learner_tuned, tasks[[1]])

    # Create predictions ---------------------------------------------------

    if (fit$learner.model == "xgboost") {
      fit <- fit[tasks[[1]]$learner.model$feature_names]
    }
    predictions <- predict(fit, newdata = prediction_data)

    # Create prediction maps ---------------------------------------------------

    # this object contains the coordinates that we need to attach to the predictions
    prediction_grid <- as(prediction_grid, "SpatialPixelsDataFrame")
    prediction_grid = st_as_sf(prediction_grid)
    coords <- as.data.frame(st_coordinates(prediction_grid))
    colnames(coords) <- c("x", "y")
    # we need to make sure that the rownames of `coords` mirror the ones from `df_basque `
    rownames(coords) <- rownames(prediction_grid)
    rm(prediction_grid)

    #' # Visualize all predictors

    # we join the predictions and coordinates based on the rownames of both objects
    pred_xy_xg <- left_join(rownames_to_column(predictions),
                            rownames_to_column(coords),
                            by = "rowname"
    )

    pred_xy_xg <- SpatialPixelsDataFrame(
      points = pred_xy_xg[, c("x", "y")],
      data = as.data.frame(pred_xy_xg[, "prob.1"]),
      proj4string = CRS("+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")
    )
    names(pred_xy_xg) <- "probability"

    raster_xg <- projectRaster(raster(pred_xy_xg),
                               crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ")

    dir_create("data/prediction")

    # write out raster
    writeRaster(raster_xg, glue("data/prediction/prediction-{tasks[[1]]$id}-{learner_tuned$id}.tif"),
                overwrite = TRUE
    )

    #return(raster_xg)
  #})

  return(out)
}
