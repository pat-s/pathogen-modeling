#' @title mlr::benchmark() wrapper
#'
#' @template task
#' @template learner
#' @template resampling

benchmark_custom <- function(task, learner, resampling) {

  if (grepl("kknn", learner$id)) {
    cores = ignore(16)
  } else {
    cores = ignore(32)
  }

  parallelStart(
    mode = "multicore", cpus = cores, level = "mlr.resample",
    mc.set.seed = FALSE
  )
  set.seed(12345)

  bmr <- benchmark(learner, task,
                   models = ignore(FALSE),
                   keep.pred = ignore(TRUE),
                   keep.extract = ignore(TRUE),
                   resampling = resampling,
                   show.info = ignore(TRUE), measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}
