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
args_bm$id = suppressWarnings(paste0("bm_", str_split(args_bm$learner, "_",
                                                      simplify = TRUE)[, 2]))

benchmark = map_plan(args_bm, benchmark_custom, trace = FALSE)

# we need to wrap kknn in try() because some workers will fail which will cause
# whole target to fail
benchmark[3, 2] = "try(benchmark_custom(tasks, wrapper_kknn, spcv_outer_fiveF_hundredR))"

rm(args_bm)
