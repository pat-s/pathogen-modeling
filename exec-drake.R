## make targets

r_make(r_args = list(show = TRUE))

# visualize

r_vis_drake_graph(group = "stage", clusters = c("data", "task", "learner",
                                                        "mlr_settings",
                                                        "prediction"),
                  targets_only = TRUE, show_output_files = FALSE)
# see outdated

r_outdated(r_args = list(show = TRUE))

# Misc
r_predict_runtime(r_args = list(show = TRUE))

r_predict_workers()


# Manually ----------------------------------------------------------------

make(plan, verbose = 2, targets = c("benchmark_evaluation_report_all"),
     cache_log_file = "log/cache_log.txt",
     console_log_file = "log/drake.log",
     lazy_load = "promise", caching = "worker",
     memory_strategy = "memory",
     template = list(log_file = "log/worker%a.log", n_cpus= 32, memory = 120000),
     garbage_collection = TRUE, jobs = 3, parallelism = "clustermq")
