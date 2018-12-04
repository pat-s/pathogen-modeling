benchmark_custom = function(task, learner, resampling) {

  map(task, ~ {

          parallelStart(mode = "multicore", cpus = 30, level = "mlr.resample",
                        mc.set.seed = TRUE)
          set.seed(12345, kind = "L'Ecuyer-CMRG")

          bmr <- benchmark(learner, .x, models = FALSE,
                           resampling = resampling,
                           show.info = TRUE, measures = list(brier, timetrain))

          parallelStop()

        })

}
