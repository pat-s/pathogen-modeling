needs(mlr, mlrMBO, parallelMap)
configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

# Tasks -------------------------------------------------------------------

armillaria_task = readRDS("/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task.rda")
diplodia_task = readRDS("/data/patrick/mod/pathogen-prediction/01-tasks/diplodia-task.rda")
fusarium_task = readRDS("/data/patrick/mod/pathogen-prediction/01-tasks/fusarium-task.rda")
heterobasidion_task = readRDS("/data/patrick/mod/pathogen-prediction/01-tasks/heterobasidion-task.rda")

# Learners ----------------------------------------------------------------

# lrn_ranger = readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-ranger.rda")
# lrn_xgboost = readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-xgboost.rda")
lrn_svm = readRDS("/data/patrick/mod/pathogen-prediction/02-learners/learner-svm.rda")

# Resampling --------------------------------------------------------------

rdesc_inner = readRDS("/data/patrick/mod/pathogen-prediction/03-resampling/spcv-5iters-1rep.rda")
rdesc_outer= readRDS("/data/patrick/mod/pathogen-prediction/03-resampling/sprepcv-5iters-100rep.rda")

# Param-sets --------------------------------------------------------------

# ps_ranger = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-ranger.rda")
# ps_xg = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-xgboost.rda")
ps_svm = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-svm.rda")

# Tuning ------------------------------------------------------------------

tune_ctrl = readRDS("/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-svm.rda")

# Wrappers ----------------------------------------------------------------

# wrapper_rf <- makeTuneWrapper(
#   lrn_ranger,
#   resampling = inner, par.set = ps_ranger,
#   control = tune_ctrl, show.info = FALSE,
#   measures = list(brier)
# )

# wrapper_xg <- makeTuneWrapper(
#   lrn_xgboost,
#   resampling = inner, par.set = ps_xg,
#   control = tune_ctrl, show.info = FALSE,
#   measures = list(brier)
# )
# 
wrapper_svm <- makeTuneWrapper(
  lrn_svm,
  resampling = rdesc_inner, par.set = ps_svm,
  control = tune_ctrl, show.info = TRUE,
  measures = list(brier)
)

# Benchmark ---------------------------------------------------------------

tasks = list(armillaria_task, heterobasidion_task, diplodia_task, fusarium_task)

parallelStart(mode = "multicore", cpus = 30, level = "mlrMBO.feval",
              mc.set.seed = TRUE)
set.seed(12345, kind = "L'Ecuyer-CMRG")

bmr <- benchmark(wrapper_svm, tasks, models = FALSE,
                 resampling = rdesc_outer,
                 show.info = TRUE, measures = list(brier))

parallelStop()
saveRDS(bmr, "/data/patrick/mod/pathogen-prediction/06-benchmark/svm-all-pathogens.rda")
