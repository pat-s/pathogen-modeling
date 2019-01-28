bmr_aggregated = drake_plan(bm_sp_sp_gam = mergeBenchmarkResults(list(bm_sp_sp_gam_armillaria, bm_sp_sp_gam_heterobasidion,
                                                                      bm_sp_sp_gam_diplodia, bm_sp_sp_gam_fusarium)),
                            bm_sp_nsp_gam = mergeBenchmarkResults(list(bm_sp_nsp_gam_armillaria, bm_sp_nsp_gam_heterobasidion,
                                                                       bm_sp_nsp_gam_diplodia, bm_sp_nsp_gam_fusarium)),
                            bm_sp_non_gam = mergeBenchmarkResults(list(bm_sp_non_gam_armillaria, bm_sp_non_gam_heterobasidion,
                                                                       bm_sp_non_gam_diplodia, bm_sp_non_gam_fusarium)),
                            bm_nsp_nsp_gam = mergeBenchmarkResults(list(bm_nsp_nsp_gam_armillaria, bm_nsp_nsp_gam_heterobasidion,
                                                                        bm_nsp_nsp_gam_diplodia, bm_nsp_nsp_gam_fusarium)),
                            bm_nsp_non_gam = mergeBenchmarkResults(list(bm_nsp_non_gam_armillaria, bm_nsp_non_gam_heterobasidion,
                                                                        bm_nsp_non_gam_diplodia, bm_nsp_non_gam_fusarium)),
                            bm_sp_sp_all = mergeBenchmarkResults(list(bm_sp_sp_rf, bm_sp_sp_svm,
                                                                      bm_sp_sp_brt, bm_sp_sp_gam
                            )))
