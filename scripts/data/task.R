# Heterobasidion sp ----------------------------------------------------------

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
  dummy_features = c("lithology", "soil"),
  dummy.factors = TRUE
)

fusarium_task_dummy <- task_custom(fusarium_data,
  "fusarium", "fus01",
  dummy_features = c("lithology", "soil"),
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
