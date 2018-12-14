# combining all benchmark calls into a single plan
# see https://ropenscilabs.github.io/drake-manual/plans.html#map_plan

args_bm = tibble(task = rlang::syms("tasks"),
                 learner = c(c("wrapper_rf",
                               "wrapper_svm",
                               "wrapper_xgboost",
                               "wrapper_brt",
                               "wrapper_kknn",
                               "lrn_glm",
                               "lrn_gam_diplodia_perf",
                               "lrn_gam_fusarium_perf",
                               "lrn_gam_armillaria_perf",
                               "lrn_gam_heterobasidion_perf"
                               )),
                 resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 10)))
args_bm$learner = rlang::syms(args_bm$learner)
args_bm$id = suppressWarnings(paste0("bm_", str_split(args_bm$learner, "_",
                                                      simplify = TRUE)[, 2]))
args_bm[7, "id"] = "bm_gam_diplodia"
args_bm[8, "id"] = "bm_gam_fusarium"
args_bm[9, "id"] = "bm_gam_armillaria"
args_bm[10, "id"] = "bm_gam_heterobasidion"

benchmark = map_plan(args_bm, benchmark_custom, trace = FALSE)

# we need to wrap kknn in try() because some workers will fail which will cause
# whole target to fail
benchmark[5, 2] = "try(benchmark_custom(tasks, wrapper_kknn, spcv_outer_fiveF_hundredR))"

rm(args_bm)
