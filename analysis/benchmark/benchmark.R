# combining all benchmark calls into a single plan
# see https://ropenscilabs.github.io/drake-manual/plans.html#map_plan

# sp/sp -------------------------------------------------------------------

args_bm_sp_sp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy"),
                       learner = c(c("wrapper_rf_sp",
                                     "wrapper_svm_sp",
                                     "wrapper_xgboost_sp",
                                     "wrapper_brt_sp",
                                     "wrapper_kknn_sp",
                                     "wrapper_gam_armillaria_perf_sp"
                       )),
                       resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_sp_armillaria$learner = rlang::syms(args_bm_sp_sp_armillaria$learner)
args_bm_sp_sp_armillaria$id = suppressWarnings(paste0("bm_sp_sp_armillaria_", str_split(args_bm_sp_sp_armillaria$learner, "_",
                                                                  simplify = TRUE)[, 2]))

args_bm_sp_sp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy"),
                                  learner = c(c("wrapper_rf_sp",
                                                "wrapper_svm_sp",
                                                "wrapper_xgboost_sp",
                                                "wrapper_brt_sp",
                                                "wrapper_kknn_sp",
                                                "wrapper_gam_diplodia_perf_sp"
                                  )),
                                  resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_sp_diplodia$learner = rlang::syms(args_bm_sp_sp_diplodia$learner)
