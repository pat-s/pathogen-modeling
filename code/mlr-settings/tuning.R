wrapper_rf_sp = wrapper_custom(lrn_rf, ps_rf, spcv_inner_fiveF, tune_ctrl_rf_100)

wrapper_svm_sp = wrapper_custom(lrn_svm, ps_svm, spcv_inner_fiveF, tune_ctrl_svm_100)

wrapper_kknn_sp = wrapper_custom(lrn_kknn, ps_kknn, spcv_inner_fiveF, tune_ctrl_kknn_100)

wrapper_xgboost_sp = wrapper_custom(lrn_xgboost, ps_xgboost, spcv_inner_fiveF, tune_ctrl_xgboost_100)

wrapper_brt_sp = wrapper_custom(lrn_brt, ps_brt, spcv_inner_fiveF, tune_ctrl_brt_100)

wrapper_gam_diplodia_perf_sp = wrapper_custom(lrn_gam_diplodia_perf, ps_gam_diplodia_fusarium, spcv_inner_fiveF, tune_ctrl_gam_100_diplodia_fusarium)
wrapper_gam_fusarium_perf_sp = wrapper_custom(lrn_gam_fusarium__perf, ps_gam_diplodia_fusarium, spcv_inner_fiveF, tune_ctrl_gam_100_diplodia_fusarium)
wrapper_gam_armillaria_perf_sp = wrapper_custom(lrn_gam_armillaria_perf, ps_gam_armillaria_heterobasidion, spcv_inner_fiveF, tune_ctrl_gam_100_armillaria_heterobasidion)
wrapper_gam_heterobasidion_perf_sp = wrapper_custom(lrn_gam_heterobasidion_perf, ps_gam_armillaria_heterobasidion, spcv_inner_fiveF, tune_ctrl_gam_100_armillaria_heterobasidion)

# Non-spatial -------------------------------------------------------------

wrapper_rf_nsp = wrapper_custom(lrn_rf, ps_rf, cv_inner_fiveF, tune_ctrl_rf_100)

wrapper_svm_nsp = wrapper_custom(lrn_svm, ps_svm, cv_inner_fiveF, tune_ctrl_svm_100)

wrapper_kknn_nsp = wrapper_custom(lrn_kknn, ps_kknn, cv_inner_fiveF, tune_ctrl_kknn_100)

wrapper_xgboost_nsp = wrapper_custom(lrn_xgboost, ps_xgboost, cv_inner_fiveF, tune_ctrl_xgboost_100)

wrapper_brt_nsp = wrapper_custom(lrn_brt, ps_brt, cv_inner_fiveF, tune_ctrl_brt_100)

wrapper_gam_diplodia_perf_nsp = wrapper_custom(lrn_gam_diplodia_perf, ps_gam_diplodia_fusarium, cv_inner_fiveF, tune_ctrl_gam_100_diplodia_fusarium)
wrapper_gam_fusarium_perf_nsp = wrapper_custom(lrn_gam_fusarium__perf, ps_gam_diplodia_fusarium, cv_inner_fiveF, tune_ctrl_gam_100_diplodia_fusarium)
wrapper_gam_armillaria_perf_nsp = wrapper_custom(lrn_gam_armillaria_perf, ps_gam_armillaria_heterobasidion, cv_inner_fiveF, tune_ctrl_gam_100_armillaria_heterobasidion)
wrapper_gam_heterobasidion_perf_nsp = wrapper_custom(lrn_gam_heterobasidion_perf, ps_gam_armillaria_heterobasidion, cv_inner_fiveF, tune_ctrl_gam_100_armillaria_heterobasidion)



