benchmark_custom <- function(task, learner, resampling) {

  if (grepl("kknn", learner$id)) {
    cores = ignore(16)
  } else {
    cores = ignore(32)
  }

  parallelStart(
    mode = "multicore", cpus = cores, level = "mlr.resample",
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
