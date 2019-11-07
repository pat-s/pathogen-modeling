
# tasks all predictors ----------------------------------------------------

heterobasidion_task_dummy <- task_custom(heterobasidion_data,
                                         "heterobasidion", "heterobasi",
                                         dummy_features = c("lithology", "soil"),
                                         dummy.factors = TRUE
)

armillaria_task_dummy <- task_custom(armillaria_data,
                                     "armillaria", "armillaria",
                                     dummy_features = c("lithology", "soil"),
                                     dummy.factors = TRUE
)

diplodia_task_dummy <- task_custom(diplodia_data,
                                   "diplodia", "diplo01",
                                   dummy_features = c("lithology", "soil", "year"),
                                   dummy.factors = TRUE
)

diplodia_task <- task_custom(diplodia_data,
                             "diplodia", "diplo01",
                             dummy_features = c("lithology", "soil", "year"),
                             dummy.factors = FALSE
)

fusarium_task_dummy <- task_custom(fusarium_data,
                                   "fusarium", "fus01",
                                   dummy_features = c("lithology", "soil", "year"),
                                   dummy.factors = TRUE
)

diplodia_task_dummy_prediction <- task_custom_prediction(diplodia_data,
                                                         "diplodia", "diplo01",
                                                         dummy_features = c("lithology", "soil"),
                                                         dummy.factors = TRUE,
                                                         remove.vars = TRUE
)

fusarium_task_dummy_prediction <- task_custom_prediction(fusarium_data,
                                                         "fusarium", "fus01",
                                                         dummy_features = c("lithology", "soil"),
                                                         dummy.factors = TRUE,
                                                         remove.vars = TRUE
)

# tasks no ph -------------------------------------------------------------


heterobasidion_task_dummy_no_ph <- task_custom(heterobasidion_data_no_ph,
                                               "heterobasidion", "heterobasi",
                                               dummy_features = c("lithology", "soil"),
                                               dummy.factors = TRUE
)

armillaria_task_dummy_no_ph <- task_custom(armillaria_data_no_ph,
                                           "armillaria", "armillaria",
                                           dummy_features = c("lithology", "soil"),
                                           dummy.factors = TRUE
)

diplodia_task_dummy_no_ph <- task_custom(diplodia_data_no_ph,
                                         "diplodia", "diplo01",
                                         dummy_features = c("lithology", "soil", "year"),
                                         dummy.factors = TRUE
)

diplodia_task_no_ph <- task_custom(diplodia_data_no_ph,
                                   "diplodia", "diplo01",
                                   dummy_features = c("lithology", "soil", "year"),
                                   dummy.factors = FALSE
)

fusarium_task_dummy_no_ph <- task_custom(fusarium_data_no_ph,
                                         "fusarium", "fus01",
                                         dummy_features = c("lithology", "soil", "year"),
                                         dummy.factors = TRUE
)

diplodia_task_dummy_prediction_no_ph <- task_custom_prediction(diplodia_data_no_ph,
                                                               "diplodia", "diplo01",
                                                               dummy_features = c("lithology", "soil"),
                                                               dummy.factors = TRUE,
                                                               remove.vars = TRUE
)

fusarium_task_dummy_prediction_no_ph <- task_custom_prediction(fusarium_data_no_ph,
                                                               "fusarium", "fus01",
                                                               dummy_features = c("lithology", "soil"),
                                                               dummy.factors = TRUE,
                                                               remove.vars = TRUE
)

# Debugging tasks ---------------------------------------------------------

# We can't put them into a list because each one needs its own prediction task

diplodia_task_dummy_prediction_no_temp <- task_custom_prediction(diplodia_data_no_temp,
                                                                 "diplodia", "diplo01",
                                                                 dummy_features = c("lithology", "soil"),
                                                                 dummy.factors = TRUE,
                                                                 remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_precip <- task_custom_prediction(diplodia_data_no_precip,
                                                                   "diplodia", "diplo01",
                                                                   dummy_features = c("lithology", "soil"),
                                                                   dummy.factors = TRUE,
                                                                   remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_hail <- task_custom_prediction(diplodia_data_no_hail,
                                                                 "diplodia", "diplo01",
                                                                 dummy_features = c("lithology", "soil"),
                                                                 dummy.factors = TRUE,
                                                                 remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_soil <- task_custom_prediction(diplodia_data_no_soil,
                                                                 "diplodia", "diplo01",
                                                                 dummy_features = c("lithology"),
                                                                 dummy.factors = TRUE,
                                                                 remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_lithology <- task_custom_prediction(diplodia_data_no_lithology,
                                                                      "diplodia", "diplo01",
                                                                      dummy_features = c("soil"),
                                                                      dummy.factors = TRUE,
                                                                      remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_slope <- task_custom_prediction(diplodia_data_no_slope,
                                                                  "diplodia", "diplo01",
                                                                  dummy_features = c("lithology", "soil"),
                                                                  dummy.factors = TRUE,
                                                                  remove.vars = TRUE
)

diplodia_task_dummy_prediction_no_pisr <- task_custom_prediction(diplodia_data_no_pisr,
                                                                 "diplodia", "diplo01",
                                                                 dummy_features = c("lithology", "soil"),
                                                                 dummy.factors = TRUE,
                                                                 remove.vars = TRUE
)

# Combined tasks ---------------------------------------------------------

tasks <- list(
  armillaria_task_dummy,
  heterobasidion_task_dummy,
  diplodia_task_dummy,
  fusarium_task_dummy
)

tasks_pred <- list(
  armillaria_task_dummy,
  heterobasidion_task_dummy,
  diplodia_task_dummy_prediction,
  fusarium_task_dummy_prediction
)

tasks_pred_no_ph <- list(
  armillaria_task_dummy_no_ph,
  heterobasidion_task_dummy_no_ph,
  diplodia_task_dummy_prediction_no_ph,
  fusarium_task_dummy_prediction_no_ph
)
