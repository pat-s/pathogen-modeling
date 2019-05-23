
# Aggregate by pathogen + resampling --------------------------------------

bmr_aggr_path_resamp_plan = drake_plan(bm_sp_sp_diplodia = mergeBenchmarkResults(list(bm_sp_sp_diplodia_gam,
                                                                                      bm_sp_sp_diplodia_kknn, bm_sp_sp_diplodia_rf,
                                                                                      bm_sp_sp_diplodia_svm, bm_sp_sp_diplodia_brt)),
                                       bm_sp_sp_diplodia2 = mergeBenchmarkResults(list(bm_sp_sp_diplodia_gam,
                                                                                       bm_sp_sp_diplodia_kknn, bm_sp_sp_diplodia_rf,
                                                                                       bm_sp_sp_diplodia_svm, bm_sp_sp_diplodia_brt,
                                                                                       bm_sp_sp_diplodia_xgboost)),

                                       bm_sp_nsp_diplodia = mergeBenchmarkResults(list(bm_sp_nsp_diplodia_gam,
                                                                                       bm_sp_nsp_diplodia_kknn, bm_sp_nsp_diplodia_rf,
                                                                                       bm_sp_nsp_diplodia_svm, bm_sp_nsp_diplodia_brt)),

                                       bm_sp_nsp_diplodia2 = mergeBenchmarkResults(list(bm_sp_nsp_diplodia_gam,
                                                                                        bm_sp_nsp_diplodia_kknn, bm_sp_nsp_diplodia_rf,
                                                                                        bm_sp_nsp_diplodia_svm, bm_sp_nsp_diplodia_brt,
                                                                                        bm_sp_nsp_diplodia_xgboost)),

                                       bm_nsp_nsp_diplodia = mergeBenchmarkResults(list(bm_nsp_nsp_diplodia_gam,
                                                                                        bm_nsp_nsp_diplodia_kknn, bm_nsp_nsp_diplodia_rf,
                                                                                        bm_nsp_nsp_diplodia_svm, bm_nsp_nsp_diplodia_brt)),

                                       bm_nsp_nsp_diplodia2 = mergeBenchmarkResults(list(bm_nsp_nsp_diplodia_gam,
                                                                                         bm_nsp_nsp_diplodia_kknn, bm_nsp_nsp_diplodia_rf,
                                                                                         bm_nsp_nsp_diplodia_svm, bm_nsp_nsp_diplodia_brt,
                                                                                         bm_nsp_nsp_diplodia_xgboost)),

                                       bm_sp_non_diplodia = mergeBenchmarkResults(list(bm_sp_non_diplodia_gam, bm_sp_non_diplodia_glm,
                                                                                       bm_sp_non_diplodia_kknn, bm_sp_non_diplodia_rf,
                                                                                       bm_sp_non_diplodia_svm, bm_sp_non_diplodia_brt)),

                                       bm_sp_non_diplodia2 = mergeBenchmarkResults(list(bm_sp_non_diplodia_gam, bm_sp_non_diplodia_glm,
                                                                                        bm_sp_non_diplodia_kknn, bm_sp_non_diplodia_rf,
                                                                                        bm_sp_non_diplodia_svm, bm_sp_non_diplodia_brt,
                                                                                        bm_sp_non_diplodia_xgboost)),

                                       bm_nsp_non_diplodia = mergeBenchmarkResults(list(bm_nsp_non_diplodia_gam, bm_nsp_non_diplodia_glm,
                                                                                        bm_nsp_non_diplodia_kknn, bm_nsp_non_diplodia_rf,
                                                                                        bm_nsp_non_diplodia_svm, bm_nsp_non_diplodia_brt)),

                                       bm_nsp_non_diplodia2 = mergeBenchmarkResults(list(bm_nsp_non_diplodia_gam, bm_nsp_non_diplodia_glm,
                                                                                         bm_nsp_non_diplodia_kknn, bm_nsp_non_diplodia_rf,
                                                                                         bm_nsp_non_diplodia_svm, bm_nsp_non_diplodia_brt,
                                                                                         bm_nsp_non_diplodia_xgboost)),

                                       bm_sp_sp_armillaria = mergeBenchmarkResults(list(bm_sp_sp_armillaria_gam,
                                         bm_sp_sp_armillaria_kknn, bm_sp_sp_armillaria_rf,
                                         bm_sp_sp_armillaria_svm, bm_sp_sp_armillaria_brt,
                                         bm_sp_sp_armillaria_xgboost
                                       )),

                                       bm_sp_nsp_armillaria = mergeBenchmarkResults(list(bm_sp_nsp_armillaria_gam,
                                                                                         bm_sp_nsp_armillaria_kknn, bm_sp_nsp_armillaria_rf,
                                                                                         bm_sp_nsp_armillaria_svm, bm_sp_nsp_armillaria_brt,
                                                                                         bm_sp_nsp_armillaria_xgboost)),

                                       bm_nsp_nsp_armillaria = mergeBenchmarkResults(list(bm_nsp_nsp_armillaria_gam,
                                                                                          bm_nsp_nsp_armillaria_kknn, bm_nsp_nsp_armillaria_rf,
                                                                                          bm_nsp_nsp_armillaria_svm, bm_nsp_nsp_armillaria_brt,
                                                                                          bm_nsp_nsp_armillaria_xgboost)),

                                       bm_sp_non_armillaria = mergeBenchmarkResults(list(bm_sp_non_armillaria_gam, bm_sp_non_armillaria_glm,
                                                                                         bm_sp_non_armillaria_kknn, bm_sp_non_armillaria_rf,
                                                                                         bm_sp_non_armillaria_svm, bm_sp_non_armillaria_brt,
                                                                                         bm_sp_non_armillaria_xgboost)),

                                       bm_nsp_non_armillaria = mergeBenchmarkResults(list(bm_nsp_non_armillaria_gam, bm_nsp_non_armillaria_glm,
                                                                                          bm_nsp_non_armillaria_kknn, bm_nsp_non_armillaria_rf,
                                                                                          bm_nsp_non_armillaria_svm, bm_nsp_non_armillaria_brt,
                                                                                          bm_nsp_non_armillaria_xgboost)),

                                       bm_sp_sp_fusarium = mergeBenchmarkResults(list(bm_sp_sp_fusarium_gam,
                                                                                      bm_sp_sp_fusarium_kknn, bm_sp_sp_fusarium_rf,
                                                                                      bm_sp_sp_fusarium_svm, bm_sp_sp_fusarium_brt,
                                                                                      bm_sp_sp_fusarium_xgboost)),

                                       bm_sp_nsp_fusarium = mergeBenchmarkResults(list(bm_sp_nsp_fusarium_gam,
                                                                                       bm_sp_nsp_fusarium_kknn, bm_sp_nsp_fusarium_rf,
                                                                                       bm_sp_nsp_fusarium_svm, bm_sp_nsp_fusarium_brt,
                                                                                       bm_sp_nsp_fusarium_xgboost)),

                                       bm_nsp_nsp_fusarium = mergeBenchmarkResults(list(bm_nsp_nsp_fusarium_gam,
                                                                                        bm_nsp_nsp_fusarium_kknn, bm_nsp_nsp_fusarium_rf,
                                                                                        bm_nsp_nsp_fusarium_svm, bm_nsp_nsp_fusarium_brt,
                                                                                        bm_nsp_nsp_fusarium_xgboost)),

                                       bm_sp_non_fusarium = mergeBenchmarkResults(list(bm_sp_non_fusarium_gam, bm_sp_non_fusarium_glm,
                                                                                       bm_sp_non_fusarium_kknn, bm_sp_non_fusarium_rf,
                                                                                       bm_sp_non_fusarium_svm, bm_sp_non_fusarium_brt,
                                                                                       bm_sp_non_fusarium_xgboost)),

                                       bm_nsp_non_fusarium = mergeBenchmarkResults(list(bm_nsp_non_fusarium_gam, bm_nsp_non_fusarium_glm,
                                                                                        bm_nsp_non_fusarium_kknn, bm_nsp_non_fusarium_rf,
                                                                                        bm_nsp_non_fusarium_svm, bm_nsp_non_fusarium_brt,
                                                                                        bm_nsp_non_fusarium_xgboost)),

                                       bm_sp_sp_heterobasidion = mergeBenchmarkResults(list(bm_sp_sp_heterobasidion_gam,
                                                                                            bm_sp_sp_heterobasidion_kknn, bm_sp_sp_heterobasidion_rf,
                                                                                            bm_sp_sp_heterobasidion_svm, bm_sp_sp_heterobasidion_brt,
                                                                                            bm_sp_sp_heterobasidion_xgboost)),

                                       bm_sp_nsp_heterobasidion = mergeBenchmarkResults(list(bm_sp_nsp_heterobasidion_gam,
                                                                                             bm_sp_nsp_heterobasidion_kknn, bm_sp_nsp_heterobasidion_rf,
                                                                                             bm_sp_nsp_heterobasidion_svm, bm_sp_nsp_heterobasidion_brt,
                                                                                             bm_sp_nsp_heterobasidion_xgboost)),

                                       bm_nsp_nsp_heterobasidion = mergeBenchmarkResults(list(bm_nsp_nsp_heterobasidion_gam,
                                                                                              bm_nsp_nsp_heterobasidion_kknn, bm_nsp_nsp_heterobasidion_rf,
                                                                                              bm_nsp_nsp_heterobasidion_svm, bm_nsp_nsp_heterobasidion_brt,
                                                                                              bm_nsp_nsp_heterobasidion_xgboost)),

                                       bm_sp_non_heterobasidion = mergeBenchmarkResults(list(bm_sp_non_heterobasidion_gam, bm_sp_non_heterobasidion_glm,
                                                                                             bm_sp_non_heterobasidion_kknn, bm_sp_non_heterobasidion_rf,
                                                                                             bm_sp_non_heterobasidion_svm, bm_sp_non_heterobasidion_brt,
                                                                                             bm_sp_non_heterobasidion_xgboost)),

                                       bm_nsp_non_heterobasidion = mergeBenchmarkResults(list(bm_nsp_non_heterobasidion_gam, bm_nsp_non_heterobasidion_glm,
                                                                                              bm_nsp_non_heterobasidion_kknn, bm_nsp_non_heterobasidion_rf,
                                                                                              bm_nsp_non_heterobasidion_svm, bm_nsp_non_heterobasidion_brt,
                                                                                              bm_nsp_non_heterobasidion_xgboost))
)

