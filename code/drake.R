needs::needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr, lwgeom,
             forcats, tibble, rgdal, viridis, rasterVis, lattice, latticeExtra, glue,
             RSAGA, stringr, GSIF, sp, R.utils, curl, fs)

# Plans -----------------------------------------------------------

data = code_to_plan("code/data/data.R")
task = code_to_plan("code/data/task.R")
learners = code_to_plan("code/learner/learner.R")
resampling = code_to_plan("code/mlr-settings/resampling.R")
param_set = code_to_plan("code/mlr-settings/param-set.R")
tune_ctrl = code_to_plan("code/mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("code/mlr-settings/tuning.R")
sourceDirectory("code/benchmark/")
sourceDirectory("code/prediction/")
sourceDirectory("code/reports/")

sourceDirectory("code/functions/")
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

plan_no_reports = bind_plans(data, task, learners, resampling, param_set,
                             tune_ctrl, tuning_wrapper, benchmark, prediction)
# For debugging target invalidation issues: https://github.com/ropensci/drake/issues/615
plan_no_reports$command <- paste(
  "{return(TRUE)\n {",
  plan_no_reports$command,
  "}}"
)

plan2 <- bind_plans(plan_no_reports, reports)




plan = bind_plans(data, task, learners, resampling, param_set,
                  tune_ctrl, tuning_wrapper, benchmark, prediction,
                  reports)

plan %<>% mutate(stage = as.factor(stage))

config = drake_config(plan)
config2 = drake_config(plan2)


# make(plan, keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "bm_glm", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "pred_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "armillaria_data", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "slope", keep_going = TRUE, console_log_file=stdout())

# make(plan, targets = "tasks", keep_going = TRUE, console_log_file=stdout(), jobs = 10)
