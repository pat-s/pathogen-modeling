needs(drake, mlr, magrittr, mlrMBO, purrr, parallelMap, sf, dplyr)

# preprocessing -----------------------------------------------------------

task = code_to_plan("scripts/04-performance/01-Task.R")
learners = code_to_plan("scripts/04-performance/02-Learner.R")
resampling = code_to_plan("scripts/04-performance/03-Resampling.R")
param_set = code_to_plan("scripts/04-performance/04-Param-set.R")
tuning_ctrl = code_to_plan("scripts/04-performance/05-Tuning.R")
tasks = drake_plan(tasks = list(armillaria_task_dummy,
                               heterobasidion_task_dummy,
                               diplodia_task_dummy,
                               fusarium_task_dummy)
)

all_preproc = bind_plans(list(task, learners, resampling, param_set, tuning_ctrl,
                              tasks))
source("scripts/04-performance/056-Benchmark-function.R")

# RF ----------------------------------------------------------------------

benchmark_rf = drake_plan(
  bm_ranger = benchmark_custom(task = tasks,
                               learner = wrapper_rf,
                               resampling = spcv_outer_fiveF_hundredR)
)
all_rf = bind_plans(list(all_preproc, benchmark_rf))
# make(all_rf)


# svm ----------------------------------------------------------------------

benchmark_svm = drake_plan(
  bm_svm = benchmark_custom(task = tasks,
                               learner = wrapper_svm,
                               resampling = spcv_outer_fiveF_hundredR)
)
all_svm = bind_plans(list(all_preproc, benchmark_svm))
# make(all_svm)

# xgboost ----------------------------------------------------------------------

benchmark_xgboost = drake_plan(
  bm_xgboost = benchmark_custom(task = tasks,
                               learner = wrapper_xgboost,
                               resampling = spcv_outer_fiveF_hundredR)
)
all_xgboost = bind_plans(list(all_preproc, benchmark_xgboost))
# make(all_xgboost)

# kknn ----------------------------------------------------------------------

benchmark_kknn = drake_plan(
  bm_kknn = benchmark_custom(task = tasks,
                               learner = wrapper_kknn,
                               resampling = spcv_outer_fiveF_hundredR)
)
all_kknn = bind_plans(list(all_preproc, benchmark_kknn))
# make(all_kknn)

# glm ----------------------------------------------------------------------

benchmark_glm = drake_plan(
  bm_glm = benchmark_custom(task = tasks,
                               learner = wrapper_glm,
                               resampling = spcv_outer_fiveF_hundredR)
)
all_glm = bind_plans(list(all_preproc, benchmark_glm))
# make(all_glm)


# Benchmark eval ----------------------------------------------------------

benchmark_eval = drake_plan(

  report = rmarkdown::render(
    knitr_in("scripts/04-performance/06-Benchmark-eval.Rmd"),
    output_file = file_out("scripts/04-performance/06-Benchmark-eval.html"),
    quiet = TRUE),
  strings_in_dots = "literals"
)

all_bm = bind_plans(list(all_preproc, benchmark_rf, benchmark_svm,
                         benchmark_xgboost, benchmark_kknn, benchmark_glm,
                         benchmark_eval))

# Config vis --------------------------------------------------------------

config <- drake_config(all_bm)
vis_drake_graph(config)
