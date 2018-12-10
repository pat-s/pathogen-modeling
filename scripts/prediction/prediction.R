args_pred = tibble(task = rlang::syms(c("armillaria_task_dummy",
                                        "heterobasidion_task_dummy",
                                        "diplodia_task_dummy_prediction",
                                        "fusarium_task_dummy_prediction")),
                   learner = c("lrn_rf",
                               "lrn_svm",
                               # "wrapper_xgboost",
                               "lrn_kknn",
                               "lrn_glm"),
                   resampling = rlang::syms(rep("spcv_inner_fiveF", 4)),
                   param_set = rlang::syms(c("ps_rf",
                                             "ps_svm",
                                             # "ps_xgboost",
                                             "ps_kknn",
                                             "NULL")),
                   tune_ctrl = rlang::syms(c("tune_ctrl_rf",
                                             "tune_ctrl_svm",
                                             # "tune_ctrl_xgboost",
                                             "tune_ctrl_kknn",
                                             "NULL")),
                   prediction_data = rep(rlang::syms("pred_data"), 4)
)
args_pred$id = suppressWarnings(paste0("prediction_", str_split(args_pred$learner, "_", simplify = TRUE)[, 2]))
args_pred$learner = rlang::syms(args_pred$learner)

prediction = map_plan(args_pred, prediction_custom, trace = FALSE)

rm(args_pred)
