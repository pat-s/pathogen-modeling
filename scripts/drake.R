needs::needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr, lwgeom,
      forcats, tibble, rgdal, viridis, rasterVis, lattice, latticeExtra, glue,
      RSAGA, stringr, GSIF, sp, R.utils, curl, fs)

# Plans -----------------------------------------------------------

data = code_to_plan("scripts/data/data.R")
task = code_to_plan("scripts/data/task.R")
learners = code_to_plan("scripts/learner/learner.R")
resampling = code_to_plan("scripts/mlr-settings/resampling.R")
param_set = code_to_plan("scripts/mlr-settings/param-set.R")
tune_ctrl = code_to_plan("scripts/mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("scripts/mlr-settings/tuning.R")
sourceDirectory("scripts/benchmark/")
sourceDirectory("scripts/prediction/")
sourceDirectory("scripts/reports/")

sourceDirectory("scripts/functions/")
source("https://raw.githubusercontent.com/mlr-org/mlr-extralearner/master/R/RLearner_classif_gam.R")

# grouping for visualization
data$stage = "data"
task$stage = "data"
learners$stage = "learner"
resampling$stage = "mlr_settings"
param_set$stage = "mlr_settings"
tune_ctrl$stage = "mlr_settings"
tuning_wrapper$stage = "learner"
benchmark$stage = "benchmark"
prediction$stage = "prediction"
reports$stage = "reports"

# Combine all -------------------------------------------------------------

plan = bind_plans(data, task, learners, resampling, param_set,
                  tune_ctrl, tuning_wrapper, benchmark, prediction,
                  reports)

plan %<>% mutate(stage = as.factor(stage))

config <- drake_config(plan)


# make(plan, keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "bm_glm", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "pred_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "armillaria_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "slope", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "tasks", keep_going = TRUE, console_log_file=stdout(), jobs = 10)
