# combining all benchmark calls into a single plan
# see https://ropenscilabs.github.io/drake-manual/plans.html#map_plan

# sp/sp -------------------------------------------------------------------

args_bm_sp_sp = tibble(task = rlang::syms("tasks"),
                       learner = c(c("wrapper_rf_sp",
                                     "wrapper_svm_sp",
                                     "wrapper_xgboost_sp",
                                     "wrapper_brt_sp",
                                     "wrapper_kknn_sp",
                                     "wrapper_gam_diplodia_perf_sp",
                                     "wrapper_gam_fusarium_perf_sp",
                                     "wrapper_gam_armillaria_perf_sp",
                                     "wrapper_gam_heterobasidion_perf_sp"
                       )),
                       resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 9)))
args_bm_sp_sp$learner = rlang::syms(args_bm_sp_sp$learner)
args_bm_sp_sp$id = suppressWarnings(paste0("bm_sp_sp_", str_split(args_bm_sp_sp$learner, "_",
                                                                  simplify = TRUE)[, 2]))
args_bm_sp_sp[6, "id"] = "bm_sp_sp_gam_diplodia"
args_bm_sp_sp[7, "id"] = "bm_sp_sp_gam_fusarium"
args_bm_sp_sp[8, "id"] = "bm_sp_sp_gam_armillaria"
args_bm_sp_sp[9, "id"] = "bm_sp_sp_gam_heterobasidion"


# sp/nsp ------------------------------------------------------------------

args_bm_sp_nsp = tibble(task = rlang::syms("tasks"),
                        learner = c(c("wrapper_rf_nsp",
                                      "wrapper_svm_nsp",
                                      "wrapper_xgboost_nsp",
                                      "wrapper_brt_nsp",
                                      "wrapper_kknn_nsp",
                                      "wrapper_gam_diplodia_perf_nsp",
                                      "wrapper_gam_fusarium_perf_nsp",
                                      "wrapper_gam_armillaria_perf_nsp",
                                      "wrapper_gam_heterobasidion_perf_nsp"
                        )),
                        resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 9)))
args_bm_sp_nsp$learner = rlang::syms(args_bm_sp_nsp$learner)
args_bm_sp_nsp$id = suppressWarnings(paste0("bm_sp_nsp_", str_split(args_bm_sp_nsp$learner, "_",
                                                                    simplify = TRUE)[, 2]))
args_bm_sp_nsp[6, "id"] = "bm_sp_nsp_gam_diplodia"
args_bm_sp_nsp[7, "id"] = "bm_sp_nsp_gam_fusarium"
args_bm_sp_nsp[8, "id"] = "bm_sp_nsp_gam_armillaria"
args_bm_sp_nsp[9, "id"] = "bm_sp_nsp_gam_heterobasidion"


# sp/non ------------------------------------------------------------------

args_bm_sp_non = tibble(task = rlang::syms("tasks"),
                        learner = c(c("lrn_rf",
                                      "lrn_svm",
                                      "lrn_xgboost",
                                      "lrn_brt",
                                      "lrn_kknn",
                                      "lrn_glm",
                                      "lrn_gam_diplodia_perf_non",
                                      "lrn_gam_fusarium_perf_non",
                                      "lrn_gam_armillaria_perf_non",
                                      "lrn_gam_heterobasidion_perf_non"
                        )),
                        resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 10)))
args_bm_sp_non$learner = rlang::syms(args_bm_sp_non$learner)
args_bm_sp_non$id = suppressWarnings(paste0("bm_sp_non_", str_split(args_bm_sp_non$learner, "_",
                                                                    simplify = TRUE)[, 2]))
args_bm_sp_non[7, "id"] = "bm_sp_non_gam_diplodia"
args_bm_sp_non[8, "id"] = "bm_sp_non_gam_fusarium"
args_bm_sp_non[9, "id"] = "bm_sp_non_gam_armillaria"
args_bm_sp_non[10, "id"] = "bm_sp_non_gam_heterobasidion"

# nsp/nsp ------------------------------------------------------------------

args_bm_nsp_nsp = tibble(task = rlang::syms("tasks"),
                         learner = c(c("wrapper_rf_nsp",
                                       "wrapper_svm_nsp",
                                       "wrapper_xgboost_nsp",
                                       "wrapper_brt_nsp",
                                       "wrapper_kknn_nsp",
                                       "wrapper_gam_diplodia_perf_nsp",
                                       "wrapper_gam_fusarium_perf_nsp",
                                       "wrapper_gam_armillaria_perf_nsp",
                                       "wrapper_gam_heterobasidion_perf_nsp"
                         )),
                         resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 9)))
args_bm_nsp_nsp$learner = rlang::syms(args_bm_nsp_nsp$learner)
args_bm_nsp_nsp$id = suppressWarnings(paste0("bm_nsp_nsp_", str_split(args_bm_nsp_nsp$learner, "_",
                                                                      simplify = TRUE)[, 2]))
args_bm_nsp_nsp[6, "id"] = "bm_nsp_nsp_gam_diplodia"
args_bm_nsp_nsp[7, "id"] = "bm_nsp_nsp_gam_fusarium"
args_bm_nsp_nsp[8, "id"] = "bm_nsp_nsp_gam_armillaria"
args_bm_nsp_nsp[9, "id"] = "bm_nsp_nsp_gam_heterobasidion"