# Aggregate by model + resampling --------------------------------------

bmr_aggr_model_resamp_plan = drake_plan(

  bm_sp_sp_svm = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_svm, bm_sp_sp_diplodia_svm,
    bm_sp_sp_fusarium_svm, bm_sp_sp_heterobasidion_svm
  )),
  bm_sp_sp_rf = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_rf, bm_sp_sp_diplodia_rf,
    bm_sp_sp_fusarium_rf, bm_sp_sp_heterobasidion_rf
  )),
  bm_sp_sp_kknn = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_kknn, bm_sp_sp_diplodia_kknn,
    bm_sp_sp_fusarium_kknn, bm_sp_sp_heterobasidion_kknn
  )),
  bm_sp_sp_brt = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_brt, bm_sp_sp_diplodia_brt,
    bm_sp_sp_fusarium_brt, bm_sp_sp_heterobasidion_brt
  )),
  bm_sp_sp_xgboost = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_xgboost,
    bm_sp_sp_diplodia_xgboost,
    bm_sp_sp_fusarium_xgboost,
    bm_sp_sp_heterobasidion_xgboost
  )),
  bm_sp_sp_gam = mergeBenchmarkResults(list(
    bm_sp_sp_armillaria_gam,
    bm_sp_sp_diplodia_gam,
    bm_sp_sp_fusarium_gam,
    bm_sp_sp_heterobasidion_gam
  )),
  bm_sp_non_glm = mergeBenchmarkResults(list(
    bm_sp_non_armillaria_glm,
    bm_sp_non_diplodia_glm,
    bm_sp_non_fusarium_glm,
    bm_sp_non_heterobasidion_glm
  ))

)


