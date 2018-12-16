task_custom <- function(data, name, target, dummy_features, dummy.factors = FALSE) {


  coordinates <- data[, c("x", "y")]

  data %<>%
    st_as_sf(coords = c("x", "y")) %>%
    st_set_geometry(NULL)

  # for some reason we need to remove the geom column twice?!
  if (!is.null(data$geometry)) {
    data$geometry = NULL
  }

  if (isTRUE(dummy.factors)) {
    data %<>% createDummyFeatures(
      target = target,
      cols = dummy_features
    )
  }

  task <- makeClassifTask(
    id = name, data = data,
    target = target, positive = "1",
    coordinates = coordinates
  )

  return(task)
}


task_custom_prediction <- function(data, name, target, dummy_features, dummy.factors = FALSE,
                                   remove.vars = FALSE) {
  task <- task_custom(
    data = data, name = name, target = target,
    dummy_features = dummy_features, dummy.factors = dummy.factors
  )

  if (all(c("year", "age") %in% colnames(task$env$data)) && isTRUE(remove.vars)) {
    df <- task$env$data %>%
      dplyr::select(-year, -age)
  }

  task <- makeClassifTask(
    id = name, data = df,
    target = target, positive = "1",
    coordinates = task$coordinates
  )
  return(task)
}

create_prediction_data <- function(temperature, precipitation, pisr, slope,
                                   elevation, soil, lithology, hail, ph,
                                   study_area) {

  # Its a square around the Basque Country.
  # This prevents error for the subsequent raster `extract` calls that may result
  # in NAs if the rasters does not exceed the dimensions of the extracting area.

  # study_area1 <- study_area %>%
  #   st_transform(32630) %>%
  #   as("Spatial")


  #' ## Prediction raster grid
  #'
  #' Now create a 200 x 200 point grid using a dummy raster that represents the study area shape.
  #'
  #' !! This is temporarly overwritten by an import of the below created file which has already the extracted ltihology information inisde.
  #' This intersection was created in ArcGIS as R did not finish in one day.
  #' Runtime in ArcGIS: < 1 min.
  #' QGIS did not even start..
  #'
  pred_grid <- as(temperature, "SpatialPixelsDataFrame")
  pred_grid = st_as_sf(pred_grid)

  # Precipitation

  pred_grid$precipitation <-
    precipitation %>%
    raster::extract(pred_grid)

  # Temperature

  pred_grid %<>%
    dplyr::rename(temp = layer)

  # PISR

  pred_grid$pisr <-
    pisr %>%
    raster::extract(pred_grid)

  # Slope

  pred_grid$slope_degrees <-
    slope %>%
    raster::extract(pred_grid)

  # Lithology

  pred_grid %<>% st_join(lithology)

  pred_grid %<>%
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
                                  "chemical sedimentary rock" = "18",
                                  "clastic sedimentary rock" = "19",
                                  "magmatic rock" = "20",
                                  "magmatic rock" = "22",
                                  "magmatic rock" = "23",
                                  "magmatic rock" = "24"
    ))


  # Soil

  pred_grid$soil <-
    soil %>%
    raster::extract(pred_grid)

  data("soil.legends")
  soil_legend <- as_tibble(soil.legends$TAXNWRB)

  pred_grid %<>%
    left_join(soil_legend, by = c("soil" = "Number")) %>%
    dplyr::select(-one_of("Shortened_name", "Group", "COLOR", "soil")) %>%
    dplyr::rename(soil = Generic) %>%
    mutate(soil = as.factor(soil))

  pred_grid %<>%
    mutate(soil = fct_recode(soil,
                             "soils with limitations to root growth" = "Leptosols",
                             "soils with limitations to root growth" = "Cryosols",
                             "soils with limitations to root growth" = "Vertisols",
                             "soils with limitations to root growth" = "Solonetz",
                             "soils with limitations to root growth" = "Solonchaks",
                             "soils with clay-enriched subsoil" = "Luvisols",
                             "soils with clay-enriched subsoil" = "Lixisols",
                             "soils with clay-enriched subsoil" = "Acrisols",
                             # "soils with clay-enriched subsoil" = "Retisols",
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
                             "soils distinguished by Fe/Al chemistry" = "Ferralsols",
                             "soils distinguished by Fe/Al chemistry" = "Stagnosols"
    ))

  # Hail

  pred_grid$hail_probability <-
    hail %>%
    raster::extract(pred_grid)

  # Elevation

  pred_grid$elevation <-
    elevation %>%
    raster::extract(pred_grid)

  # ph

  pred_grid$ph <-
    ph %>%
    raster::extract(pred_grid)

  #' Make prediction data.frame

  pred_grid %<>%
    st_set_geometry(NULL)
  pred_grid$x <- NULL
  pred_grid$y <- NULL
  pred_grid$index_1 <- NULL

  pred_grid %<>% createDummyFeatures(
    # target = "heterobasidion",
    cols = c(
      "lithology",
      "soil"
    )
  )

  pred_grid %<>%
    na.omit()

  return(pred_grid)
}


