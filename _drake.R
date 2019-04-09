# Plans -----------------------------------------------------------
source("analysis/99-packages.R")
sourceDirectory("R/")

data_plan = code_to_plan("analysis/data/data.R")
task_plan = code_to_plan("analysis/data/task.R")
learners_plan = code_to_plan("analysis/mlr-settings/learner.R")
resampling_plan = code_to_plan("analysis/mlr-settings/resampling.R")
param_set_plan = code_to_plan("analysis/mlr-settings/param-set.R")
tune_ctrl_plan = code_to_plan("analysis/mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper_plan = code_to_plan("analysis/mlr-settings/tuning.R")
visualization_plan = code_to_plan("analysis/visualization/vis-partitions.R")
dataset_tables_plan = code_to_plan("analysis/visualization/create_dataset_tables.R")
source("analysis/benchmark/aggregate-results.R")
source("analysis/benchmark/benchmark.R")
source("analysis/prediction/prediction.R")
source("analysis/reports/benchmark-eval.R")

source("https://raw.githubusercontent.com/mlr-org/mlr-extralearner/master/R/RLearner_classif_gam.R")

# grouping for visualization
data_plan$stage = "data"
task_plan$stage = "data"
learners_plan$stage = "learner"
resampling_plan$stage = "mlr_settings"
param_set_plan$stage = "mlr_settings"
tune_ctrl_plan$stage = "mlr_settings"
tuning_wrapper_plan$stage = "learner"
benchmark_plan$stage = "benchmark"
bmr_aggr_path_resamp_plan$stage = "benchmark"
bmr_aggr_model_resamp_plan$stage = "benchmark"
no_extract_plan$stage = "benchmark"
bm_all_pathogens_plan$stage = "benchmark"
prediction_prob_plan$stage = "prediction"
prediction_maps_plan$stage = "prediction"
reports_plan$stage = "reports"
visualization_plan$stage = "visualization"
dataset_tables_plan$stage = "visualization"

# Combine all -------------------------------------------------------------

plan = bind_plans(data_plan, task_plan, learners_plan, resampling_plan,
                  param_set_plan, tune_ctrl_plan, tuning_wrapper_plan,

                  bmr_aggr_path_resamp_plan,
                  bmr_aggr_model_resamp_plan,
                  bm_all_pathogens_plan,
                  no_extract_plan,
                  benchmark_plan,

                  prediction_prob_plan,
                  prediction_maps_plan,
                  reports_plan,
                  visualization_plan,
                  dataset_tables_plan)

plan %<>% mutate(stage = as.factor(stage))

options(
  clustermq.scheduler = "slurm",
  clustermq.template = "~/git/pathogen-modeling/slurm_clustermq.tmpl"
)

### Show log in console
# watch -n .1 tail -n 40 ~/git/pathogen-modeling/drake.log

drake_config(plan, verbose = 2)
