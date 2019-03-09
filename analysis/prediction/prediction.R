args_pred = tibble(task = rlang::syms("tasks_pred"),
                   learner = c("lrn_rf",
                               "lrn_svm",
                               "lrn_xgboost",
                               "lrn_kknn",
                               "lrn_glm",
                               "lrn_gam_diplodia_pred",
                               "lrn_gam_fusarium_pred",
                               "lrn_gam_armillaria_pred",
                               "lrn_gam_heterobasidion_pred",
                               "lrn_brt"),
                   resampling = rlang::syms(rep("spcv_inner_fiveF", 10)),
                   param_set = rlang::syms(c("ps_rf",
                                             "ps_svm",
                                             "ps_xgboost",
                                             "ps_kknn",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "ps_brt")),
                   tune_ctrl = rlang::syms(c("tune_ctrl_rf_100",
                                             "tune_ctrl_svm_100",
                                             "tune_ctrl_xgboost_100",
                                             "tune_ctrl_kknn_100",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "tune_ctrl_brt_100")),
                   prediction_data = rep(rlang::syms("pred_data"), 10),
                   prediction_grid = rep(rlang::syms("temperature_mean"), 10),
                   desc_resampling = c("spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/no tuning",
                                       "spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/spatial",
                                       "spatial/spatial")
)
args_pred$id = suppressWarnings(paste0("prediction_", str_split(args_pred$learner, "_", simplify = TRUE)[, 2]))
args_pred$learner = rlang::syms(args_pred$learner)

args_pred[6, "id"] = "prediction_gam_diplodia"
args_pred[7, "id"] = "prediction_gam_fusarium"
args_pred[8, "id"] = "prediction_gam_armillaria"
args_pred[9, "id"] = "prediction_gam_heterobasidion"

prediction_prob = map_plan(args_pred, prediction_custom, trace = FALSE)

rm(args_pred)


# prediction maps ---------------------------------------------------------

args_pred = tibble(prediction_raster = c("prediction_glm_diplodia",
                                         "prediction_glm_fusarium",
                                         "prediction_glm_armillaria",
                                         "prediction_glm_heterobasidion",

                                         "prediction_gam_diplodia",
                                         "prediction_gam_fusarium",
                                         "prediction_gam_armillaria",
                                         "prediction_gam_heterobasidion",

                                         "prediction_svm_diplodia",
                                         "prediction_svm_fusarium",
                                         "prediction_svm_armillaria",
                                         "prediction_svm_heterobasidion",

                                         "prediction_rf",
                                         "prediction_kknn",
                                         "prediction_xgboost",
                                         "prediction_brt"),
                   model_name = c("glm",
                                  "glm",
                                  "glm",
                                  "glm",

                                  "gam",
                                  "gam",
                                  "gam",
                                  "gam",

                                  "svm",
                                  "svm",
                                  "svm",
                                  "svm",

                                  "rf",
                                  "kknn",
                                  "xgboost",
                                  "brt"),
                   benchmark_object = c("bm_sp_non_diplodia_glm",
                                        "bm_sp_non_armillaria_glm",
                                        "bm_sp_non_fusarium_glm",
                                        "bm_sp_non_heterobasidion_glm",

                                        "bm_sp_sp_diplodia_gam",
                                        "bm_sp_sp_armillaria_gam",
                                        "bm_sp_sp_fusarium_gam",
                                        "bm_sp_sp_heterobasidion_gam",


                                        "bm_sp_sp_diplodia_svm",
                                        "bm_sp_sp_armillaria_svm",
                                        "bm_sp_sp_fusarium_svm",
                                        "bm_sp_sp_heterobasidion_svm",

                                        "bm_sp_sp_rf",
                                        "bm_sp_sp_kknn",
                                        "bm_sp_sp_xgboost",
                                        "bm_sp_sp_brt"),
                   resampling = c("spatial/no tuning",
                                  "spatial/no tuning",
                                  "spatial/no tuning",
                                  "spatial/no tuning",

                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial",

                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial",


                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial",
                                  "spatial/spatial")
)

args_pred$id = suppressWarnings(paste0("maps_", gsub("prediction_", "", args_pred$prediction_raster)))
args_pred$prediction_raster = rlang::syms(args_pred$prediction_raster)
args_pred$benchmark_object = rlang::syms(args_pred$benchmark_object)

prediction_maps = map_plan(args_pred, create_prediction_map, trace = FALSE)
