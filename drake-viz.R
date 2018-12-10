source("scripts/drake.R")

# Visualization -----------------------------------------------------------

### no data grouping
vis_drake_graph(config, group = "stage", clusters = c("task", "learner",
                                                      "mlr_settings",
                                                      "benchmark",
                                                      "prediction"),
                targets_only = TRUE, show_output_files = FALSE,
                selfcontained = TRUE)

sankey_drake_graph(config, group = "stage", clusters = c("task", "learner",
                                                   "mlr_settings",
                                                   "benchmark",
                                                   "prediction"),
             targets_only = TRUE, show_output_files = FALSE)

drake_ggraph(config, group = "stage", clusters = c("task", "learner",
                                                     "mlr_settings",
                                                     "benchmark",
                                                     "prediction"),
               targets_only = TRUE, show_output_files = FALSE) +
  ggpubr::theme_pubr()
#
#
# ### all grouping
#
vis_drake_graph(config, group = "stage", clusters = c("data", "task", "learner",
                                                      "mlr_settings"),
                targets_only = TRUE, show_output_files = FALSE,
                navigationButtons, file = "drake.png")
sankey_drake_graph(config, group = "stage", clusters = c("data", "task", "learner",
                                                         "mlr_settings"),
                   targets_only = TRUE, show_output_files = FALSE)

drake_ggraph(config, group = "stage", clusters = c("data", "task", "learner",
                                                          "mlr_settings"),
                    targets_only = TRUE, show_output_files = FALSE) + ggpubr::theme_pubr()

# make(plan, keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "bm_glm", keep_going = TRUE, console_log_file=stdout())






library(drake)
plan <- drake_plan(
  x = stop(123),
  y = {
    x
    1 + 1
  },
  z = 1 + 1
)
make(plan, keep_going = TRUE)
#> target x
#> fail x
#> target y
cached() # x is missing
#> [1] "y"
config <- drake_config(plan)
vis_drake_graph(config)
progress()
#>          x          y
#>   "failed" "finished"
config$log_progress <- TRUE
drake:::set_progress("x", "finished", config)
config$log_progress <- FALSE
progress()
#>          x          y
#> "finished" "finished"
vis_drake_graph(config)
