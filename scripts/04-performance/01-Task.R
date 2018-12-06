# Heterobasidion sp ----------------------------------------------------------

heterobasidion_task_dummy <- task_custom("/data/marc/mod/survey_data/heterobasi_data.rda",
  "heterobasidion", "heterobasi",
  dummy_features = c("lithology", "soil"),
  dummy.factors = TRUE
)

armillaria_task_dummy <- task_custom("/data/marc/mod/survey_data/armillaria_data.rda",
  "armillaria", "armillaria",
  dummy_features = c("lithology", "soil"),
  dummy.factors = TRUE
)

diplodia_task_dummy <- task_custom("/data/patrick/mod/survey_data/2009-2012/data-clean-dipl01.rda",
  "diplodia", "diplo01",
  dummy_features = c("lithology", "soil"),
  dummy.factors = TRUE
)

fusarium_task_dummy <- task_custom("/data/patrick/mod/survey_data/2009-2012/data-clean-fus01.rda",
  "fusarium", "fus01",
  dummy_features = c("lithology", "soil"),
  dummy.factors = TRUE
)

# diplodia_task_dummy_prediction <- task_custom_prediction("/data/patrick/mod/survey_data/2009-2012/data-clean-dipl01.rda",
#   "diplodia", "diplo01",
#   dummy_features = c("lithology", "soil"),
#   dummy.factors = TRUE,
#   remove.vars = TRUE
# )
#
# fusarium_task_dummy_prediction <- task_custom_prediction("/data/patrick/mod/survey_data/2009-2012/data-clean-fus01.rda",
#   "fusarium", "fus01",
#   dummy_features = c("lithology", "soil"),
#   dummy.factors = TRUE,
#   remove.vars = TRUE
# )

tasks <- list(
  armillaria_task_dummy,
  heterobasidion_task_dummy,
  diplodia_task_dummy,
  fusarium_task_dummy
)
