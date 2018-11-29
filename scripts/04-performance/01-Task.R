needs(dplyr, mlr)

# Heterobasidion sp ----------------------------------------------------------

df <- readRDS("/data/marc/mod/survey_data/heterobasi_data.rda")

df$geometry <- NULL
coordinates <- df[, c("x", "y")]
df$x <- NULL
df$y <- NULL

df <- createDummyFeatures(
  df,
  target = "heterobasi",
  cols = c(
    "lithology",
    "soil"
  )
)

df %<>%
  mutate_at(vars(contains('lithology')), as.factor)

task_spatial <- makeClassifTask(
  id = "heterobasidion", data = df,
  target = "heterobasi", positive = "1",
  coordinates = coordinates
)

saveRDS(task_spatial, "/data/patrick/mod/pathogen-prediction/01-tasks/heterobasidion-task-dummy.rda")

# Armillaria sp -------------------------------------------------------------

df <- readRDS("/data/marc/mod/survey_data/armillaria_data.rda")

df$geometry <- NULL
coordinates <- df[, c("x", "y")]
df$x <- NULL
df$y <- NULL

task_spatial <- makeClassifTask(
  id = "armillaria", data = df,
  target = "armillaria", positive = "1",
  coordinates = coordinates
)

saveRDS(task_spatial, "/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task.rda")

df <- createDummyFeatures(
  df,
  target = "armillaria",
  cols = c(
    "lithology",
    "soil"
  )
)

# df %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

task_spatial <- makeClassifTask(
  id = "armillaria", data = df,
  target = "armillaria", positive = "1",
  coordinates = coordinates
)

saveRDS(task_spatial, "/data/patrick/mod/pathogen-prediction/01-tasks/armillaria-task-dummy.rda")

# Diplodia sp -------------------------------------------------------------

df <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-dipl01.rda")

df$geometry <- NULL
coordinates <- df[, c("x", "y")]
df$x <- NULL
df$y <- NULL

df <- createDummyFeatures(
  df,
  target = "diplo01",
  cols = c(
    "lithology",
    "soil", 
    "year"
  )
)

# df %<>%
#   mutate_at(vars(contains('lithology')), as.factor) %>%
#   mutate_at(vars(contains('soil')), as.factor) %>%
#   mutate_at(vars(contains('year')), as.factor)

task_spatial <- makeClassifTask(
  id = "diplodia", data = df,
  target = "diplo01", positive = "1",
  coordinates = coordinates
)

saveRDS(task_spatial, "/data/patrick/mod/pathogen-prediction/01-tasks/diplodia-task-dummy.rda")

# Fusarium sp -------------------------------------------------------------

df <- readRDS("/data/patrick/mod/survey_data/2009-2012/data-clean-fus01.rda")

df$geometry <- NULL
coordinates <- df[, c("x", "y")]
df$x <- NULL
df$y <- NULL

df <- createDummyFeatures(
  df,
  target = "fus01",
  cols = c(
    "lithology",
    "soil"
  )
)

# df %<>%
#   mutate_at(vars(contains('lithology')), as.factor)

task_spatial <- makeClassifTask(
  id = "fusarium", data = df,
  target = "fus01", positive = "1",
  coordinates = coordinates
)

saveRDS(task_spatial, "/data/patrick/mod/pathogen-prediction/01-tasks/fusarium-task-dummy.rda")