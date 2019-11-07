library(magrittr)
library(readr)
library(raster)
library(sf)
library(dplyr)
pr_1km_CAPV_Arakil <- read.table(file = "data/02-pr/pr/pr_1km_CAPV_Arakil.csv", sep = ",", dec = ".", header = TRUE)

test = tidyr::gather(pr_1km_CAPV_Arakil, "coord_id", "p_sum", -YYYYMMDD, factor_key = F) %>%
  #dplyr::filter(coord_id != "X22512") %>%
  dplyr::rename(date = YYYYMMDD) %>%
  dplyr::mutate(date = as.character(date)) %>%
  dplyr::mutate(date = lubridate::as_date(date)) %>%
  dplyr::filter(date > "2000-01-01") %>%
  dplyr::mutate(coord_id = stringr::str_remove(coord_id, "X")) %>%
  dplyr::mutate(month = lubridate::month(date)) %>% # create month column (includes all years)
  dplyr::group_by(month, coord_id) %>%
  dplyr::summarise_at("p_sum", mean) # get the summarised p_sum for the respective grouping

coordinates = readr::read_table2("data/01_grid_1km_cuencas/grid_1km_cuencas_etrs89/stations_Arakil_etrs89.txt",
                                 col_type = readr::cols(station_id = col_character()))

df_bind = dplyr::left_join(test, coordinates, by = c("coord_id" = "station_id"))

df_bind %<>%
  dplyr::rename(x = UTMXetrs89) %>%
  dplyr::rename(y = UTMYetrs89) %>%
  dplyr::mutate(month = as.factor(as.character(month))) %>%
  dplyr::select(x, y, p_sum, month)

#df_month = split(df_bind, df_bind$month, drop = FALSE)

x = df_bind %>% group_split(month, keep = FALSE)

x = map(x, ~ as.data.frame(.x, xy = TRUE))

x_st = map(x, ~ st_as_sf(.x, coords = c("x", "y"), crs = 25830))
x_sp = map(x_st, ~ as(.x, "Spatial"))
x_spdf = map(x_sp, ~ SpatialPixelsDataFrame(.x, tolerance = 0.973816, .x@data))
x_ras = map(x_spdf, ~ raster(.x))
