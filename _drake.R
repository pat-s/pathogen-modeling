# Plans -----------------------------------------------------------
source("code/99-packages.R")
sourceDirectory("R/")

data_plan = code_to_plan("code/01-data/data.R")
task_plan = code_to_plan("code/01-data/task.R")
learners_plan = code_to_plan("code/02-mlr-settings/learner.R")
resampling_plan = code_to_plan("code/02-mlr-settings/resampling.R")
param_set_plan = code_to_plan("code/02-mlr-settings/param-set.R")
tune_ctrl_plan = code_to_plan("code/02-mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper_plan = code_to_plan("code/02-mlr-settings/tuning.R")
source("code/03-benchmark/aggregate-results.R")
source("code/03-benchmark/benchmark.R")
source("code/04-prediction/prediction.R")
visualization_plan = code_to_plan("code/05-visualization/vis-partitions.R")
dataset_tables_plan = code_to_plan("code/05-visualization/create_dataset_tables.R")
source("code/06-reports.R")

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

options(clustermq.scheduler = "slurm",
        clustermq.template = "~/papers/2018-model-comparison/slurm_clustermq.tmpl")


### Show log in console
# watch -n .1 tail -n 40 ~/git/pathogen-modeling/drake.log

drake_config(plan,
             verbose = 2,
             targets = c("pathogen_maps_debugging", "prediction_pathogens"),
             lazy_load = "promise",
             console_log_file = "log/drake.log", cache_log_file = "log/cache3.log",
             caching = "worker",
             template = list(log_file = "log/worker%a.log", n_cpus = 10, memory = 60000),
             prework = quote(future::plan(future::multisession, workers = 10)),
             garbage_collection = TRUE, jobs = 1, parallelism = "clustermq",
             lock_envir = FALSE
)
