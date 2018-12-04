# Heterobasidion sp ----------------------------------------------------------

df_hetero <- readRDS("/data/marc/mod/survey_data/heterobasi_data.rda")

coordinates_hetero <- df_hetero[, c("x", "y")]

df_heterobasidion_mod = df_hetero %>%
  st_as_sf(coords = c("x", "y")) %>%
  st_set_geometry(NULL)

df_hetero_dummy <- createDummyFeatures(
  df_heterobasidion_mod,
  target = "heterobasi",
  cols = c(
    "lithology",
    "soil"
  )
)

# df_hetero %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

heterobasidion_task_dummy = makeClassifTask(
  id = "heterobasidion", data = df_hetero_dummy,
  target = "heterobasi", positive = "1",
  coordinates = coordinates_hetero
)

# Armillaria sp -------------------------------------------------------------

df_armillaria <- readRDS("/data/marc/mod/survey_data/armillaria_data.rda")

coordinates_armi <- df_armillaria[, c("x", "y")]

df_armillaria_mod = df_armillaria %>%
  st_as_sf(coords = c("x", "y")) %>%
  st_set_geometry(NULL)

armillaria_task = makeClassifTask(
  id = "armillaria", data = df_armillaria_mod,
  target = "armillaria", positive = "1",
  coordinates = coordinates_armi
)

df_armi_dummy <- createDummyFeatures(
  df_armillaria_mod,
  target = "armillaria",
  cols = c(
    "lithology",
    "soil"
  )
)

# df_armi %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

armillaria_task_dummy = makeClassifTask(
  id = "armillaria", data = df_armi_dummy,
  target = "armillaria", positive = "1",
  coordinates = coordinates_armi
)

# Diplodia sp -------------------------------------------------------------

df_diplodia <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-dipl01.rda")

coordinates_diplo <- df_diplodia[, c("x", "y")]

df_diplo_mod = df_diplodia %>%
  st_as_sf(coords = c("x", "y")) %>%
  st_set_geometry(NULL)

df_diplo_dummy <- createDummyFeatures(
  df_diplo_mod,
  target = "diplo01",
  cols = c(
    "lithology",
    "soil"
  )
)

# df_diplo %<>%
#   mutate_at(vars(contains('lithology')), as.factor) %>%
#   mutate_at(vars(contains('soil')), as.factor) %>%
#   mutate_at(vars(contains('year')), as.factor)

diplodia_task_dummy = makeClassifTask(
  id = "diplodia", data = df_diplo_dummy,
  target = "diplo01", positive = "1",
  coordinates = coordinates_diplo
)

# age and year are not available in the prediction data

df_diplodia_pred =  df_diplo_dummy %>%
  select(-year, -age)

diplodia_task_dummy_prediction = makeClassifTask(
  id = "diplodia", data = df_diplodia_pred,
  target = "diplo01", positive = "1",
  coordinates = coordinates_diplo
)

# Fusarium sp -------------------------------------------------------------

df_fusarium <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-fus01.rda")

coordinates_fus <- df_fusarium[, c("x", "y")]

df_fusarium_mod = df_fusarium %>%
  st_as_sf(coords = c("x", "y")) %>%
  st_set_geometry(NULL)

df_fusarium_dummy <- createDummyFeatures(
  df_fusarium_mod,
  target = "fus01",
  cols = c(
    "lithology",
    "soil"
  )
)

# df_fus %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

fusarium_task_dummy <- makeClassifTask(
  id = "fusarium", data = df_fusarium_dummy,
  target = "fus01", positive = "1",
  coordinates = coordinates_fus
)

# age and year are not available in the prediction data

df_fusarium_dummy_prediction = df_fusarium_dummy %>%
  select(-year, -age)

fusarium_task_dummy_prediction <- makeClassifTask(
  id = "fusarium", data = df_fusarium_dummy_prediction,
  target = "fus01", positive = "1",
  coordinates = coordinates_fus
)
