# tune_ctrl_rf_50 = tune_ctrl_mbo_30n_20it(ps_rf)
# tune_ctrl_svm_50 = tune_ctrl_mbo_30n_20it(ps_svm)
# tune_ctrl_xgboost_50 = tune_ctrl_mbo_30n_20it(ps_xgboost)
# tune_ctrl_kknn_50 = tune_ctrl_mbo_30n_20it(ps_kknn)
# tune_ctrl_brt_50 = tune_ctrl_mbo_30n_20it(ps_brt)
# tune_ctrl_gam_50 = tune_ctrl_mbo_30n_20it(ps_gam)

tune_ctrl_rf_100 = tune_ctrl_mbo_30n_70it(ps_rf)
tune_ctrl_svm_100 = tune_ctrl_mbo_30n_70it(ps_svm)
tune_ctrl_xgboost_100 = tune_ctrl_mbo_30n_70it(ps_xgboost)
tune_ctrl_kknn_100 = tune_ctrl_mbo_30n_70it(ps_kknn)
tune_ctrl_brt_100 = tune_ctrl_mbo_30n_70it(ps_brt)


tune_ctrl_gam_100_diplodia_fusarium = tune_ctrl_mbo_30n_70it(ps_gam_diplodia_fusarium)
tune_ctrl_gam_100_diplodia_fusarium_pred = tune_ctrl_mbo_30n_70it(ps_gam_diplodia_fusarium_pred)
tune_ctrl_gam_100_armillaria_heterobasidion = tune_ctrl_mbo_30n_70it(ps_gam_armillaria_heterobasidion)
