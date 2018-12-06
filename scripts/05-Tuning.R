wrapper_rf = wrapper_custom(lrn_rf, ps_rf, spcv_inner_fiveF)

wrapper_svm = wrapper_custom(lrn_svm, ps_svm, spcv_inner_fiveF)

wrapper_kknn = wrapper_custom(lrn_kknn, ps_kknn, spcv_inner_fiveF)

wrapper_xgboost = wrapper_custom(lrn_xgboost, ps_xgboost, spcv_inner_fiveF)
