needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr, lwgeom,
      forcats, tibble, rgdal, viridis, rasterVis, lattice, latticeExtra, glue,
      RSAGA, stringr, GSIF, sp)

# preprocessing -----------------------------------------------------------

data = code_to_plan("scripts/data.R")
pred_data = code_to_plan("scripts/create-prediction-data.R")
task = code_to_plan("scripts/01-Task.R")
learners = code_to_plan("scripts/02-Learner.R")
resampling = code_to_plan("scripts/03-Resampling.R")
param_set = code_to_plan("scripts/04-Param-set.R")
tune_ctrl = code_to_plan("scripts/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("scripts/05-Tuning.R")

# grouping for visualization
data$stage = "data"
task$stage = "task"
pred_data$stage = "data"
learners$stage = "learner"
resampling$stage = "mlr_settings"
param_set$stage = "mlr_settings"
tune_ctrl$stage = "mlr_settings"
tuning_wrapper$stage = "learner"

all_preproc = suppressWarnings(bind_plans(list(data, task, pred_data, learners,
                              resampling, param_set, tune_ctrl, tuning_wrapper)))
source("scripts/functions.R")
source("scripts/helper-funs.R")

# benchmark ---------------------------------------------------------

# combining all benchmark calls into a single plan
# see https://ropenscilabs.github.io/drake-manual/plans.html#map_plan

args_bm = tibble(task = rlang::syms("tasks"),
                 learner = c(c("wrapper_rf",
                               "wrapper_svm",
                               # "wrapper_xgboost",
                               "wrapper_kknn",
                               "lrn_glm")),
                 resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 4)))
args_bm$learner = rlang::syms(args_bm$learner)
args_bm$id = suppressWarnings(paste0("bm_", str_split(args_bm$learner, "_", simplify = TRUE)[, 2]))

all_bm = map_plan(args_bm, benchmark_custom, trace = FALSE)

all_bm$stage = "benchmark"

benchmark_eval = drake_plan(

  benchmark_evaluation_report = rmarkdown::render(
    knitr_in("scripts/06-Benchmark-eval.Rmd"),
    output_file = file_out("scripts/06-Benchmark-eval.html"),
    quiet = TRUE),
  strings_in_dots = "literals"
)

# prediction --------------------------------------------------------------

args_pred = tibble(task = rlang::syms(c("armillaria_task_dummy",
                            "heterobasidion_task_dummy",
                            "diplodia_task_dummy_prediction",
                            "fusarium_task_dummy_prediction")),
                   learner = c("lrn_rf",
                               "lrn_svm",
                               # "wrapper_xgboost",
                               "lrn_kknn",
                               "lrn_glm"),
                   resampling = rlang::syms(rep("spcv_inner_fiveF", 4)),
                   param_set = rlang::syms(c("ps_rf",
                                             "ps_svm",
                                             # "ps_xgboost",
                                             "ps_kknn",
                                             "NULL")),
                   tune_ctrl = rlang::syms(c("tune_ctrl_rf",
                                             "tune_ctrl_svm",
                                             # "tune_ctrl_xgboost",
                                             "tune_ctrl_kknn",
                                             "NULL")),
                   prediction_data = rep(rlang::syms("pred_data"), 4)
)
args_pred$id = suppressWarnings(paste0("prediction_", str_split(args_pred$learner, "_", simplify = TRUE)[, 2]))
args_pred$learner = rlang::syms(args_pred$learner)

all_pred = map_plan(args_pred, prediction_custom, trace = FALSE)

all_pred$stage = "prediction"

# Combine all -------------------------------------------------------------

plan = bind_plans(list(all_preproc, all_pred, all_bm, benchmark_eval))

plan %<>% mutate(stage = as.factor(stage))

config <- drake_config(plan)


# Visualization -----------------------------------------------------------

### no data grouping
vis_drake_graph(config, group = "stage", clusters = c("task", "learner",
                                                      "mlr_settings",
                                                      "benchmark",
                                                      "prediction"),
                targets_only = TRUE, show_output_files = FALSE)


### all grouping

vis_drake_graph(config, group = "stage", clusters = c("data", "task", "learner",
                                                      "mlr_settings"),
                targets_only = TRUE, show_output_files = FALSE)
sankey_drake_graph(config, group = "stage", clusters = c("data", "task", "learner",
                                                         "mlr_settings"),
                   targets_only = TRUE, show_output_files = FALSE)

drake_ggraph(config, group = "stage", clusters = c("data", "task", "learner",
                                                          "mlr_settings"),
                    targets_only = TRUE, show_output_files = FALSE) + ggpubr::theme_pubr()

# make(plan, keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "bm_glm", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "pred_data", keep_going = TRUE, console_log_file=stdout())
