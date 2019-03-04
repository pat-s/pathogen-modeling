bmr_aggregated = drake_plan(bm_sp_sp_gam = mergeBenchmarkResults(list(bm_sp_sp_armillaria_gam, bm_sp_sp_heterobasidion_gam,
                                                                      bm_sp_sp_diplodia_gam, bm_sp_sp_fusarium_gam)),
                            bm_sp_nsp_gam = mergeBenchmarkResults(list(bm_sp_nsp_armillaria_gam, bm_sp_nsp_heterobasidion_gam,
                                                                       bm_sp_nsp_diplodia_gam, bm_sp_nsp_fusarium_gam)),
                            bm_sp_non_gam = mergeBenchmarkResults(list(bm_sp_non_armillaria_gam, bm_sp_non_heterobasidion_gam,
                                                                       bm_sp_non_diplodia_gam, bm_sp_non_fusarium_gam)),
                            bm_nsp_nsp_gam = mergeBenchmarkResults(list(bm_nsp_nsp_armillaria_gam, bm_nsp_nsp_heterobasidion_gam,
                                                                        bm_nsp_nsp_diplodia_gam, bm_nsp_nsp_fusarium_gam)),
                            bm_nsp_non_gam = mergeBenchmarkResults(list(bm_nsp_non_armillaria_gam, bm_nsp_non_heterobasidion_gam,
                                                                        bm_nsp_non_diplodia_gam, bm_nsp_non_fusarium_gam)),
                            bm_sp_sp_all = mergeBenchmarkResults(list(bm_sp_sp_armillaria_rf, bm_sp_sp_diplodia_rf, bm_sp_sp_fusarium_rf, bm_sp_sp_heterobasidion_rf,
                                                                      bm_sp_sp_armillaria_svm, bm_sp_sp_diplodia_svm, bm_sp_sp_fusarium_svm, bm_sp_sp_heterobasidion_svm,
                                                                      bm_sp_sp_armillaria_brt, bm_sp_sp_diplodia_brt, bm_sp_sp_fusarium_brt, bm_sp_sp_heterobasidion_brt,
                                                                      bm_sp_sp_armillaria_kknn, bm_sp_sp_diplodia_kknn, bm_sp_sp_fusarium_kknn, bm_sp_sp_heterobasidion_kknn,
                                                                      bm_sp_sp_armillaria_xgboost, bm_sp_sp_diplodia_xgboost, bm_sp_sp_fusarium_xgboost, bm_sp_sp_heterobasidion_xgboost,
                                                                      bm_sp_sp_armillaria_gam, bm_sp_sp_diplodia_gam, bm_sp_sp_fusarium_gam, bm_sp_sp_heterobasidion_gamn))
                            # bm_sp_sp_all_reduced = stripname(bm_sp_sp_all, "extract") %>%
                            #   set_class("BenchmarkResult")
)