# Remove "extract" slot from BM objects -----------------------------------

no_extract_plan = drake_plan(
  no_extract = target(
    remove_extract(bm_result),
    transform = cross(bm_result = c(bm_sp_sp_diplodia, bm_sp_nsp_diplodia,
                                    bm_nsp_nsp_diplodia, bm_sp_non_diplodia,
                                    bm_nsp_non_diplodia,

      bm_sp_sp_diplodia2, bm_sp_nsp_diplodia2,
                                    bm_nsp_nsp_diplodia2, bm_sp_non_diplodia2,
                                    bm_nsp_non_diplodia2,

                                    bm_sp_sp_armillaria, bm_sp_nsp_armillaria,
                                    bm_nsp_nsp_armillaria, bm_sp_non_armillaria,
                                    bm_nsp_non_armillaria,

                                    bm_sp_sp_fusarium, bm_sp_nsp_fusarium,
                                    bm_nsp_nsp_fusarium, bm_sp_non_fusarium,
                                    bm_nsp_non_fusarium,

                                    bm_sp_sp_heterobasidion, bm_sp_nsp_heterobasidion,
                                    bm_nsp_nsp_heterobasidion, bm_sp_non_heterobasidion,
                                    bm_nsp_non_heterobasidion,

                                    bm_sp_sp_gam, bm_sp_sp_svm, bm_sp_sp_brt,
                                    bm_sp_sp_rf, bm_sp_sp_xgboost, bm_sp_sp_kknn))
  )
)

