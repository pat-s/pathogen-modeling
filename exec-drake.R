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