args_bm_sp_sp_diplodia$id = suppressWarnings(paste0("bm_sp_sp_diplodia_", str_split(args_bm_sp_sp_diplodia$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_sp_sp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy"),
                                  learner = c(c("wrapper_rf_sp",
                                                "wrapper_svm_sp",
                                                "wrapper_xgboost_sp",
                                                "wrapper_brt_sp",
                                                "wrapper_kknn_sp",
                                                "wrapper_gam_fusarium_perf_sp"
                                  )),
                                  resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_sp_fusarium$learner = rlang::syms(args_bm_sp_sp_fusarium$learner)
args_bm_sp_sp_fusarium$id = suppressWarnings(paste0("bm_sp_sp_fusarium_", str_split(args_bm_sp_sp_fusarium$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_sp_sp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy"),
                                  learner = c(c("wrapper_rf_sp",
                                                "wrapper_svm_sp",
                                                "wrapper_xgboost_sp",
                                                "wrapper_brt_sp",
                                                "wrapper_kknn_sp",
                                                "wrapper_gam_heterobasidion_perf_sp"
                                  )),
                                  resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_sp_heterobasidion$learner = rlang::syms(args_bm_sp_sp_heterobasidion$learner)
args_bm_sp_sp_heterobasidion$id = suppressWarnings(paste0("bm_sp_sp_heterobasidion_", str_split(args_bm_sp_sp_heterobasidion$learner, "_",
                                                                                        simplify = TRUE)[, 2]))


# sp/nsp ------------------------------------------------------------------

args_bm_sp_nsp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy"),
                                  learner = c(c("wrapper_rf_nsp",
                                                "wrapper_svm_nsp",
                                                "wrapper_xgboost_nsp",
                                                "wrapper_brt_nsp",
                                                "wrapper_kknn_nsp",
                                                "wrapper_gam_armillaria_perf_nsp"
                                  )),
                                  resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_nsp_armillaria$learner = rlang::syms(args_bm_sp_nsp_armillaria$learner)
args_bm_sp_nsp_armillaria$id = suppressWarnings(paste0("bm_sp_nsp_armillaria_", str_split(args_bm_sp_nsp_armillaria$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_sp_nsp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy"),
                                learner = c(c("wrapper_rf_nsp",
                                              "wrapper_svm_nsp",
                                              "wrapper_xgboost_nsp",
                                              "wrapper_brt_nsp",
                                              "wrapper_kknn_nsp",
                                              "wrapper_gam_diplodia_perf_nsp"
                                )),
                                resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_nsp_diplodia$learner = rlang::syms(args_bm_sp_nsp_diplodia$learner)
args_bm_sp_nsp_diplodia$id = suppressWarnings(paste0("bm_sp_nsp_diplodia_", str_split(args_bm_sp_nsp_diplodia$learner, "_",
                                                                                    simplify = TRUE)[, 2]))

args_bm_sp_nsp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy"),
                                learner = c(c("wrapper_rf_nsp",
                                              "wrapper_svm_nsp",
                                              "wrapper_xgboost_nsp",
                                              "wrapper_brt_nsp",
                                              "wrapper_kknn_nsp",
                                              "wrapper_gam_fusarium_perf_nsp"
                                )),
                                resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_nsp_fusarium$learner = rlang::syms(args_bm_sp_nsp_fusarium$learner)
args_bm_sp_nsp_fusarium$id = suppressWarnings(paste0("bm_sp_nsp_fusarium_", str_split(args_bm_sp_nsp_fusarium$learner, "_",
                                                                                    simplify = TRUE)[, 2]))

args_bm_sp_nsp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy"),
                                      learner = c(c("wrapper_rf_nsp",
                                                    "wrapper_svm_nsp",
                                                    "wrapper_xgboost_nsp",
                                                    "wrapper_brt_nsp",
                                                    "wrapper_kknn_nsp",
                                                    "wrapper_gam_heterobasidion_perf_nsp"
                                      )),
                                      resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_sp_nsp_heterobasidion$learner = rlang::syms(args_bm_sp_nsp_heterobasidion$learner)
args_bm_sp_nsp_heterobasidion$id = suppressWarnings(paste0("bm_sp_nsp_heterobasidion_", str_split(args_bm_sp_nsp_heterobasidion$learner, "_",
                                                                                                simplify = TRUE)[, 2]))


# sp/non ------------------------------------------------------------------

args_bm_sp_non_armillaria = tibble(task = rlang::syms("armillaria_task_dummy"),
                        learner = c(c("lrn_rf",
                                      "lrn_svm",
                                      "lrn_xgboost",
                                      "lrn_brt",
                                      "lrn_kknn",
                                      "lrn_glm",
                                      "lrn_gam_armillaria_perf_non"
                        )),
                        resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_armillaria$learner = rlang::syms(args_bm_sp_non_armillaria$learner)
args_bm_sp_non_armillaria$id = suppressWarnings(paste0("bm_sp_non_armillaria_", str_split(args_bm_sp_non_armillaria$learner, "_",
                                                                    simplify = TRUE)[, 2]))

args_bm_sp_non_diplodia = tibble(task = rlang::syms("diplodia_task_dummy"),
                                   learner = c(c("lrn_rf",
                                                 "lrn_svm",
                                                 "lrn_xgboost",
                                                 "lrn_brt",
                                                 "lrn_kknn",
                                                 "lrn_glm",
                                                 "lrn_gam_diplodia_perf_non"
                                   )),
                                   resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_diplodia$learner = rlang::syms(args_bm_sp_non_diplodia$learner)
args_bm_sp_non_diplodia$id = suppressWarnings(paste0("bm_sp_non_diplodia_", str_split(args_bm_sp_non_diplodia$learner, "_",
                                                                                          simplify = TRUE)[, 2]))

args_bm_sp_non_fusarium = tibble(task = rlang::syms("fusarium_task_dummy"),
                                   learner = c(c("lrn_rf",
                                                 "lrn_svm",
                                                 "lrn_xgboost",
                                                 "lrn_brt",
                                                 "lrn_kknn",
                                                 "lrn_glm",
                                                 "lrn_gam_fusarium_perf_non"
                                   )),
                                   resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_fusarium$learner = rlang::syms(args_bm_sp_non_fusarium$learner)
args_bm_sp_non_fusarium$id = suppressWarnings(paste0("bm_sp_non_fusarium_", str_split(args_bm_sp_non_fusarium$learner, "_",
                                                                                          simplify = TRUE)[, 2]))

args_bm_sp_non_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy"),
                                   learner = c(c("lrn_rf",
                                                 "lrn_svm",
                                                 "lrn_xgboost",
                                                 "lrn_brt",
                                                 "lrn_kknn",
                                                 "lrn_glm",
                                                 "lrn_gam_heterobasidion_perf_non"
                                   )),
                                   resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_heterobasidion$learner = rlang::syms(args_bm_sp_non_heterobasidion$learner)
args_bm_sp_non_heterobasidion$id = suppressWarnings(paste0("bm_sp_non_heterobasidion_", str_split(args_bm_sp_non_heterobasidion$learner, "_",
                                                                                          simplify = TRUE)[, 2]))

# nsp/nsp ------------------------------------------------------------------

args_bm_nsp_nsp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy"),
                                  learner = c(c("wrapper_rf_nsp",
                                                "wrapper_svm_nsp",
                                                "wrapper_xgboost_nsp",
                                                "wrapper_brt_nsp",
                                                "wrapper_kknn_nsp",
                                                "wrapper_gam_armillaria_perf_nsp"
                                  )),
                                  resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_armillaria$learner = rlang::syms(args_bm_nsp_nsp_armillaria$learner)
args_bm_nsp_nsp_armillaria$id = suppressWarnings(paste0("bm_nsp_nsp_armillaria_", str_split(args_bm_nsp_nsp_armillaria$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_nsp_nsp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy"),
                                learner = c(c("wrapper_rf_nsp",
                                              "wrapper_svm_nsp",
                                              "wrapper_xgboost_nsp",
                                              "wrapper_brt_nsp",
                                              "wrapper_kknn_nsp",
                                              "wrapper_gam_diplodia_perf_nsp"
                                )),
                                resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_diplodia$learner = rlang::syms(args_bm_nsp_nsp_diplodia$learner)
args_bm_nsp_nsp_diplodia$id = suppressWarnings(paste0("bm_nsp_nsp_diplodia_", str_split(args_bm_nsp_nsp_diplodia$learner, "_",
                                                                                    simplify = TRUE)[, 2]))

args_bm_nsp_nsp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy"),
                                learner = c(c("wrapper_rf_nsp",
                                              "wrapper_svm_nsp",
                                              "wrapper_xgboost_nsp",
                                              "wrapper_brt_nsp",
                                              "wrapper_kknn_nsp",
                                              "wrapper_gam_fusarium_perf_nsp"
                                )),
                                resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_fusarium$learner = rlang::syms(args_bm_nsp_nsp_fusarium$learner)
args_bm_nsp_nsp_fusarium$id = suppressWarnings(paste0("bm_nsp_nsp_fusarium_", str_split(args_bm_nsp_nsp_fusarium$learner, "_",
                                                                                    simplify = TRUE)[, 2]))

args_bm_nsp_nsp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy"),
                                      learner = c(c("wrapper_rf_nsp",
                                                    "wrapper_svm_nsp",
                                                    "wrapper_xgboost_nsp",
                                                    "wrapper_brt_nsp",
                                                    "wrapper_kknn_nsp",
                                                    "wrapper_gam_heterobasidion_perf_nsp"
                                      )),
                                      resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_heterobasidion$learner = rlang::syms(args_bm_nsp_nsp_heterobasidion$learner)
args_bm_nsp_nsp_heterobasidion$id = suppressWarnings(paste0("bm_nsp_nsp_heterobasidion_", str_split(args_bm_nsp_nsp_heterobasidion$learner, "_",
                                                                                                simplify = TRUE)[, 2]))

# nsp/non ------------------------------------------------------------------

args_bm_nsp_non_armillaria = tibble(task = rlang::syms("armillaria_task_dummy"),
                                   learner = c(c("lrn_rf",
                                                 "lrn_svm",
                                                 "lrn_xgboost",
                                                 "lrn_brt",
                                                 "lrn_kknn",
                                                 "lrn_glm",
                                                 "lrn_gam_armillaria_perf_non"
                                   )),
                                   resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_armillaria$learner = rlang::syms(args_bm_nsp_non_armillaria$learner)
args_bm_nsp_non_armillaria$id = suppressWarnings(paste0("bm_nsp_non_armillaria_", str_split(args_bm_nsp_non_armillaria$learner, "_",
                                                                                          simplify = TRUE)[, 2]))

args_bm_nsp_non_diplodia = tibble(task = rlang::syms("diplodia_task_dummy"),
                                 learner = c(c("lrn_rf",
                                               "lrn_svm",
                                               "lrn_xgboost",
                                               "lrn_brt",
                                               "lrn_kknn",
                                               "lrn_glm",
                                               "lrn_gam_diplodia_perf_non"
                                 )),
                                 resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_diplodia$learner = rlang::syms(args_bm_nsp_non_diplodia$learner)
args_bm_nsp_non_diplodia$id = suppressWarnings(paste0("bm_nsp_non_diplodia_", str_split(args_bm_nsp_non_diplodia$learner, "_",
                                                                                      simplify = TRUE)[, 2]))

args_bm_nsp_non_fusarium = tibble(task = rlang::syms("fusarium_task_dummy"),
                                 learner = c(c("lrn_rf",
                                               "lrn_svm",
                                               "lrn_xgboost",
                                               "lrn_brt",
                                               "lrn_kknn",
                                               "lrn_glm",
                                               "lrn_gam_fusarium_perf_non"
                                 )),
                                 resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_fusarium$learner = rlang::syms(args_bm_nsp_non_fusarium$learner)
args_bm_nsp_non_fusarium$id = suppressWarnings(paste0("bm_nsp_non_fusarium_", str_split(args_bm_nsp_non_fusarium$learner, "_",
                                                                                      simplify = TRUE)[, 2]))

args_bm_nsp_non_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy"),
                                       learner = c(c("lrn_rf",
                                                     "lrn_svm",
                                                     "lrn_xgboost",
                                                     "lrn_brt",
                                                     "lrn_kknn",
                                                     "lrn_glm",
                                                     "lrn_gam_heterobasidion_perf_non"
                                       )),
                                       resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_heterobasidion$learner = rlang::syms(args_bm_nsp_non_heterobasidion$learner)
args_bm_nsp_non_heterobasidion$id = suppressWarnings(paste0("bm_nsp_non_heterobasidion_", str_split(args_bm_nsp_non_heterobasidion$learner, "_",
                                                                                                  simplify = TRUE)[, 2]))

# combine -----------------------------------------------------------------

benchmark_sp_sp_armillaria = map_plan(args_bm_sp_sp_armillaria, benchmark_custom, trace = FALSE)
benchmark_sp_sp_diplodia = map_plan(args_bm_sp_sp_diplodia, benchmark_custom, trace = FALSE)
benchmark_sp_sp_fusarium = map_plan(args_bm_sp_sp_fusarium, benchmark_custom, trace = FALSE)
benchmark_sp_sp_heterobasidion = map_plan(args_bm_sp_sp_heterobasidion, benchmark_custom, trace = FALSE)

benchmark_sp_nsp_armillaria = map_plan(args_bm_sp_nsp_armillaria, benchmark_custom, trace = FALSE)
benchmark_sp_nsp_diplodia = map_plan(args_bm_sp_nsp_diplodia, benchmark_custom, trace = FALSE)
benchmark_sp_nsp_fusarium = map_plan(args_bm_sp_nsp_fusarium, benchmark_custom, trace = FALSE)
benchmark_sp_nsp_heterobasidion = map_plan(args_bm_sp_nsp_heterobasidion, benchmark_custom, trace = FALSE)

benchmark_sp_non_armillaria = map_plan(args_bm_sp_non_armillaria, benchmark_custom, trace = FALSE)
benchmark_sp_non_diplodia = map_plan(args_bm_sp_non_diplodia, benchmark_custom, trace = FALSE)
benchmark_sp_non_fusarium = map_plan(args_bm_sp_non_fusarium, benchmark_custom, trace = FALSE)
benchmark_sp_non_heterobasidion = map_plan(args_bm_sp_non_heterobasidion, benchmark_custom, trace = FALSE)

benchmark_nsp_nsp_armillaria = map_plan(args_bm_nsp_nsp_armillaria, benchmark_custom, trace = FALSE)
benchmark_nsp_nsp_diplodia = map_plan(args_bm_nsp_nsp_diplodia, benchmark_custom, trace = FALSE)
benchmark_nsp_nsp_fusarium = map_plan(args_bm_nsp_nsp_fusarium, benchmark_custom, trace = FALSE)
benchmark_nsp_nsp_heterobasidion = map_plan(args_bm_nsp_nsp_heterobasidion, benchmark_custom, trace = FALSE)

benchmark_nsp_non_armillaria = map_plan(args_bm_nsp_non_armillaria, benchmark_custom, trace = FALSE)
benchmark_nsp_non_diplodia = map_plan(args_bm_nsp_non_diplodia, benchmark_custom, trace = FALSE)
benchmark_nsp_non_fusarium = map_plan(args_bm_nsp_non_fusarium, benchmark_custom, trace = FALSE)
benchmark_nsp_non_heterobasidion = map_plan(args_bm_nsp_non_heterobasidion, benchmark_custom, trace = FALSE)

benchmark_plan = bind_plans(benchmark_sp_sp_armillaria, benchmark_sp_sp_diplodia, benchmark_sp_sp_fusarium, benchmark_sp_sp_heterobasidion,
                            benchmark_sp_nsp_armillaria, benchmark_sp_nsp_diplodia, benchmark_sp_nsp_fusarium, benchmark_sp_nsp_heterobasidion,
                            benchmark_sp_non_armillaria, benchmark_sp_non_diplodia, benchmark_sp_non_fusarium, benchmark_sp_non_heterobasidion,
                            benchmark_nsp_nsp_armillaria, benchmark_nsp_nsp_diplodia, benchmark_nsp_nsp_fusarium, benchmark_nsp_nsp_heterobasidion,
                            benchmark_nsp_non_armillaria, benchmark_nsp_non_diplodia, benchmark_nsp_non_fusarium, benchmark_nsp_non_heterobasidion
)

# we need to wrap kknn in try() because some workers will fail which will cause the
# whole target to fail
#benchmark_plan[5, 2] = "try(benchmark_custom(tasks, wrapper_kknn_sp, spcv_outer_fiveF_hundredR))"
#benchmark_plan[30, 2] = "try(benchmark_custom(task = tasks, learner = wrapper_svm_nsp, resampling = cv_outer_fiveF_hundredR))"

### kknn adjustments:
### kknn runs out of memory with 32 cores so we just use 16 cores (implemented in `benchmark_custom_cores()`)

# sp sp
benchmark_plan[benchmark_plan$target == "bm_sp_sp_armillaria_kknn", 2] = "benchmark_custom_cores(task = armillaria_task_dummy, learner = wrapper_kknn_sp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_sp_diplodia_kknn", 2] = "benchmark_custom_cores(task = diplodia_task_dummy, learner = wrapper_kknn_sp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_sp_fusarium_kknn", 2] = "benchmark_custom_cores(task = fusarium_task_dummy, learner = wrapper_kknn_sp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_sp_heterobasidion_kknn", 2] = "benchmark_custom_cores(task = heterobasidion_task_dummy, learner = wrapper_kknn_sp, resampling = spcv_outer_fiveF_hundredR)"
# benchmark_plan[7, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[8, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[9, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
# # sp nsp

benchmark_plan[benchmark_plan$target == "bm_sp_nsp_armillaria_kknn", 2] = "benchmark_custom_cores(task = armillaria_task_dummy, learner = wrapper_kknn_nsp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_nsp_diplodia_kknn", 2] = "benchmark_custom_cores(task = diplodia_task_dummy, learner = wrapper_kknn_nsp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_nsp_fusarium_kknn", 2] = "benchmark_custom_cores(task = fusarium_task_dummy, learner = wrapper_kknn_nsp, resampling = spcv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_sp_nsp_heterobasidion_kknn", 2] = "benchmark_custom_cores(task = heterobasidion_task_dummy, learner = wrapper_kknn_nsp, resampling = spcv_outer_fiveF_hundredR)"

# benchmark_plan[15, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = wrapper_gam_diplodia_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[16, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[17, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[18, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
# # sp non
# benchmark_plan[25, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = lrn_gam_diplodia_perf_non, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[26, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = lrn_gam_fusarium_perf_non, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[27, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = spcv_outer_fiveF_hundredR))"
# benchmark_plan[28, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = spcv_outer_fiveF_hundredR))"
# # nsp nsp

benchmark_plan[benchmark_plan$target == "bm_nsp_nsp_armillaria_kknn", 2] = "benchmark_custom_cores(task = armillaria_task_dummy, learner = wrapper_kknn_nsp, resampling = cv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_nsp_nsp_diplodia_kknn", 2] = "benchmark_custom_cores(task = diplodia_task_dummy, learner = wrapper_kknn_nsp, resampling = cv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_nsp_nsp_fusarium_kknn", 2] = "benchmark_custom_cores(task = fusarium_task_dummy, learner = wrapper_kknn_nsp, resampling = cv_outer_fiveF_hundredR)"
benchmark_plan[benchmark_plan$target == "bm_nsp_nsp_heterobasidion_kknn", 2] = "benchmark_custom_cores(task = heterobasidion_task_dummy, learner = wrapper_kknn_nsp, resampling = cv_outer_fiveF_hundredR)"
# benchmark_plan[34, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = wrapper_gam_diplodia_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[35, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[36, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[37, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
# # nsp non
# benchmark_plan[44, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = lrn_gam_diplodia_perf_non, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[45, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = lrn_gam_fusarium_perf_non, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[46, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = cv_outer_fiveF_hundredR))"
# benchmark_plan[47, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = cv_outer_fiveF_hundredR))"

rm(list=ls(pattern="args_"))
