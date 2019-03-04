benchmark_custom <- function(task, learner, resampling) {
  parallelStart(
    mode = "multicore", cpus = ignore(32), level = "mlr.resample",
    mc.set.seed = TRUE
  )
  set.seed(12345, kind = "L'Ecuyer-CMRG")

  bmr <- benchmark(learner, task,
                   models = FALSE,
                   keep.pred = TRUE,
                   keep.extract = FALSE,
                   resampling = resampling,
                   show.info = TRUE, measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}

benchmark_custom_cores <- function(task, learner, resampling) {
  parallelStart(
    mode = "multicore", cpus = ignore(16), level = "mlr.resample",
    mc.set.seed = TRUE
  )
  set.seed(12345, kind = "L'Ecuyer-CMRG")

  bmr <- benchmark(learner, task,
                   models = FALSE,
                   keep.pred = TRUE,
                   keep.extract = FALSE,
                   resampling = resampling,
                   show.info = TRUE, measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}
