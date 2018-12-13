args_pred = tibble(task = rlang::syms("tasks_pred"),
                   learner = c("lrn_rf",
                               "lrn_svm",
                               "lrn_xgboost",
                               "lrn_kknn",
                               "lrn_glm",
                               "lrn_gam_diplodia_pred",
                               "lrn_gam_fusarium_pred",
                               "lrn_gam_armillaria_pred",
                               "lrn_gam_heterobasidion_pred"),
                   resampling = rlang::syms(rep("spcv_inner_fiveF", 9)),
                   param_set = rlang::syms(c("ps_rf",
                                             "ps_svm",
                                             "ps_xgboost",
                                             "ps_kknn",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL")),
                   tune_ctrl = rlang::syms(c("tune_ctrl_rf",
                                             "tune_ctrl_svm",
                                             "tune_ctrl_xgboost",
                                             "tune_ctrl_kknn",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL",
                                             "NULL")),
                   prediction_data = rep(rlang::syms("pred_data"), 9)
)
args_pred$id = suppressWarnings(paste0("prediction_", str_split(args_pred$learner, "_", simplify = TRUE)[, 2]))
args_pred$learner = rlang::syms(args_pred$learner)

args_pred[6, "id"] = "prediction_gam_diplodia"
args_pred[7, "id"] = "prediction_gam_fusarium"
args_pred[8, "id"] = "prediction_gam_armillaria"
args_pred[9, "id"] = "prediction_gam_heterobasidion"

prediction = map_plan(args_pred, prediction_custom, trace = FALSE)

rm(args_pred)
