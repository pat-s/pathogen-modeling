# Plans -----------------------------------------------------------
source("analysis/packages.R")
sourceDirectory("R/")

data_plan = code_to_plan("analysis/data/data.R")
task = code_to_plan("analysis/data/task.R")
learners = code_to_plan("analysis/learner/learner.R")
resampling = code_to_plan("analysis/mlr-settings/resampling.R")
param_set = code_to_plan("analysis/mlr-settings/param-set.R")
tune_ctrl = code_to_plan("analysis/mlr-settings/tune_ctrl_mbo.R")
tuning_wrapper = code_to_plan("analysis/mlr-settings/tuning.R")
visualization = code_to_plan("analysis/visualization/vis-partitions.R")
sourceDirectory("analysis/benchmark/")
sourceDirectory("analysis/prediction/")
sourceDirectory("analysis/reports/")

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
visualization$stage = "visualization"

# Combine all -------------------------------------------------------------

plan = bind_plans(data_plan, task, learners, resampling, param_set,
                  tune_ctrl, tuning_wrapper, benchmark_plan, prediction_prob,
                  prediction_maps, bmr_aggregated,
                  reports, visualization)

plan %<>% mutate(stage = as.factor(stage))

options(
  clustermq.scheduler = "slurm",
  clustermq.template = "~/git/pathogen-modeling/slurm_clustermq.tmpl"
)

### Show log in console
# watch -n .1 tail -n 40 ~/git/pathogen-modeling/drake.log

# drake_config(plan, verbose = 2, targets = c("bm_nsp_nsp_diplodia_gam", "bm_nsp_nsp_diplodia_svm", "bm_sp_sp_diplodia_brt"), console_log_file = "log/drake2.log",
#              lazy_load = "promise", caching = "worker", template = list(log_file = "log/worker2-%a.log", n_cpus= 32),
#              garbage_collection = TRUE, jobs = 3, parallelism = "clustermq")

drake_config(plan, verbose = 2, targets = c("benchmark_evaluation_report_diplodia"), cache_log_file = "log/cache_log.txt",
             lazy_load = "promise", caching = "worker", template = list(log_file = "log/worker%a.log", n_cpus= 32),
             garbage_collection = TRUE, jobs = 3, parallelism = "clustermq")

# drake_config(plan, verbose = 2, targets = "bm_sp_non_diplodia_glm_old", console_log_file = stdout())