age_imp_preprocessing = function(data) {
  data %<>%
    filter(!is.na(age))

  # We trimmed age > 40 to reduce influence of outliers.

  data %<>%
    mutate(age = as.numeric(levels(age)[age])) %>%
    mutate(age = replace(age, age > 40, 40))

  res <- test_age_imputation(data$x, data$y, data$age)
  summary(res)

  # qplot(res$obs, res$imput) + geom_abline() + hrbrthemes::theme_ipsum_rc()
  # cor(res$obs, res$imput, use = "complete")

  data$age <- age_imputation(data$x, data$y,
                             data$age, print = TRUE)
  return(data)
}

hail_download = function(path) {

  dir_create("data/hail")

  if (!file.exists("data/hail/hail.tif")) {
    curl_download(path,
                  destfile = "data/hail/hail.tif", quiet = FALSE)
  }

  hail <- raster("data/hail/hail.tif")

  return(hail)

}

precipitation_preprocessing = function(atlas_climatico) {

  # Atlas climatico is a prerequisite for the following task
  # However we do not want to do run it every time
  # by specifying it as an unused argument we trigger is as a drake dependency

  #' ## Precipitation
  #'
  #' Raw data: Precipitation rasters for month july and august in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Add precipitation of month july and august and write raster to disk.
  #'           Extract precipitation at each observation.
  #'
  #' Modified data: Total july and august precipitation raster in `.tif` format in CRS 32630.

  precip = list.files("data/atlas-climatico/unzip",
                      "pluvio.*(julio|agosto)_av.tif$",
                      full.names = TRUE
  ) %>%
    stack() %>%
    calc(function(x) {
      sum(x) / 10
    })

  return(precip)
}

pisr_preprocessing = function(atlas_climatico) {

  # Atlas climatico is a prerequisite for the following task
  # However we do not want to do run it every time
  # by specifying it as an unused argument we trigger is as a drake dependency)

  #' ## PISR
  #'
  #' Raw data: PISR rasters for month july to september in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Add pisr of july to september and convert to the relative fraction of its mean (mean = 8065.952 kW/m^2).
  #'           Write raster to disk and extract pisr at each observation.
  #'
  #' Modified data: PISR raster in `.tif` format in CRS 32630.
  #'


  psir_sum_raster <-
    list.files("data/atlas-climatico/unzip",
               "radiacion.*(julio|agosto|septiembre)_av.tif$",
               full.names = TRUE
    ) %>%
    stack() %>%
    sum()

  psir_sum_raster %<>%
    calc(function(x) {
      x / cellStats(psir_sum_raster, stat = mean, na.rm = TRUE) - 1
    })

  return(psir_sum_raster)
}

temperature_preprocessing = function(atlas_climatico) {

  # Atlas climatico is a prerequisite for the following task
  # However we do not want to do run it every time
  # by specifying it as an unused argument we trigger is as a drake dependency

  #' ## Temperature
  #'
  #' Raw data: Temperature rasters for month march to september in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Calculate mean temperature of month march to september and write raster to disk.
  #'           Extract mean summer temperature at each observation.
  #'
  #' Modified data: Mean summer temperature raster in `.tif` format in CRS 32630.

  temperature_mean = list.files("data/atlas-climatico/unzip",
                                "termo.*(marzo|abril|mayo|junio|julio|agosto|septiembre)_av.tif$",
                                full.names = TRUE
  ) %>%
    stack() %>%
    calc(function(x) {
      mean(x) / 10
    })

  return(temperature_mean)
}

