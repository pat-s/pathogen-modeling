needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr, lwgeom,
      forcats, tibble, rgdal, viridis, rasterVis, lattice, latticeExtra, glue)

# preprocessing -----------------------------------------------------------

data = code_to_plan("scripts/05-prediction/data.R")
pred_data = code_to_plan("scripts/05-prediction/create-prediction-data.R")
task_pred = code_to_plan("scripts/05-prediction/01-Task.R")

task_perf = code_to_plan("scripts/04-performance/01-Task.R")
learners = code_to_plan("scripts/04-performance/02-Learner.R")
resampling = code_to_plan("scripts/04-performance/03-Resampling.R")
param_set = code_to_plan("scripts/04-performance/04-Param-set.R")
tune_ctrl = code_to_plan("scripts/04-performance/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("scripts/04-performance/05-Tuning.R")

all_preproc = bind_plans(list(data, pred_data, task, learners, resampling,
                              param_set, tune_ctrl, tuning_wrapper))
source("scripts/04-performance/functions.R")

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
args_bm$id = paste0("bm_", stringr::str_split(args_bm$learner, "_", simplify = T)[, 2])

all_bm = map_plan(args_bm, benchmark_custom, trace = FALSE)

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
                   pred_data = rep(rlang::syms("pred_data"), 4)
)
args_pred$id = paste0("prediction_", stringr::str_split(args_pred$learner, "_", simplify = T)[, 2])
args_pred$learner = rlang::syms(args_pred$learner)

all_pred = map_plan(args_pred, prediction_custom, trace = FALSE)

# Combine all -------------------------------------------------------------

plan_pred = bind_plans(list(all_preproc, all_pred))

plan = bind_plans(list(all_preproc, all_pred, all_bm, benchmark_eval))

config <- drake_config(plan)
vis_drake_graph(config)

# make(plan, keep_going = TRUE, console_log_file=stdout())
