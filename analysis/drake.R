needs::needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr, lwgeom,
             forcats, tibble, rgdal, viridis, rasterVis, lattice, latticeExtra, glue,
             RSAGA, stringr, GSIF, sp, R.utils, curl, fs, rgenoud,
             magick, stringr, ggplot2, ggspatial)

# Plans -----------------------------------------------------------

data_plan = code_to_plan("analysis/data/data.R")
task = code_to_plan("analysis/data/task.R")
learners = code_to_plan("analysis/learner/learner.R")
resampling = code_to_plan("analysis/mlr-settings/resampling.R")
param_set = code_to_plan("analysis/mlr-settings/param-set.R")
tune_ctrl = code_to_plan("analysis/mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("analysis/mlr-settings/tuning.R")
sourceDirectory("analysis/benchmark/")
sourceDirectory("analysis/prediction/")
sourceDirectory("analysis/reports/")

sourceDirectory("R/")
source("https://raw.githubusercontent.com/mlr-org/mlr-extralearner/master/R/RLearner_classif_gam.R")

# grouping for visualization
data_plan$stage = "data"
task$stage = "data"
learners$stage = "learner"
resampling$stage = "mlr_settings"
param_set$stage = "mlr_settings"
tune_ctrl$stage = "mlr_settings"
tuning_wrapper$stage = "learner"
benchmark_plan$stage = "benchmark"
bmr_aggregated$stage = "benchmark"
prediction_prob$stage = "prediction"
prediction_maps$stage = "prediction"
reports$stage = "reports"

# Combine all -------------------------------------------------------------

plan = bind_plans(data_plan, task, learners, resampling, param_set,
                  tune_ctrl, tuning_wrapper, benchmark_plan, prediction_prob,
                  prediction_maps, bmr_aggregated,
                  reports)

plan %<>% mutate(stage = as.factor(stage))

config = drake_config(plan)

# make(plan, keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "bm_glm", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "pred_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "armillaria_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "slope", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "tasks", keep_going = TRUE, console_log_file=stdout(), jobs = 10)