atlas_climatico_download = function(path) {

  dir_create("data/atlas-climatico")

  if (!file.exists("data/atlas-climatico/mn_de.zip")) {
    curl_download(path,
                  destfile = glue(tempdir(), "/atlas-climatico.zip"), quiet = FALSE)
    unzip(glue(tempdir(), "/atlas-climatico.zip"), exdir = "data/atlas-climatico")
  }

  files = c("^mt.*_av.zip$", "^rad.*_av.zip$", "^pl.*_av.zip$") %>% # , "^rad.*_av.zip$", "^pl.*_av.zip$"
    map(function(x) list.files(
      path = "data/atlas-climatico",
      pattern = x,
      full.names = TRUE
    ))

  return(files)

}

atlas_climatico_preprocessing = function(path,
                                         study_area) {

  #' ## Atlas Climatico
  #'
  #' Raw data: Zipped raster files of temperature, pisr and precipitation in `.txt` format in CRS 23030.
  #'
  #' Workflow: Unzip files specified by pattern.
  #'           Remove unused `.gif` and `.htm` files.
  #'           Reproject study area to CRS 23030 to crop and mask raster files.
  #'           Reproject raster files to CRS 32630.
  #'           Write raster files to disk.
  #'           Remove unused `.txt` files
  #'
  #' Mod data: Temperature, pisr and precipitation rasters in `.tif` format in CRS 32630 for each month.
  #'

  path %>%
    unlist() %>%
    walk(unzip, exdir = "data/atlas-climatico/unzip")

  list.files("data/atlas-climatico/unzip",
             pattern = "*.(gif|htm)$",
             full.names = TRUE
  ) %>%
    walk(file.remove)

  study_area_23030 <-
    study_area %>%
    st_transform(23030) %>%
    as("Spatial")

  txt_files <- list.files("data/atlas-climatico/unzip",
                          pattern = ".txt$",
                          full.names = TRUE
  )

  file_names <- map(txt_files, function(x) sub("txt", x, replacement = "tif")) %>%
    unlist()

  out = map(txt_files, raster, crs = CRS("+init=epsg:23030")) %>%
    map(crop, y = study_area_23030) %>%
    map(mask, mask = study_area_23030) %>%
    map(projectRaster, crs = CRS("+init=epsg:32630")) %>%
    walk2(file_names, writeRaster, overwrite = TRUE)

  return(out)

}

lithology_download = function(path) {

  dir_create("data/lithology")

  if (!file.exists("data/lithology/CT_LITOLOGICO_25000_ETRS89.shp")) {
    curl_download(path,
                  destfile = glue(tempdir(), "/lithology.zip"), quiet = FALSE)
    unzip(glue(tempdir(), "/lithology.zip"), exdir = "data/lithology")
  }

  lithology = st_read("data/lithology/CT_LITOLOGICO_25000_ETRS89.shp", quiet = TRUE) %>%
    st_set_crs(25830) %>%
    st_transform(32630) %>%
    dplyr::select(COD_LITOLO)

  return(lithology)

}

lithology_preprocessing = function(lithology) {

  #' Raw data: Polygon shapefile with lithology units in CRS 25830.
  #'
  #' Workflow: Read shapefile and reproject to CRS 32630.
  #'           Extract column with lithology unit id.
  #'           Make lithology sf object valid and extract at each observation the lithology unit id.
  #'           Aggregate lithology units to common lithology classes.
  #'
  #' Output: Aggregated lithology units.
  #'
  #'
  # curl_download(path,
  #               destfile = glue(tempdir(), "/lithology.zip"), quiet = FALSE)
  # unzip(glue(tempdir(), "/lithology.zip"), exdir = glue(tempdir(), "/lithology"))
  #
  # st_read(glue(tempdir(), "/lithology/CT_LITOLOGICO_25000_ETRS89.shp"), quiet = TRUE) %>%
  #   st_set_crs(25830) %>%
  #   st_transform(32630) %>%
  #   dplyr::select(COD_LITOLO) -> lithology_sp

  lithology %<>%
    st_make_valid() %>%
    st_cast("POLYGON")

  return(lithology)

}

