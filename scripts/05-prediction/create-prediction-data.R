needs(magrittr, sf, raster, lwgeom, forcats, tibble, rgdal, dplyr, mlr)

# Its a square around the Basque Country.
# This prevents error for the subsequent raster `extract` calls that may result
# in NAs if the rasters does not exceed the dimensions of the extracting area.

study_area <- st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp") %>%
  st_transform(32630) %>%
  as("Spatial")

#' ## Temperature (Mar - Sep)
#'
#' We load all images for the months March - September.
#' These are clipped in a rectangular box around the Basque Country.
#'
#'
# load only nov-april
rasters_temp = list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                          pattern = "temp_mean_03|temp_mean_04|temp_mean_05|temp_mean_06|temp_mean_07|temp_mean_08|temp_mean_09",
                          full.names = TRUE)
#'
#'
#' We load in each raster and set the projection.
#' Next, we mask the values by the study area extent and rescale the temperature values to have proper degree Celsius values.
#'
#' Then a stack is created from all the rasters and the mean is computed across all layers.
#'
#'
if (!file.exists("/data/patrick/mod/prediction/temporary/rasters_temp_mean.rda")) {
  # set up list with monthly tifs and rescale values
  rasters_temp %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area) %>%
      mask(study_area) %>%
      divide_by(10)
    return(tmp)
  })

  rasters_temp_stack = stack(rasters_temp)
  rasters_temp_mean <- stackApply(rasters_temp_stack,
                                  indices = c(rep(1, 7)), fun = mean)

  saveRDS(rasters_temp_mean, "/data/patrick/mod/prediction/temporary/rasters_temp_mean.rda")
} else {
  rasters_temp_mean <- readRDS("/data/patrick/mod/prediction/temporary/rasters_temp_mean.rda")
}
#'
#'
#' ## Prediction raster grid
#'
#' Now create a 200 x 200 point grid using a dummy raster that represents the study area shape.
#'
#' !! This is temporarly overwritten by an import of the below created file which has already the extracted ltihology information inisde.
#' This intersection was created in ArcGIS as R did not finish in one day.
#' Runtime in ArcGIS: < 1 min.
#' QGIS did not even start..
#'
#'
# df_basque <- st_read("/data/patrick/mod/prediction/temporary/basque_litho.shp")
# df_basque$OBJECTID = NULL
# df_basque$layer = NULL
# df_basque$FID_df_bas = NULL
# df_basque$slp_dgr = NULL
# df_basque$FID_litho = NULL
#'
#'
#'
#'
df_basque <- as(rasters_temp_mean, 'SpatialPixelsDataFrame') %>%
  st_as_sf()
df_basque$index_1 <- NULL
#'
#'
#' And extract the information to the new data set.
#'
#'
df_basque$temp <- raster::extract(rasters_temp_mean, df_basque)
#'
#'
#' ## Precipitation (Mar - Sep)
#'
#' We load all images for the months July - September.
#' These are clipped in a rectangular box around the Basque Country.
#'
#'
# load only nov-april
rasters_prec = list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                          pattern = "prec_r_07|prec_r_08|prec_r_09",
                          full.names = TRUE)
#'
#'
#' We load in each raster and set the projection.
#' Next, we mask the values by the study area extent and rescale the precerature values to have mm/m² values.
#'
#' Then a stack is created from all the rasters and the mean is computed across all layers.
#'
#'
if (!file.exists("/data/patrick/mod/prediction/temporary/rasters_p_sum.rda")) {
  # set up list with monthly tifs and rescale values
  rasters_prec %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area) %>%
      mask(study_area) %>%
      divide_by(10)
    return(tmp)
  })

  rasters_prec_stack = stack(rasters_prec)
  rasters_prec_sum <- stackApply(rasters_prec_stack,
                                 indices = c(rep(1, 3)), fun = sum)

  saveRDS(rasters_prec_sum, "/data/patrick/mod/prediction/temporary/rasters_p_sum.rda")
} else {
  rasters_prec_sum <- readRDS("/data/patrick/mod/prediction/temporary/rasters_p_sum.rda")
}
#'
#'
#'
df_basque$p_sum <- raster::extract(rasters_prec_sum, df_basque)
#'
#'
#' ## PISR (Mar - Sep)
#'
#' We load all images for the months July - September.
#' These are clipped in a rectangular box around the Basque Country.
#'
#'
rasters_r_sum = list.files("/data/patrick/master_thesis/AtlasClimatico/04_Tiffs_sub/",
                           pattern = "sRad_07|sRad_08|sRad_09",
                           full.names = TRUE)
