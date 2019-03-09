suppressPackageStartupMessages(library(drake))
suppressPackageStartupMessages(library(mlr))
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(mlrMBO))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(parallelMap))
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(lwgeom))
suppressPackageStartupMessages(library(forcats))
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(viridis))
suppressPackageStartupMessages(library(rasterVis))
suppressPackageStartupMessages(library(lattice))
suppressPackageStartupMessages(library(latticeExtra))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(RSAGA))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(GSIF))
suppressPackageStartupMessages(library(sp))
suppressPackageStartupMessages(library(R.utils))
suppressPackageStartupMessages(library(curl))
suppressPackageStartupMessages(library(fs))
suppressPackageStartupMessages(library(rgenoud))
suppressPackageStartupMessages(library(magick))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(ggspatial))
suppressPackageStartupMessages(library(clustermq))
suppressPackageStartupMessages(library(ggsci))
suppressPackageStartupMessages(library(furrr))
suppressPackageStartupMessages(library(future.callr))
suppressPackageStartupMessages(library(ggpubr))
suppressPackageStartupMessages(library(hrbrthemes))

# Plans -----------------------------------------------------------

sourceDirectory("R/")

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

options(
  clustermq.scheduler = "slurm",
  clustermq.template = "~/git/pathogen-modeling/slurm_clustermq.tmpl"
)

### Show log in console
# watch -n .1 tail -n 40 ~/git/pathogen-modeling/drake.log

# drake_config(plan, verbose = 2, targets = c("bm_sp_non_diplodia_glm_old"), console_log_file = "drake2.log",
#              lazy_load = "promise", caching = "worker", template = list(log_file = "log-glm.txt", n_cpus= 8),
#              garbage_collection = TRUE, jobs = 1, parallelism = "clustermq", force = T)

drake_config(plan, verbose = 2, targets = c("benchmark_evaluation_report_diplodia"), cache_log_file = "log/cache_log.txt",
             lazy_load = "promise", caching = "worker", template = list(log_file = "log/worker%a.log", n_cpus= 32),
             garbage_collection = TRUE, jobs = 3, parallelism = "clustermq")

# drake_config(plan, verbose = 2, targets = "bm_sp_non_diplodia_glm_old", console_log_file = stdout())