ph_download = function(path) {

  dir_create("data/ph")

  if (!file.exists("data/ph/dblbnd.adf")) {
    curl_download(path,
                  destfile = glue(tempdir(), "/ph.zip"), quiet = FALSE)
    unzip(glue(tempdir(), "/ph.zip"), exdir = "data/ph")
  }

  ph_raster <-
    new("GDALReadOnlyDataset", "data/ph") %>%
    asSGDF_GROD() %>%
    raster()

  return(ph_raster)

}

ph_preprocessing = function(path,
                            study_area) {

  crs(path) <- CRS("+init=epsg:3035")

  study_area_3035 <-
    study_area %>%
    st_transform(3035) %>%
    as("Spatial")

  path %<>%
    crop(study_area_3035) %>%
    mask(study_area_3035) %>%
    projectRaster(crs = CRS("+init=epsg:32630"), method = "bilinear") %>%
    writeRaster("data/ph/ph.tif", overwrite = TRUE)

  return(path)
}

elevation_preprocessing = function(path) {

  #' Raw data: Zipped 5m lidar DEM in CRS 3042 in `.tif` format.
  #'
  #' Workflow: Reprojection on CRS 32630. Extraction of the elevation values for each observation.
  #'
  #' Mod data: DEM with 5m resolution in `.tif` format in CRS 32630.

  dem = raster(path) %>%
    projectRaster(crs = CRS("+init=epsg:32630"), method = "bilinear") %>%
    writeRaster("data/dem/dem.tif", overwrite = TRUE)

  return(dem)
}

soil_download = function(path) {

  dir_create("data/soil")

  curl_download(path,
                destfile = "data/soil/soil.tif", quiet = FALSE)

  soil = raster("data/soil/soil.tif")

  return(soil)
}

soil_preprocessing = function(path,
                              study_area) {

  #' ## Soil
  #'
  #' Raw data: Soil raster with 250m resolution in `.tif`format in CRS 4326 (Hengl 2017, http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0169748).
  #'
  #' Workflow: Reproject study area to CRS 4326.
  #'           Crop soil raster with study area and reproject to CRS 23030.
  #'           Extraction of the soil value for each record.
  #'           Left join with soil database from GSIF package to get actual soil name.
  #'           Remove unused columns and factor soil name.
  #'
  #' Output: Soil raster with 250 m resolution in `.tif` format in CRS 23030.
  #'

  study_area_4326 <-
    study_area %>%
    st_transform(4326) %>%
    as("Spatial")

  soil_ras = path %>%
    crop(study_area_4326) %>%
    mask(study_area_4326) %>%
    projectRaster(crs = CRS("+init=epsg:32630"), method = "ngb")

  return(soil_ras)

}

dem_download = function(path) {

  dir_create("data/dem")

  if (!file.exists("data/dem/mdt_2013_5m.tif")) {
    curl_download(path,
                  destfile = glue(tempdir(), "/dem.zip"), quiet = FALSE)
    unzip(glue(tempdir(), "/dem.zip"), exdir = "data/dem")
  }

  dem = raster("data/dem/mdt_2013_5m.tif") # just to detect errors
  dem = "data/dem/mdt_2013_5m.tif"

  return(dem)

}

slope_processing = function(path) {

  #' ## Slope
  #'
  #' Raw data: Reprojected DEM with 5m resolution in `.tif` format in CRS 32630.
  #'
  #' Workflow: Calculation of the slope with the RSAGA package.
  #'           Conversion of the resulting `.sgrd` to `.tif`.
  #'           Extraction of the slope values for each record.
  #'
  #' Mod data: Slope raster in degrees with 5m resolution in `.tif` format in CRS 32630.
  #'
  dir_create("data/slope")

  env = rsaga.env()

  rsaga.slope.asp.curv(
    in.dem = "data/dem/mdt_2013_5m.tif",
    out.slope = glue(tempdir(), "/slope_5m"),
    unit.slope = "degrees", env = env
  )

  rsaga.geoprocessor(
    lib = "io_gdal", module = 2, env = env,
    param = list(
      GRIDS = glue(tempdir(), "/slope_5m.sgrd"),
      FILE = "data/slope/slope_5m.tif"
    )
  )

  slope = raster("data/slope/slope_5m.tif")

  return(slope)

}