#'
#'
#' We load in each raster and set the projection.
#' Next, we mask the values by the study area extent and rescale the sRaderature values to have mm/m² values.
#'
#' Then a stack is created from all the rasters and the mean is computed across all layers.
#'
#'
if (!file.exists("/data/patrick/mod/prediction/temporary/rasters_r_sum.rda")) {
  # set up list with monthly tifs and rescale values
  rasters_r_sum %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area) %>%
      mask(study_area)
    #divide_by(mean(.)) - 1
    return(tmp)
  })

  rasters_r_sum_stack = stack(rasters_r_sum)
  rasters_r_sum <- stackApply(rasters_r_sum_stack,
                              indices = c(rep(1, 3)), fun = sum)

  # trim outliers; we have around 50000 values with no information that affect the mean
  # these are coming from the sea area where no information is available
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {replace(x, x < 2000, NA)})

  # rescale to fraction its mean now and remove NA values when calc the mean
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {x / mean(x, na.rm = TRUE) - 1})

  # again trim negative outliers
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {replace(x, x < -0.1, -0.1)})

  saveRDS(rasters_r_sum, "/data/patrick/mod/prediction/temporary/rasters_r_sum.rda")
} else {
  rasters_r_sum <- readRDS("/data/patrick/mod/prediction/temporary/rasters_r_sum.rda")
}

df_basque$r_sum <- raster::extract(rasters_r_sum, df_basque)

#' ## Slope

#' We use a Digitial Elevation Model (DEM) to extract the slope (percent) using the `RSAGA` package.
#' The resulting `.sgrd` file is converted into `.tif`.

#' Object `disease_data` is converted from a `data.frame` into a spatial object
#' (`SpatialPointsDataFrame` (SPDF)) and projected to EPSG 32630.
#' The calculated slope values are read in as a raster object and extracted to the SPDF.
#' At the point of this analysis, the `raster `package was not able to deal with
#' objects of class `sf` so multiple class transformations between raster* objects and sf objects were needed.
#' This variable was also trimmed to a value of 70 for the upper end.
#' First we create a 200x200 point grid using one of the already existing raster files.

if (!file.exists("/data/patrick/mod/DEM/slope/slope_5m.tif")) {

  env <- rsaga.env(modules = "/usr/lib/x86_64-linux-gnu/saga/")
  rsaga.slope.asp.curv(in.dem = "/data/patrick/mod/DEM/dem_5m.tif",
                       out.slope = "/data/patrick/mod/DEM/slope/slope_5m",
                       unit.slope = "degrees",
                       env = env)

  rsaga.geoprocessor(lib = "io_gdal", module = 2, env = env,
                     param = list(GRIDS = "/data/patrick/mod/DEM/slope/slope_5m.sgrd",
                                  FILE = "/data/patrick/mod/DEM/slope/slope_5m.tif"))
} else {
  dem <- raster("/data/patrick/mod/DEM/slope/slope_5m.tif")
}
dem %>%
  raster::extract(df_basque) -> df_basque$slope_degrees


# Lithology ---------------------------------------------------------------

#' Read, reproject and select desired column of lithology ressource.

st_read("/data/patrick/raw/lithology/CT_LITOLOGICO_25000_ETRS89.shp", quiet = TRUE) %>%
  st_set_crs("+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs") %>%
  st_transform(32630) %>%
  select(COD_LITOLO) -> litho

#' Make it a valid polygon.
#' See also `?st_is_valid()`.

st_make_valid(litho) %>%
  st_cast("POLYGON") -> litho_valid

#' Do the intersection.

df_basque %<>%
  st_join(litho_valid)

#' Change lithology entries to descriptive names.
#' Aggregated classes are based on common lithology (sub-)classes.

df_basque %<>%
  dplyr::rename(lithology = COD_LITOLO) %>%
  mutate(lithology = as.factor(lithology)) %>%
  mutate(lithology = fct_recode(lithology,
                                NULL = "00", # water bodies
                                "surface deposits" = "01",
                                "clastic sedimentary rock" = "02",
                                "clastic sedimentary rock" = "03",
                                "biological sedimentary rock" = "04",
                                "clastic sedimentary rock" = "08",
                                "biological sedimentary rock" = "09",
                                "biological sedimentary rock" = "10",
                                "chemical sedimentary rock" = "11",
                                "chemical sedimentary rock" = "12",
                                "magmatic rock" = "13",
                                "magmatic rock" = "14",
                                "chemical sedimentary rock" = "15",
                                "biological sedimentary rock" = "16",
                                "biological sedimentary rock" = "17",
                                "dolomites" = "18",
                                "clastic sedimentary rock" = "19",
                                "magmatic rock" = "20",
                                "magmatic rock" = "22",
                                "magmatic rock" = "23",
                                NULL = "24" # riffs
  ))
