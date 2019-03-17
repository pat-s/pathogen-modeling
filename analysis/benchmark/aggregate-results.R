bmr_aggregated = drake_plan(bm_sp_sp_diplodia = mergeBenchmarkResults(list(bm_sp_sp_diplodia_gam,
                                                                           bm_sp_sp_diplodia_kknn, bm_sp_sp_diplodia_rf,
                                                                           bm_sp_sp_diplodia_svm, bm_sp_sp_diplodia_brt)),

                            bm_sp_nsp_diplodia = mergeBenchmarkResults(list(bm_sp_nsp_diplodia_gam,
                                                                            bm_sp_nsp_diplodia_kknn, bm_sp_nsp_diplodia_rf,
                                                                            bm_sp_nsp_diplodia_svm, bm_sp_nsp_diplodia_brt)),

                            bm_nsp_nsp_diplodia = mergeBenchmarkResults(list(bm_nsp_nsp_diplodia_gam,
                                                                             bm_nsp_nsp_diplodia_kknn, bm_nsp_nsp_diplodia_rf,
                                                                             bm_nsp_nsp_diplodia_svm, bm_nsp_nsp_diplodia_brt)),

                            bm_sp_non_diplodia = mergeBenchmarkResults(list(bm_sp_non_diplodia_gam, bm_sp_non_diplodia_glm,
                                                                            bm_sp_non_diplodia_kknn, bm_sp_non_diplodia_rf,
                                                                            bm_sp_non_diplodia_svm, bm_sp_non_diplodia_brt)),

                            bm_nsp_non_diplodia = mergeBenchmarkResults(list(bm_nsp_non_diplodia_gam, bm_nsp_non_diplodia_glm,
                                                                             bm_nsp_non_diplodia_kknn, bm_nsp_non_diplodia_rf,
                                                                             bm_nsp_non_diplodia_svm, bm_nsp_non_diplodia_brt))


)

no_extract = drake_plan(
  no_extract = target(
    remove_extract(bm_result),
    transform = cross(bm_result = c(bm_sp_sp_diplodia, bm_sp_nsp_diplodia,
                                    bm_nsp_nsp_diplodia, bm_sp_non_diplodia,
                                    bm_nsp_non_diplodia,

                                    bm_sp_sp_armillaria, bm_sp_nsp_armillaria,
                                    bm_nsp_nsp_armillaria, bm_sp_non_armillaria,
                                    bm_nsp_non_armillaria,

                                    bm_sp_sp_fusarium, bm_sp_nsp_fusarium,
                                    bm_nsp_nsp_fusarium, bm_sp_non_fusarium,
                                    bm_nsp_non_fusarium,

                                    bm_sp_sp_heterobasidion, bm_sp_nsp_heterobasidion,
                                    bm_nsp_nsp_heterobasidion, bm_sp_non_heterobasidion,
                                    bm_nsp_non_heterobasidion))
  )
)

bm_all_pathogens = drake_plan(
  bm_all_pathogens = mergeBenchmarkResults(list(bm_sp_sp_diplodia, bm_sp_nsp_diplodia,
                                                bm_nsp_nsp_diplodia, bm_sp_non_diplodia,
                                                bm_nsp_non_diplodia,

                                                bm_sp_sp_armillaria, bm_sp_nsp_armillaria,
                                                bm_nsp_nsp_armillaria, bm_sp_non_armillaria,
                                                bm_nsp_non_armillaria,

                                                bm_sp_sp_fusarium, bm_sp_nsp_fusarium,
                                                bm_nsp_nsp_fusarium, bm_sp_non_fusarium,
                                                bm_nsp_non_fusarium,

                                                bm_sp_sp_heterobasidion, bm_sp_nsp_heterobasidion,
                                                bm_nsp_nsp_heterobasidion, bm_sp_non_heterobasidion,
                                                bm_nsp_non_heterobasidion))
)