mod_raw_data = function(data, drop_vars, response) {

  #' ## Import disease data and store as sf
  #'
  #' Raw data: Point shapefile in CRS 23030 with presense and absence observations of heterobasi and armillaria.
  #'
  #'

  data %<>%
    st_transform(32630)

  data %<>%
    st_coordinates() %>%
    cbind(data)

  #' ## Change column names to lowercase
  colnames(data) <-
    data %>%
    colnames() %>%
    tolower()

  #' ## Wiggle coordinates
  #' Some coordinates are not unique, so we have to wiggle them a little bit
  #'
  set.seed(1234)
  data$x <- data$x + rnorm(nrow(data)) / 10
  data$y <- data$y + rnorm(nrow(data)) / 10

  if (!is.null(drop_vars)) {
    # drop second response
    data %<>%
      dplyr::select(-!!drop_vars)
  }

  if (response == "diplo01") {

    # Process `year` variable to end up with only years.

    # The two missing entries we added for observation `785` and `836` are
    # based on statements from the person who collected the data.

    data %<>%
      mutate(year = fct_recode(date, "NA" = "-",
                               "NA" = ""))

    data$year %<>%
      str_replace_all("-","/") %>%
      str_extract_all('\\d+') %>%
      vapply(function(x) paste(x[3], collapse = '/'), character(1))

    data %<>%
      mutate(year = replace(year, id == 785, 2009)) %>%
      mutate(year = replace(year, id == 836, 2009))

    # We only analyze tree type "Pinus radiata" in this work.
    data %<>%
      filter(host == "Pinus radiata")

  }

  # drop points with no coordinate information
  data = data[!st_is_empty(data), ]

  return(data)
}

