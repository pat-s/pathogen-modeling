data_basque = st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp")
data_temperature = list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                              pattern = "temp_mean_03|temp_mean_04|temp_mean_05|temp_mean_06|temp_mean_07|temp_mean_08|temp_mean_09",
                              full.names = TRUE)

data_precipitation = list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                         pattern = "prec_r_07|prec_r_08|prec_r_09",
                         full.names = TRUE)

data_pisr= list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                        pattern = "sRad_07|sRad_08|sRad_09",
                        full.names = TRUE)
data_dem = as.character("/data/patrick/mod/DEM/dem_5m.tif")

data_soil = raster("/data/patrick/raw/soil/ISRIC_world_soil_information/TAXNWRB_250m_ll.tif")

data_lithology = st_read("/data/patrick/raw/lithology/CT_LITOLOGICO_25000_ETRS89.shp", quiet = TRUE)

data_hail = raster("/data/patrick/raw/hail/Prob_GAM_square_area.tif")

data_ph = new("GDALReadOnlyDataset", "/data/patrick/raw/ph_europe/ph_cacl2") %>%
  asSGDF_GROD() %>%
  raster()