# nsp/non ------------------------------------------------------------------

args_bm_nsp_non = tibble(task = rlang::syms("tasks"),
                         learner = c(c("lrn_rf",
                                       "lrn_svm",
                                       "lrn_xgboost",
                                       "lrn_brt",
                                       "lrn_kknn",
                                       "lrn_glm",
                                       "lrn_gam_diplodia_perf_non",
                                       "lrn_gam_fusarium_perf_non",
                                       "lrn_gam_armillaria_perf_non",
                                       "lrn_gam_heterobasidion_perf_non"
                         )),
                         resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 10)))
args_bm_nsp_non$learner = rlang::syms(args_bm_nsp_non$learner)
args_bm_nsp_non$id = suppressWarnings(paste0("bm_nsp_non_", str_split(args_bm_nsp_non$learner, "_",
                                                                      simplify = TRUE)[, 2]))
args_bm_nsp_non[7, "id"] = "bm_nsp_non_gam_diplodia"
args_bm_nsp_non[8, "id"] = "bm_nsp_non_gam_fusarium"
args_bm_nsp_non[9, "id"] = "bm_nsp_non_gam_armillaria"
args_bm_nsp_non[10, "id"] = "bm_nsp_non_gam_heterobasidion"

args_bm_nsp_non[7, "id"] = "bm_nsp_non_gam_diplodia"
args_bm_nsp_non[8, "id"] = "bm_nsp_non_gam_fusarium"
args_bm_nsp_non[9, "id"] = "bm_nsp_non_gam_armillaria"
args_bm_nsp_non[10, "id"] = "bm_nsp_non_gam_heterobasidion"

# combine -----------------------------------------------------------------

benchmark_sp_sp = map_plan(args_bm_sp_sp, benchmark_custom, trace = FALSE)
benchmark_sp_nsp = map_plan(args_bm_sp_nsp, benchmark_custom, trace = FALSE)
benchmark_sp_non = map_plan(args_bm_sp_non, benchmark_custom, trace = FALSE)
benchmark_nsp_nsp = map_plan(args_bm_nsp_nsp, benchmark_custom, trace = FALSE)
benchmark_nsp_non = map_plan(args_bm_nsp_non, benchmark_custom, trace = FALSE)

benchmark_plan = bind_plans(benchmark_sp_sp, benchmark_sp_nsp, benchmark_sp_non,
                            benchmark_nsp_nsp, benchmark_nsp_non)

# we need to wrap kknn in try() because some workers will fail which will cause the
# whole target to fail
benchmark_plan[5, 2] = "try(benchmark_custom(tasks, wrapper_kknn_sp, spcv_outer_fiveF_hundredR))"
benchmark_plan[30, 2] = "try(benchmark_custom(task = tasks, learner = wrapper_svm_nsp, resampling = cv_outer_fiveF_hundredR))"

### gam adjustments:
### the formula in the custom gam learner only applies to one task,
###  there needs to be one learner per task. This is an mlr issue.

# sp sp
benchmark_plan[6, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = wrapper_gam_diplodia_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[7, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[8, 2] = "try(benchmark_custom(task = armillaria_task_dummy, learner = wrapper_gam_armillaria_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[9, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_sp, resampling = spcv_outer_fiveF_hundredR))"
# sp nsp
benchmark_plan[15, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = wrapper_gam_diplodia_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[16, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[17, 2] = "try(benchmark_custom(task = armillaria_task_dummy, learner = wrapper_gam_armillaria_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[18, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = spcv_outer_fiveF_hundredR))"
# sp non
benchmark_plan[25, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = lrn_gam_diplodia_perf_non, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[26, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = lrn_gam_fusarium_perf_non, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[27, 2] = "try(benchmark_custom(task = armillaria_task_dummy, learner = lrn_gam_armillaria_perf_non, resampling = spcv_outer_fiveF_hundredR))"
benchmark_plan[28, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = spcv_outer_fiveF_hundredR))"
# nsp nsp
benchmark_plan[34, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = wrapper_gam_diplodia_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[35, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = wrapper_gam_fusarium_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[36, 2] = "try(benchmark_custom(task = armillaria_task_dummy, learner = wrapper_gam_armillaria_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[37, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = wrapper_gam_heterobasidion_perf_nsp, resampling = cv_outer_fiveF_hundredR))"
# nsp non
benchmark_plan[44, 2] = "try(benchmark_custom(task = diplodia_task_dummy, learner = lrn_gam_diplodia_perf_non, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[45, 2] = "try(benchmark_custom(task = fusarium_task_dummy, learner = lrn_gam_fusarium_perf_non, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[46, 2] = "try(benchmark_custom(task = armillaria_task_dummy, learner = lrn_gam_armillaria_perf_non, resampling = cv_outer_fiveF_hundredR))"
benchmark_plan[47, 2] = "try(benchmark_custom(task = heterobasidion_task_dummy, learner = lrn_gam_heterobasidion_perf_non, resampling = cv_outer_fiveF_hundredR))"

rm(args_bm_sp_non, args_bm_sp_nsp, args_bm_sp_sp, args_bm_nsp_nsp, args_bm_nsp_non)