# Aggregate by pathogen + model + resampling --------------------------------------

# armi xgboost and armi gam are missing so we cannot merge them here

bm_all_pathogens_plan = drake_plan(
  bm_all_pathogens_sp_sp = mergeBenchmarkResults(list(no_extract_bm_sp_sp_diplodia2,
                                                      no_extract_bm_sp_sp_armillaria,
                                                      no_extract_bm_sp_sp_fusarium,
                                                      no_extract_bm_sp_sp_heterobasidion)),
  bm_all_pathogens_sp_nsp = mergeBenchmarkResults(list(no_extract_bm_sp_nsp_diplodia2, no_extract_bm_sp_nsp_armillaria,
                                                       no_extract_bm_sp_nsp_fusarium, no_extract_bm_sp_nsp_heterobasidion)),
  bm_all_pathogens_nsp_nsp = mergeBenchmarkResults(list(no_extract_bm_nsp_nsp_diplodia2, no_extract_bm_nsp_nsp_armillaria,
                                                        no_extract_bm_nsp_nsp_fusarium, no_extract_bm_nsp_nsp_heterobasidion)),
  bm_all_pathogens_sp_non = mergeBenchmarkResults(list(no_extract_bm_sp_non_diplodia2, no_extract_bm_sp_non_armillaria,
                                                       no_extract_bm_sp_non_fusarium, no_extract_bm_sp_non_heterobasidion)),
  bm_all_pathogens_nsp_non = mergeBenchmarkResults(list(no_extract_bm_nsp_non_diplodia2, no_extract_bm_nsp_non_armillaria,
                                                        no_extract_bm_nsp_non_fusarium, no_extract_bm_nsp_non_heterobasidion))
)

