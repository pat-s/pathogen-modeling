#needs(dplyr, mlr)
# library("dplyr")
# library("mlr")

# Heterobasidion sp ----------------------------------------------------------

df_hetero <- readRDS("/data/marc/mod/survey_data/heterobasi_data.rda")

df_hetero$geometry <- NULL
coordinates_hetero <- df_hetero[, c("x", "y")]
df_hetero$x <- NULL
df_hetero$y <- NULL

df_hetero_dummy <- createDummyFeatures(
  df_hetero,
  target = "heterobasi",
  cols = c(
    "lithology",
    "soil"
  )
)

# df_hetero %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

out = makeClassifTask(
  id = "heterobasidion", data = df_hetero,
  target = "heterobasi", positive = "1",
  coordinates = coordinates_hetero
) %>% saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/heterobasidion-task-dummy.rda")

# Armillaria sp -------------------------------------------------------------

# df_armi <- readRDS("/data/marc/mod/survey_data/armillaria_data.rda")
# 
# df_armi$geometry <- NULL
# coordinates_armi1 <- df_armi[, c("x", "y")]
# df_armi$x <- NULL
# df_armi$y <- NULL
# 
# makeClassifTask(
#   id = "armillaria", data = df_armi,
#   target = "armillaria", positive = "1",
#   coordinates = coordinates_armi1
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task.rda")
# 
# df_armi_dummy <- createDummyFeatures(
#   df_armi,
#   target = "armillaria",
#   cols = c(
#     "lithology",
#     "soil"
#   )
# )
# 
# # df_armi %<>%
# #   mutate_at(vars(contains('lithology')), as.factor)
# 
# coordinates_armi2 <- coordinates_armi1
# makeClassifTask(
#   id = "armillaria", data = df_armi_dummy,
#   target = "armillaria", positive = "1",
#   coordinates = coordinates_armi2
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task-dummy.rda")
# 
# # Diplodia sp -------------------------------------------------------------
# 
# df_diplo <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-dipl01.rda")
# 
# df_diplo$geometry <- NULL
# coordinates_diplo <- df_diplo[, c("x", "y")]
# df_diplo$x <- NULL
# df_diplo$y <- NULL
# 
# df_diplo_dummy <- createDummyFeatures(
#   df_diplo,
#   target = "diplo01",
#   cols = c(
#     "lithology",
#     "soil"
#   )
# )
# 
# # df_diplo %<>%
# #   mutate_at(vars(contains('lithology')), as.factor) %>%
# #   mutate_at(vars(contains('soil')), as.factor) %>%
# #   mutate_at(vars(contains('year')), as.factor)
# 
# makeClassifTask(
#   id = "diplodia", data = df_diplo,
#   target = "diplo01", positive = "1",
#   coordinates = coordinates_diplo
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/diplodia-task-dummy.rda")
# 
# # age and year are not available in the prediction data
# 
# df_diplo$year = NULL
# df_diplo$age = NULL
# coordinates_diplo1 = coordinates_diplo
# 
# makeClassifTask(
#   id = "diplodia", data = df,
#   target = "diplo01", positive = "1",
#   coordinates = coordinates_diplo1
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/diplodia-task-dummy-prediction.rda")
# 
# # Fusarium sp -------------------------------------------------------------
# 
# df_fus <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-fus01.rda")
# 
# df_fus$geometry <- NULL
# coordinates_fus <- df_fus[, c("x", "y")]
# df_fus$x <- NULL
# df_fus$y <- NULL
# 
# df_fus_dummy <- createDummyFeatures(
#   df_fus,
#   target = "fus01",
#   cols = c(
#     "lithology",
#     "soil"
#   )
# )
# 
# # df_fus %<>%
# #   mutate_at(vars(contains('lithology')), as.factor)
# 
# task_fus <- makeClassifTask(
#   id = "fusarium", data = df_fus,
#   target = "fus01", positive = "1",
#   coordinates = coordinates_fus
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/fusarium-task-dummy.rda")
# 
# # age and year are not available in the prediction data
# 
# df_fus$year = NULL
# df_fus$age = NULL
# coordinates_fus1 = coordinates_fus
# 
# task_fus1 <- makeClassifTask(
#   id = "fusarium", data = df_fus,
#   target = "fus01", positive = "1",
#   coordinates = coordinates_fus1
# ) %>%
#   saveRDS("/data/patrick/mod/pathogen-prediction/01-tasks/fusarium-task-dummy-prediction.rda")