preprocessing_custom <- function(path, slope, soil, temperature_mean, ph, hail,
                                 precipitation_sum, elevation, pisr, lithology,
                                 study_area = data_basque, response,
                                 drop_vars = NULL, age = FALSE) {

  data_in = st_read(path, quiet = TRUE)

  data_in = mod_raw_data(data_in, drop_vars = drop_vars, response = response)

  # Predictor Preprocessing -------------------------------------------------

  # Elevation

  data_in$elevation <-
    elevation %>%
    raster::extract(data_in)

  # Slope

  data_in$slope_degrees <-
    slope %>%
    raster::extract(data_in)

  # Soil

  data_in$soil <-
    soil %>%
    raster::extract(data_in)

  # data("soil.legends")
  soil_legend <- as_tibble(GSIF::soil.legends$TAXNWRB)

  data_in %<>%
    left_join(soil_legend, by = c("soil" = "Number")) %>%
    dplyr::select(-one_of("Shortened_name", "Group", "COLOR", "soil")) %>%
    dplyr::rename(soil = Generic) %>%
    mutate(soil = as.factor(soil))

  data_in %<>%
    mutate(soil = fct_recode(soil,
                             "soils with limitations to root growth" = "Leptosols",
                             "soils with limitations to root growth" = "Cryosols",
                             "soils with limitations to root growth" = "Vertisols",
                             "soils with clay-enriched subsoil" = "Luvisols",
                             "soils with clay-enriched subsoil" = "Lixisols",
                             "soils with clay-enriched subsoil" = "Acrisols",
                             "organic soil" = "Histosols",
                             "pronounced accumulation of organic matter in the mineral topsoil" = "Kastanozems",
                             "pronounced accumulation of organic matter in the mineral topsoil" = "Chernozems",
                             "pronounced accumulation of organic matter in the mineral topsoil" = "Phaeozems",
                             "accumulation of moderately soluble salts or non-saline substances" = "Gypsisols",
                             "accumulation of moderately soluble salts or non-saline substances" = "Durisols",
                             "accumulation of moderately soluble salts or non-saline substances" = "Calcisols",
                             "soils distinguished by Fe/Al chemistry" = "Gleysols",
                             "soils distinguished by Fe/Al chemistry" = "Podzols",
                             "soils distinguished by Fe/Al chemistry" = "Plinthosols",
                             "soils distinguished by Fe/Al chemistry" = "Planosols",
                             "soils distinguished by Fe/Al chemistry" = "Nitisols",
                             "soils with little or no profile differentiation" = "Fluvisols",
                             "soils with little or no profile differentiation" = "Cambisols",
                             "soils with little or no profile differentiation" = "Arenosols",
                             "soils with little or no profile differentiation" = "Regosols",
                             "soils distinguished by Fe/Al chemistry" = "Ferralsols"
    ))

  # ph

  data_in$ph <-
    ph %>%
    raster::extract(data_in)

  # Lithology

  data_in %<>% st_join(lithology)

  data_in %<>%
    dplyr::rename(lithology = COD_LITOLO) %>%
    mutate(lithology = as.factor(lithology)) %>%
    mutate(lithology = fct_recode(lithology,
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
                                  "chemical sedimentary rock" = "18",
                                  "clastic sedimentary rock" = "19",
                                  "magmatic rock" = "20",
                                  "magmatic rock" = "22",
                                  "magmatic rock" = "23",
                                  "magmatic rock" = "24"
    ))

  # Temperature

  data_in$temp <-
    temperature_mean %>%
    raster::extract(data_in)

  # PISR

  data_in$pisr <-
    pisr %>%
    raster::extract(data_in)

  # Precipitation

  data_in$precip <-
    precipitation_sum %>%
    raster::extract(data_in)

  # Hail

  data_in$hail_probability <-
    hail %>%
    raster::extract(data_in)

  # Age

  if (isTRUE(age)) {
    data_in = age_imp_preprocessing(data = data_in)
  }

  # year
  if ("date" %in% colnames(data_in)) {
    # The two missing entries we added for observation `785` and `836` are based on statements from the person who collected the data.

    data_in %<>%
      mutate(year = fct_recode(date, "NA" = "-",
                               "NA" = ""))

    data_in$year %<>%
      str_replace_all("-","/") %>%
      str_extract_all('\\d+') %>%
      vapply(function(x) paste(x[3], collapse = '/'), character(1))

    data_in %<>%
      mutate(year = replace(year, id == 785, 2009)) %>%
      mutate(year = replace(year, id == 836, 2009)) %>%
      mutate(year = as.factor(year))

  }

  # select vars
  if (all(c("year", "age") %in% colnames(data_in))) {
    data_in %<>%
      dplyr::select(!!response, temp, precip,
                    hail_probability, ph, soil,
                    lithology, slope_degrees, pisr,
                    x, y, year, age)
  } else {
    data_in %<>%
      dplyr::select(!!response, temp, precip,
                    hail_probability, ph, soil,
                    lithology, slope_degrees, pisr,
                    x, y)
  }
  # Remove NAs

  #' # Remove samples with NAs
  #' Examine datasets for missing values. Remove sample 12 from heterobasi data set because lithology is missing
  #' and remove sample 11, 13, 14, 15, 22, 23, 25, 26, 27 and 28 from armillaria data set because elevation and/or lithology is missing.

  data_in %<>%
    na.omit() %>%
    as.data.frame() %>%
    droplevels()

  # target as factor
  # https://stackoverflow.com/questions/49942453/piping-dplyr-mutate-with-unknown-variable-name?noredirect=1&lq=1
  # # sollte eigentlich funktionieren, aber klappt manchmal iwie einfach nicht.
  # vllt NSE != drake, aber alles unklar. Kostet zu viel Zeit um es zum laufen zu kriegen
  # daher der "unschöne" if() workaround
  # data_in %<>%
  #   mutate(!!quo_name(as.name(response)) := as.factor(!!as.name(response)))

  if (response == "armillaria") {
    data_in$armillaria = as.factor(as.character(data_in$armillaria))
  } else if (response == "heterobasi") {
    data_in$heterobasi = as.factor(as.character(data_in$heterobasi))
  } else if (response == "diplo01") {
    data_in$diplo01 = as.factor(as.character(data_in$diplo01))
  } else if (response == "fus01") {
    data_in$fus01 = as.factor(as.character(data_in$fus01))
  }

  return(data_in)
}