#'
#'
#' ## Soil
#'
#'
st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp") %>%
  st_transform("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") %>%
  as("Spatial") -> study_area


raster("/data/patrick/raw/soil/ISRIC_world_soil_information/TAXNWRB_250m_ll.tif") %>%
  crop(study_area) %>%
  mask(study_area) %>%
  projectRaster(crs = "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs") -> soil

df_basque$soil <- raster::extract(soil, df_basque)
# "Acrisols" = "0" should be NA actually, but the 2 obs will be removed anyways
# "Albeluvisol" = "Retisols"
# as they are located in the water
df_basque %<>%
  st_as_sf() %>%
  mutate(soil = as.factor(as.integer(soil))) %>%
  mutate(soil = fct_recode(soil, "Acrisols" = "0", "Acrisols" = "1",
                           "Acrisols" = "2", "Acrisols" = "3",
                           "Acrisols" = "4", "Acrisols" = "5",
                           "Acrisols" = "6",
                           "Retisols" = "7",	"Retisols" = "8",
                           "Alisols" = "10", "Alisols" = "11",
                           "Andosols" = "12", "Andosols" = "13",
                           "Andosols" = "14", "Arenosols" = "15",
                           "Arenosols" = "16",	"Arenosols" = "17",
                           "Arenosols" = "18", "Arenosols" = "19",
                           "Arenosols" = "20",
                           "Calcisols" = "21", "Calcisols" = "22",
                           "Calcisols" = "23", "Calcisols" = "24",
                           "Cambisols" = "25",
                           "Cambisols" = "27", "Cambisols" = "26",
                           "Cambisols" = "28", "Cambisols" = "29",
                           "Cambisols" = "30", "Cambisols" = "31",
                           "Cambisols" = "32", "Cambisols" = "33",
                           "Cambisols" = "34", "Cambisols" = "35",
                           "Chernozems" = "36", "Chernozems" = "37",
                           "Chernozems" = "38", "Cryosols" = "39",
                           "Cryosols" = "40", "Cryosols" = "41",
                           "Durisols" = "42", "Ferralsols" = "43",
                           "Ferralsols" = "44", "Ferralsols" = "45",
                           "Ferralsols" = "46", "Ferralsols" = "47",
                           "Fluvisols" = "48",
                           "Fluvisols" = "49", "Fluvisols" = "50",
                           "Fluvisols" = "51",
                           "Fluvisols" = "52", "Gleysols" = "53",
                           "Gleysols" = "54", "Gleysols" = "55",
                           "Gleysols" = "56", "Gleysols" = "57",
                           "Gleysols" = "58", "Gypsisols" = "59",
                           "Gypsisols" = "60",
                           "Histosols" = "61", "Histosols" = "62",
                           "Histosols" = "63", "Histosols" = "64",
                           "Histosols" = "65", "Kastanozems" = "66",
                           "Kastanozems" = "67", "Leptosols" = "68",
                           "Leptosols" = "69", "Leptosols" = "70",
                           "Leptosols" = "71", "Leptosols" = "72",
                           "Lixisols" = "73", "Lixisols" = "74",
                           "Lixisols" = "75", "Luvisols" = "76",
                           "Luvisols" = "77", "Luvisols" = "78",
                           "Luvisols" = "79", "Luvisols" = "80",
                           "Luvisols" = "81", "Luvisols" = "82",
                           "Luvisols" = "83",
                           "Luvisols" = "84", "Nitisols" = "85",
                           "Nitisols" = "86",
                           "Phaeozems" = "87", "Phaeozems" = "88",
                           "Phaeozems" = "89",
                           "Planosols" = "90", "Planosols" = "91",
                           "Planosols" = "92",
                           "Planosols" = "93", "Planosols" = "94",
                           "Plinthosols" = "95", "Plinthosols" = "96",
                           "Podzols" = "97",
                           "Podzols" = "98", "Regosols" = "99",
                           "Solonchaks" = "107", "Solonetz" = "110",
                           "Umbrisols" = "113", "Umbrisols" = "114",
                           "Vertisols" = "115", "Vertisols" = "116"
  ))

