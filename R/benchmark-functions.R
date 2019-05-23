#' @title mlr::benchmark() wrapper
#'
#' @template task
#' @template learner
#' @template resampling
#' @export

benchmark_custom_no_extract_no_pred_no_models <- function(task, learner, resampling) {

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
                   models = FALSE,
                   keep.pred = TRUE,
                   keep.extract = FALSE,
                   resampling = resampling,
                   show.info = TRUE,
                   measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}

#' @title mlr::benchmark() wrapper
#'
#' @template task
#' @template learner
#' @template resampling
#' @export

benchmark_custom_no_pred_no_models <- function(task, learner, resampling) {

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
                   models = FALSE,
                   keep.pred = TRUE,
                   keep.extract = TRUE,
                   resampling = resampling,
                   show.info = TRUE,
                   measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}
