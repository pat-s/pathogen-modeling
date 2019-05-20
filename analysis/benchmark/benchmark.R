# combining all benchmark calls into a single plan
# see https://ropenscilabs.github.io/drake-manual/plans.html#map_plan

# sp/sp -------------------------------------------------------------------

args_bm_sp_sp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy_no_ph"),
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

args_bm_sp_sp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy_no_ph"),
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

args_bm_sp_sp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy_no_ph"),
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

args_bm_sp_sp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy_no_ph"),
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

args_bm_sp_nsp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy_no_ph"),
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

args_bm_sp_nsp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy_no_ph"),
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

args_bm_sp_nsp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy_no_ph"),
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

args_bm_sp_nsp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy_no_ph"),
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

args_bm_sp_non_armillaria = tibble(task = rlang::syms("armillaria_task_dummy_no_ph"),
                                   learner = c(c("lrn_rf",
                                                 "lrn_svm",
                                                 "lrn_xgboost",
                                                 "lrn_brt",
                                                 "lrn_kknn",
                                                 "lrn_glm",
                                                 "lrn_gam_armillaria_perf_non_no_ph"
                                   )),
                                   resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_armillaria$learner = rlang::syms(args_bm_sp_non_armillaria$learner)
args_bm_sp_non_armillaria$id = suppressWarnings(paste0("bm_sp_non_armillaria_", str_split(args_bm_sp_non_armillaria$learner, "_",
                                                                                          simplify = TRUE)[, 2]))

args_bm_sp_non_diplodia = tibble(task = "diplodia_task_dummy_no_ph",
                                 learner = c(c("lrn_rf",
                                               "lrn_svm",
                                               "lrn_xgboost",
                                               "lrn_brt",
                                               "lrn_kknn",
                                               "lrn_glm",
                                               "lrn_gam_diplodia_perf_non_no_ph"
                                 )),
                                 resampling = rep("spcv_outer_fiveF_hundredR", 7))
# manual add - only temporary
args_bm_sp_non_diplodia[8,1] = "test_diplodia_task"
args_bm_sp_non_diplodia[8,2] = "lrn_glm"
args_bm_sp_non_diplodia[8,3] = "spcv_outer_fiveF_hundredR"

args_bm_sp_non_diplodia$task = rlang::syms(args_bm_sp_non_diplodia$task)
args_bm_sp_non_diplodia$learner = rlang::syms(args_bm_sp_non_diplodia$learner)
args_bm_sp_non_diplodia$resampling = rlang::syms(args_bm_sp_non_diplodia$resampling)
args_bm_sp_non_diplodia$id = suppressWarnings(paste0("bm_sp_non_diplodia_", str_split(args_bm_sp_non_diplodia$learner, "_",
                                                                                      simplify = TRUE)[, 2]))

args_bm_sp_non_diplodia[8,4] = "bm_sp_non_diplodia_glm_old"


args_bm_sp_non_fusarium = tibble(task = rlang::syms("fusarium_task_dummy_no_ph"),
                                 learner = c(c("lrn_rf",
                                               "lrn_svm",
                                               "lrn_xgboost",
                                               "lrn_brt",
                                               "lrn_kknn",
                                               "lrn_glm",
                                               "lrn_gam_fusarium_perf_non_no_ph"
                                 )),
                                 resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_fusarium$learner = rlang::syms(args_bm_sp_non_fusarium$learner)
args_bm_sp_non_fusarium$id = suppressWarnings(paste0("bm_sp_non_fusarium_", str_split(args_bm_sp_non_fusarium$learner, "_",
                                                                                      simplify = TRUE)[, 2]))

args_bm_sp_non_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy_no_ph"),
                                       learner = c(c("lrn_rf",
                                                     "lrn_svm",
                                                     "lrn_xgboost",
                                                     "lrn_brt",
                                                     "lrn_kknn",
                                                     "lrn_glm",
                                                     "lrn_gam_heterobasidion_perf_non_no_ph"
                                       )),
                                       resampling = rlang::syms(rep("spcv_outer_fiveF_hundredR", 7)))
args_bm_sp_non_heterobasidion$learner = rlang::syms(args_bm_sp_non_heterobasidion$learner)
args_bm_sp_non_heterobasidion$id = suppressWarnings(paste0("bm_sp_non_heterobasidion_", str_split(args_bm_sp_non_heterobasidion$learner, "_",
                                                                                                  simplify = TRUE)[, 2]))

# nsp/nsp ------------------------------------------------------------------

args_bm_nsp_nsp_armillaria = tibble(task = rlang::syms("armillaria_task_dummy_no_ph"),
                                    learner = c(c("wrapper_rf_nsp",
                                                  "wrapper_svm_nsp",
                                                  "wrapper_xgboost_nsp",
                                                  "wrapper_brt_nsp",
                                                  "wrapper_kknn_nsp",
                                                  "wrapper_gam_armillaria_perf_nsp"
                                    )),
                                    resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_armillaria$learner = rlang::syms(args_bm_nsp_nsp_armillaria$learner)
args_bm_nsp_nsp_armillaria$id = suppressWarnings(paste0("bm_nsp_nsp_armillaria_", str_split(args_bm_nsp_nsp_armillaria$learner, "_",
                                                                                            simplify = TRUE)[, 2]))

args_bm_nsp_nsp_diplodia = tibble(task = rlang::syms("diplodia_task_dummy_no_ph"),
                                  learner = c(c("wrapper_rf_nsp",
                                                "wrapper_svm_nsp",
                                                "wrapper_xgboost_nsp",
                                                "wrapper_brt_nsp",
                                                "wrapper_kknn_nsp",
                                                "wrapper_gam_diplodia_perf_nsp"
                                  )),
                                  resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_diplodia$learner = rlang::syms(args_bm_nsp_nsp_diplodia$learner)
args_bm_nsp_nsp_diplodia$id = suppressWarnings(paste0("bm_nsp_nsp_diplodia_", str_split(args_bm_nsp_nsp_diplodia$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_nsp_nsp_fusarium = tibble(task = rlang::syms("fusarium_task_dummy_no_ph"),
                                  learner = c(c("wrapper_rf_nsp",
                                                "wrapper_svm_nsp",
                                                "wrapper_xgboost_nsp",
                                                "wrapper_brt_nsp",
                                                "wrapper_kknn_nsp",
                                                "wrapper_gam_fusarium_perf_nsp"
                                  )),
                                  resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_fusarium$learner = rlang::syms(args_bm_nsp_nsp_fusarium$learner)
args_bm_nsp_nsp_fusarium$id = suppressWarnings(paste0("bm_nsp_nsp_fusarium_", str_split(args_bm_nsp_nsp_fusarium$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_nsp_nsp_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy_no_ph"),
                                        learner = c(c("wrapper_rf_nsp",
                                                      "wrapper_svm_nsp",
                                                      "wrapper_xgboost_nsp",
                                                      "wrapper_brt_nsp",
                                                      "wrapper_kknn_nsp",
                                                      "wrapper_gam_heterobasidion_perf_nsp"
                                        )),
                                        resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 6)))
args_bm_nsp_nsp_heterobasidion$learner = rlang::syms(args_bm_nsp_nsp_heterobasidion$learner)
args_bm_nsp_nsp_heterobasidion$id = suppressWarnings(paste0("bm_nsp_nsp_heterobasidion_", str_split(args_bm_nsp_nsp_heterobasidion$learner, "_",
                                                                                                    simplify = TRUE)[, 2]))

# nsp/non ------------------------------------------------------------------

args_bm_nsp_non_armillaria = tibble(task = rlang::syms("armillaria_task_dummy_no_ph"),
                                    learner = c(c("lrn_rf",
                                                  "lrn_svm",
                                                  "lrn_xgboost",
                                                  "lrn_brt",
                                                  "lrn_kknn",
                                                  "lrn_glm",
                                                  "lrn_gam_armillaria_perf_non_no_ph"
                                    )),
                                    resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_armillaria$learner = rlang::syms(args_bm_nsp_non_armillaria$learner)
args_bm_nsp_non_armillaria$id = suppressWarnings(paste0("bm_nsp_non_armillaria_", str_split(args_bm_nsp_non_armillaria$learner, "_",
                                                                                            simplify = TRUE)[, 2]))

args_bm_nsp_non_diplodia = tibble(task = rlang::syms("diplodia_task_dummy_no_ph"),
                                  learner = c(c("lrn_rf",
                                                "lrn_svm",
                                                "lrn_xgboost",
                                                "lrn_brt",
                                                "lrn_kknn",
                                                "lrn_glm",
                                                "lrn_gam_diplodia_perf_non_no_ph"
                                  )),
                                  resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_diplodia$learner = rlang::syms(args_bm_nsp_non_diplodia$learner)
args_bm_nsp_non_diplodia$id = suppressWarnings(paste0("bm_nsp_non_diplodia_", str_split(args_bm_nsp_non_diplodia$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_nsp_non_fusarium = tibble(task = rlang::syms("fusarium_task_dummy_no_ph"),
                                  learner = c(c("lrn_rf",
                                                "lrn_svm",
                                                "lrn_xgboost",
                                                "lrn_brt",
                                                "lrn_kknn",
                                                "lrn_glm",
                                                "lrn_gam_fusarium_perf_non_no_ph"
                                  )),
                                  resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_fusarium$learner = rlang::syms(args_bm_nsp_non_fusarium$learner)
args_bm_nsp_non_fusarium$id = suppressWarnings(paste0("bm_nsp_non_fusarium_", str_split(args_bm_nsp_non_fusarium$learner, "_",
                                                                                        simplify = TRUE)[, 2]))

args_bm_nsp_non_heterobasidion = tibble(task = rlang::syms("heterobasidion_task_dummy_no_ph"),
                                        learner = c(c("lrn_rf",
                                                      "lrn_svm",
                                                      "lrn_xgboost",
                                                      "lrn_brt",
                                                      "lrn_kknn",
                                                      "lrn_glm",
                                                      "lrn_gam_heterobasidion_perf_non_no_ph"
                                        )),
                                        resampling = rlang::syms(rep("cv_outer_fiveF_hundredR", 7)))
args_bm_nsp_non_heterobasidion$learner = rlang::syms(args_bm_nsp_non_heterobasidion$learner)
args_bm_nsp_non_heterobasidion$id = suppressWarnings(paste0("bm_nsp_non_heterobasidion_", str_split(args_bm_nsp_non_heterobasidion$learner, "_",
                                                                                                    simplify = TRUE)[, 2]))

# combine -----------------------------------------------------------------

benchmark_sp_sp_armillaria = map_plan(args_bm_sp_sp_armillaria, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_sp_diplodia = map_plan(args_bm_sp_sp_diplodia, benchmark_custom_no_pred_no_models, trace = FALSE)
benchmark_sp_sp_fusarium = map_plan(args_bm_sp_sp_fusarium, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_sp_heterobasidion = map_plan(args_bm_sp_sp_heterobasidion, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)

benchmark_sp_nsp_armillaria = map_plan(args_bm_sp_nsp_armillaria, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_nsp_diplodia = map_plan(args_bm_sp_nsp_diplodia, benchmark_custom_no_pred_no_models, trace = FALSE)
benchmark_sp_nsp_fusarium = map_plan(args_bm_sp_nsp_fusarium, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_nsp_heterobasidion = map_plan(args_bm_sp_nsp_heterobasidion, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)

benchmark_sp_non_armillaria = map_plan(args_bm_sp_non_armillaria, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_non_diplodia = map_plan(args_bm_sp_non_diplodia, benchmark_custom_no_pred_no_models, trace = FALSE)
benchmark_sp_non_fusarium = map_plan(args_bm_sp_non_fusarium, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_sp_non_heterobasidion = map_plan(args_bm_sp_non_heterobasidion, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)

benchmark_nsp_nsp_armillaria = map_plan(args_bm_nsp_nsp_armillaria, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_nsp_nsp_diplodia = map_plan(args_bm_nsp_nsp_diplodia, benchmark_custom_no_pred_no_models, trace = FALSE)
benchmark_nsp_nsp_fusarium = map_plan(args_bm_nsp_nsp_fusarium, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_nsp_nsp_heterobasidion = map_plan(args_bm_nsp_nsp_heterobasidion, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)

benchmark_nsp_non_armillaria = map_plan(args_bm_nsp_non_armillaria, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_nsp_non_diplodia = map_plan(args_bm_nsp_non_diplodia, benchmark_custom_no_pred_no_models, trace = FALSE)
benchmark_nsp_non_fusarium = map_plan(args_bm_nsp_non_fusarium, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)
benchmark_nsp_non_heterobasidion = map_plan(args_bm_nsp_non_heterobasidion, benchmark_custom_no_extract_no_pred_no_models, trace = FALSE)

benchmark_plan = bind_plans(benchmark_sp_sp_armillaria, benchmark_sp_sp_diplodia, benchmark_sp_sp_fusarium, benchmark_sp_sp_heterobasidion,
                            benchmark_sp_nsp_armillaria, benchmark_sp_nsp_diplodia, benchmark_sp_nsp_fusarium, benchmark_sp_nsp_heterobasidion,
                            benchmark_sp_non_armillaria, benchmark_sp_non_diplodia, benchmark_sp_non_fusarium, benchmark_sp_non_heterobasidion,
                            benchmark_nsp_nsp_armillaria, benchmark_nsp_nsp_diplodia, benchmark_nsp_nsp_fusarium, benchmark_nsp_nsp_heterobasidion,
                            benchmark_nsp_non_armillaria, benchmark_nsp_non_diplodia, benchmark_nsp_non_fusarium, benchmark_nsp_non_heterobasidion
)

rm(list=ls(pattern="args_"))
rm(list=ls(pattern="benchmark_nsp"))
rm(list=ls(pattern="benchmark_sp"))