# Source: 250m SoilGrids (worldwide) by T. Hengl -> http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0169748
#
# Legend: http://gsif.r-forge.r-project.org/soil.legends.html
#
# data("soil.legends")
#
# soil.legends$TAXNWRB
#
# Aggregate soil classes.
#
# Reference: http://www.fao.org/3/a-i3794e.pdf
# http://www.fao.org/3/i3794en/I3794en.pdf

df_basque %<>%
  st_as_sf() %>%
  mutate(soil = fct_recode(soil,
                           "soils with limitations to root growth" = "Leptosols",
                           "soils with limitations to root growth" = "Cryosols",
                           "soils with limitations to root growth" = "Vertisols",
                           "soils with limitations to root growth" = "Solonetz",
                           "soils with limitations to root growth" = "Solonchaks",
                           "soils with clay-enriched subsoil" = "Luvisols",
                           "soils with clay-enriched subsoil" = "Lixisols",
                           "soils with clay-enriched subsoil" = "Acrisols",
                           "soils with clay-enriched subsoil" = "Retisols",
                           "soils with clay-enriched subsoil" = "Alisols",
                           "organic soil" = "Histosols",
                           "pronounced accumulation of organic matter in the mineral topsoil" = "Kastanozems",
                           "pronounced accumulation of organic matter in the mineral topsoil" = "Chernozems",
                           "pronounced accumulation of organic matter in the mineral topsoil" = "Phaeozems",
                           "pronounced accumulation of organic matter in the mineral topsoil" = "Umbrisols",
                           "accumulation of moderately soluble salts or non-saline substances" = "Gypsisols",
                           "accumulation of moderately soluble salts or non-saline substances" = "Durisols",
                           "accumulation of moderately soluble salts or non-saline substances" = "Calcisols",
                           "soils distinguished by Fe/Al chemistry" = "Gleysols",
                           "soils distinguished by Fe/Al chemistry" = "Podzols",
                           "soils distinguished by Fe/Al chemistry" = "Plinthosols",
                           "soils distinguished by Fe/Al chemistry" = "Planosols",
                           "soils distinguished by Fe/Al chemistry" = "Nitisols",
                           "soils distinguished by Fe/Al chemistry" = "Andosols",
                           "soils with little or no profile differentiation" = "Fluvisols",
                           "soils with little or no profile differentiation" = "Cambisols",
                           "soils with little or no profile differentiation" = "Arenosols",
                           "soils with little or no profile differentiation" = "Regosols",
                           "soils distinguished by Fe/Al chemistry" = "Ferralsols"
  ))

# Hail probability --------------------------------------------------------

# Read in raster file.

hail_ras <- raster("/data/patrick/raw/hail/Prob_GAM_square_area.tif")

# Extract values to object `df_basque`.

hail_ras %>%
  raster::extract(df_basque) -> df_basque$hail_prob

# Elevation ---------------------------------------------------------------

raster("/data/patrick/mod/DEM/dem_5m.tif") %>%
  raster::extract(df_basque) -> df_basque$elevation


# ph ----------------------------------------------------------------------

new("GDALReadOnlyDataset", "/data/patrick/raw/ph_europe/ph_cacl2") %>%
  asSGDF_GROD() %>%
  raster() -> ph

#' Read in the study area polygon and crop the raster image to it.
#' For speed reasons, we first project the `pH` raster to the CRS of `study_area` and coerce it to the CRS of `df_basque` after the `crop()` call.

st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp") %>%
  st_transform(3035) %>%
  as("Spatial") -> study_area

crs(ph) <- "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

ph %<>%
  crop(study_area) %>%
  mask(study_area) %>%
  projectRaster(crs = "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")

#' Finally, extract values to `df_basque`.
raster::extract(ph, df_basque) -> df_basque$ph

#' ## Remove NAs
df_basque %<>% na.omit()
saveRDS(df_basque, "/data/patrick/mod/prediction/temporary/df_basque.rda")

# Predict -----------------------------------------------------------------

#' Make prediction data.frame

df_basque_pred <- df_basque
df_basque_pred = st_set_geometry(df_basque_pred, NULL)
df_basque_pred$x = NULL
df_basque_pred$y = NULL

df_basque_pred <- createDummyFeatures(
  df_basque_pred,
  #target = "heterobasidion",
  cols = c(
    "lithology",
    "soil"
  )
)

saveRDS(df_basque_pred, "/data/patrick/mod/pathogen-prediction/07-prediction/prediction-df.rda")
