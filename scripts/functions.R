soil_preprocessing = function(path = "/data/patrick/raw/soil/ISRIC_world_soil_information/TAXNWRB_250m_ll.tif",
                              study_area = data_basque,
                              data) {

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

  soil_ras = raster(path) %>%
    crop(study_area_4326) %>%
    mask(study_area_4326) %>%
    projectRaster(crs = crs_32630, method = "ngb")

  data$soil <-
    soil_ras %>%
    raster::extract(data)

  data("soil.legends")
  soil_legend <- as_tibble(soil.legends$TAXNWRB)

  data %<>%
    left_join(soil_legend, by = c("soil" = "Number")) %>%
    dplyr::select(-one_of("Shortened_name", "Group", "COLOR", "soil")) %>%
    dplyr::rename(soil = Generic) %>%
    mutate(soil = as.factor(soil))

  data %<>%
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
  return(data)
}


slope_processing = function(path = "/data/marc/mod/dem/dem_5m.tif", data) {

  #' ## Slope
  #'
  #' Raw data: Reprojected DEM with 5m resolution in `.tif` format in CRS 32630.
  #'
  #' Workflow: Calculation of the slope with the RSAGA package.
  #'           Conversion of the resulting `.sgrd` to `.tif`.
  #'           Extraction of the slope values for each record.
  #'
  #' Mod data: Slope raster in degrees with 5m resolution in `.tif` format in CRS 32630.

  rsaga.slope.asp.curv(
    in.dem = path,
    out.slope = "/data/marc/mod/tmp/slope_5m",
    unit.slope = "degrees", env = env
  )

  rsaga.geoprocessor(
    lib = "io_gdal", module = 2, env = env,
    param = list(
      GRIDS = "/data/marc/mod/tmp/slope_5m.sgrd",
      FILE = "/data/marc/mod/slope/slope_5m.tif"
    )
  )

  slope = raster("/data/marc/mod/slope/slope_5m.tif")

  data$slope <-
    slope %>%
    raster::extract(data)

  return(data)

}

preprocessing_custom <- function(data_in,
                                 study_area = data_basque,
                                 drop_vars = NULL, age = FALSE) {

  #' # Default variables
  #'
  #' ## Coordinate Reference System
  #' We set a default Coordinate Reference System (CRS), which is used for all raster files.

  crs_32630 <- CRS("+init=epsg:32630")

  # Response preprocessing-------------------------------------------------------------------------

  #'
  #' ## Import disease data and store as tibble
  #'
  #' Raw data: Point shapefile in CRS 23030 with presense and absence observations of heterobasi and armillaria.
  #'
  #'
  data_in %<>%
    st_read(quiet = TRUE) %>%
    st_transform(32630)

  #' ## Store coordinates in tibble
  data_in %<>% dplyr::select(-one_of("X", "Y"))

  data_in %<>%
    st_coordinates() %>%
    cbind(data_in)

  #' ## Wiggle coordinates
  #' Some coordinates are not unique, so we have to wiggle them a little bit
  #'
  set.seed(1234)
  data_in$X <- data_in$X + rnorm(nrow(data_in)) / 10
  data_in$Y <- data_in$Y + rnorm(nrow(data_in)) / 10

  #' ## Change column names to lowercase
  colnames(data_in) <-
    data_in %>%
    colnames() %>%
    tolower()

  if (!is.null(drop_vars)) {
    # drop second response
    data_in %<>%
      dplyr::select(-!!drop_vars)
  }

  # Predictor Preprocessing -------------------------------------------------

  #' ## Set global variables
  #' Initialize RSAGA for geoprocessing.

  env <- rsaga.env()

  # Elevation ---------------------------------------------------------------

  #' Raw data: Zipped 5m lidar DEM in CRS 3042 in `.tif` format.
  #'
  #' Workflow: Reprojection on CRS 32630. Extraction of the elevation values for each observation.
  #'
  #' Mod data: DEM with 5m resolution in `.tif` format in CRS 32630.

  unzip(
    "/data/patrick/raw/DEM/MDT_LIDAR_2013_5m_ETRS89.zip",
    exdir = "/data/marc/mod/tmp"
  )

  raster("/data/marc/mod/tmp/mdt_2013_5m.tif") %>%
    projectRaster(crs = crs_32630, method = "bilinear") %>%
    writeRaster(filename = "/data/marc/mod/dem/dem_5m.tif", overwrite = TRUE)

  data_in$elevation <-
    raster("/data/marc/mod/dem/dem_5m.tif") %>%
    raster::extract(data_in)

  # Slope

  slope = slope_processing()

  data_in$slope <-
    slope %>%
    raster::extract(data_in)

  # Soil

  data_in = soil_preprocessing(data = data_in)

  # ph ----------------------------------------------------------------------

  #' Raw data: pH raster of Europe with a resolution of 5000m in CRS 3035 in `adf` format.
  #'
  #' Workflow: Load `adf` raster file to workspace.
  #'           Reproject study area to CRS 3035.
  #'           Crop pH raster with study area and reproject to CRS 23030.
  #'
  #' Mod data: pH raster with a resolution of 5000 m in `.tif` format in CRS 23030.

  ph_raster <-
    new("GDALReadOnlyDataset", "/data/patrick/raw/ph_europe/ph_cacl2") %>%
    asSGDF_GROD() %>%
    raster()

  crs(ph_raster) <- CRS("+init=epsg:3035")

  study_area_3035 <-
    study_area %>%
    st_transform(3035) %>%
    as("Spatial")

  ph_raster %>%
    crop(study_area_3035) %>%
    mask(study_area_3035) %>%
    projectRaster(crs = crs_32630, method = "bilinear") %>%
    writeRaster("/data/marc/mod/pH/ph.tif", overwrite = TRUE)

  data_in$ph <-
    raster("/data/marc/mod/ph/ph.tif") %>%
    raster::extract(data_in)

  # Lithology ---------------------------------------------------------------

  #' Raw data: Polygon shapefile with lithology units in CRS 25830.
  #'
  #' Workflow: Read shapefile and reproject to CRS 32630.
  #'           Extract column with lithology unit id.
  #'           Make lithology sf object valid and extract at each observation the lithology unit id.
  #'           Aggregate lithology units to common lithology classes.
  #'
  #' Output: Aggregated lithology units.

  st_read("/data/patrick/raw/lithology/CT_LITOLOGICO_25000_ETRS89.shp", quiet = TRUE) %>%
    st_set_crs(25830) %>%
    st_transform(32630) %>%
    dplyr::select(COD_LITOLO) -> lithology_sp

  lithology_sp %<>%
    st_make_valid() %>%
    st_cast("POLYGON")

  data_in %<>% st_join(lithology_sp)

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

  # Temperature -------------------------------------------------------------

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

  c("^mt.*_av.zip$") %>% # , "^rad.*_av.zip$", "^pl.*_av.zip$"
    map(function(x) list.files(
      path = "/data/patrick/raw/atlas-climatico/cartografia",
      pattern = x,
      full.names = TRUE
    )) %>%
    unlist() %>%
    walk(unzip, exdir = "/data/marc/mod/atlas_climatico")

  list.files("/data/marc/mod/atlas_climatico",
             pattern = "*.(gif|htm)$",
             full.names = TRUE
  ) %>%
    walk(file.remove)

  study_area_23030 <-
    study_area %>%
    st_transform(23030) %>%
    as("Spatial")

  txt_files <- list.files("/data/marc/mod/atlas_climatico",
                          pattern = ".txt$",
                          full.names = TRUE
  )

  file_names <- map(txt_files, function(x) sub("txt", x, replacement = "tif")) %>%
    unlist()

  map(txt_files, raster, crs = CRS("+init=epsg:23030")) %>%
    map(crop, y = study_area_23030) %>%
    map(mask, mask = study_area_23030) %>%
    map(projectRaster, crs = crs_32630) %>%
    walk2(file_names, writeRaster, overwrite = TRUE)

  walk(txt_files, file.remove)

  #' ## Temperature
  #'
  #' Raw data: Temperature rasters for month march to september in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Calculate mean temperature of month march to september and write raster to disk.
  #'           Extract mean summer temperature at each observation.
  #'
  #' Modified data: Mean summer temperature raster in `.tif` format in CRS 32630.

  list.files("/data/marc/mod/atlas_climatico",
             "termo.*(marzo|abril|mayo|junio|julio|agosto|septiembre)_av.tif$",
             full.names = TRUE
  ) %>%
    stack() %>%
    calc(function(x) {
      mean(x) / 10
    }) %>%
    writeRaster("/data/marc/mod/atlas_climatico/mean_temperature.tif",
                overwrite = TRUE
    )

  data_in$temperature <-
    raster("/data/marc/mod/atlas_climatico/mean_temperature.tif") %>%
    raster::extract(data_in)

  # PISR --------------------------------------------------------------------

  #' ## PISR
  #'
  #' Raw data: PISR rasters for month july to september in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Add pisr of july to september and convert to the relative fraction of its mean (mean = 8065.952 kW/m^2).
  #'           Write raster to disk and extract pisr at each observation.
  #'
  #' Modified data: PISR raster in `.tif` format in CRS 32630.

  psir_sum_raster <-
    list.files("/data/marc/mod/atlas_climatico",
               "radiacion.*(julio|agosto|septiembre)_av.tif$",
               full.names = TRUE
    ) %>%
    stack() %>%
    sum()

  psir_sum_raster %>%
    calc(function(x) {
      x / cellStats(psir_sum_raster, stat = mean, na.rm = TRUE) - 1
    }) %>%
    writeRaster("/data/marc/mod/atlas_climatico/pisr.tif",
                overwrite = TRUE
    )

  data_in$pisr <-
    raster("/data/marc/mod/atlas_climatico/pisr.tif") %>%
    raster::extract(data_in)

  # Precipitation -----------------------------------------------------------

  #' ## Precipitation
  #'
  #' Raw data: Precipitation rasters for month july and august in `.tif`´format in CRS 32630.
  #'
  #' Workflow: Get files by pattern and stack files.
  #'           Add precipitation of month july and august and write raster to disk.
  #'           Extract precipitation at each observation.
  #'
  #' Modified data: Total july and august precipitation raster in `.tif` format in CRS 32630.

  list.files("/data/marc/mod/atlas_climatico",
             "pluvio.*(julio|agosto)_av.tif$",
             full.names = TRUE
  ) %>%
    stack() %>%
    calc(function(x) {
      sum(x) / 10
    }) %>%
    writeRaster("/data/marc/mod/atlas_climatico/sum_precipitation.tif",
                overwrite = TRUE
    )

  data_in$precipitation <-
    raster("/data/marc/mod/atlas_climatico/sum_precipitation.tif") %>%
    raster::extract(data_in)

  # Hail --------------------------------------------------------------------

  #' ## Hail
  #'
  #' Raw data: Hail raster with a resolution of 200 m in `.tif` format in CRS 32630.
  #'
  #' Workflow: Extract hail probability at each observation.

  data_in$hail_probability <-
    raster("/data/patrick/raw/hail/Prob_GAM_square_area.tif") %>%
    raster::extract(data_in)


  # Age ---------------------------------------------------------------------

  if (isTRUE(age)) {
    data_in %<>%
      filter(!is.na(age))

    # We trimmed age > 40 to reduce influence of outliers.

    data_in %<>%
      mutate(age = as.numeric(levels(age)[age])) %>%
      mutate(age = replace(age, age > 40, 40))

    res <- test_age_imputation(data_in$x, data_in$y, data_in$age)
    summary(res)

    # qplot(res$obs, res$imput) + geom_abline() + hrbrthemes::theme_ipsum_rc()
    # cor(res$obs, res$imput, use = "complete")

    data_in$age <- age_imputation(data_in$x, data_in$y,
                                  data_in$age, print = TRUE)
  }

  # Remove NAs --------------------------------------------------------------

  #' # Remove samples with NAs
  #' Examine datasets for missing values. Remove sample 12 from heterobasi data set because lithology is missing
  #' and remove sample 11, 13, 14, 15, 22, 23, 25, 26, 27 and 28 from armillaria data set because elevation and/or lithology is missing.

  data_in %>% filter_all(any_vars(is.na(.))) %>%
    na.omit()

  # Prepare for analysis ----------------------------------------------------

  browser()


  #' # Prepare data for analysis
  data_in %<>%
    as.data.frame() %>%
    dplyr::select(
      elevation,
      slope,
      soil,
      ph,
      lithology,
      temperature,
      pisr,
      precipitation,
      hail_probability,
      x,
      y,
      heterobasi
    ) %>%
    mutate(heterobasi = as.factor(heterobasi)) %>%
    droplevels()

  #' Rename to match variables names of paper

  data_in %<>%
    rename(
      slope_degrees = slope,
      temp = temperature,
      p_sum = precipitation,
      r_sum = pisr,
      hail_prob = hail_probability,
    )

  return(data_in)
}


benchmark_custom <- function(task, learner, resampling) {
  parallelStart(
    mode = "multicore", cpus = 30, level = "mlr.resample",
    mc.set.seed = TRUE
  )
  set.seed(12345, kind = "L'Ecuyer-CMRG")

  bmr <- benchmark(learner, task,
                   models = FALSE,
                   resampling = resampling,
                   show.info = TRUE, measures = list(brier, timetrain)
  )

  parallelStop()
  return(bmr)
}


task_custom <- function(data, name, target, dummy_features, dummy.factors = FALSE) {

  coordinates <- data[, c("x", "y")]

  data %<>%
    st_as_sf(coords = c("x", "y")) %>%
    st_set_geometry(NULL)

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

  if (isTRUE(remove.vars)) {
    df <- task$env$data %>%
      select(-year, -age)
  }

  task <- makeClassifTask(
    id = name, data = df,
    target = target, positive = "1",
    coordinates = task$coordinates
  )
  return(task)
}

wrapper_custom <- function(lrn, param_set, resampling) {

  ctrl <- makeMBOControl(propose.points = 1L) %>%
    setMBOControlTermination(iters = 20L) %>%
    setMBOControlInfill(crit = crit.ei)
  tune.ctrl <- makeTuneControlMBO(
    mbo.control = ctrl,
    mbo.design = generateDesign(n = 30, par.set = param_set)
  )

  wrapper <- makeTuneWrapper(
    lrn,
    resampling = resampling, par.set = param_set,
    control = tune.ctrl, show.info = FALSE,
    measures = list(brier)
  )
  return(wrapper)
}

tune_ctrl_mbo_30n_20it = function(param_set) {
  makeTuneControlMBO(
    mbo.control = makeMBOControl(propose.points = 1L) %>%
      setMBOControlTermination(iters = 20L) %>%
      setMBOControlInfill(crit = crit.ei),
    mbo.design = generateDesign(n = 30, par.set = param_set)
  )
}

create_prediction_data <- function(temperature, precipitation, pisr, dem, soil, lithology, hail, ph, study_area) {

  # Its a square around the Basque Country.
  # This prevents error for the subsequent raster `extract` calls that may result
  # in NAs if the rasters does not exceed the dimensions of the extracting area.

  study_area1 <- study_area %>%
    st_transform(32630) %>%
    as("Spatial")

  #' ## Temperature (Mar - Sep)
  #'
  #' We load all images for the months March - September.
  #' These are clipped in a rectangular box around the Basque Country.
  #'
  #'
  # load only nov-april
  #'
  #'
  #' We load in each raster and set the projection.
  #' Next, we mask the values by the study area extent and rescale the temperature values to have proper degree Celsius values.
  #'
  #' Then a stack is created from all the rasters and the mean is computed across all layers.
  #'
  #'
  # set up list with monthly tifs and rescale values
  temperature %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area1) %>%
      mask(study_area1) %>%
      divide_by(10)
    return(tmp)
  })

  rasters_temp_stack <- stack(temperature)
  rasters_temp_mean <- stackApply(rasters_temp_stack,
                                  indices = c(rep(1, 7)), fun = mean
  )
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
  df_basque <- as(rasters_temp_mean, "SpatialPixelsDataFrame")
  df_basque = st_as_sf(df_basque)
  # df_basque$index_1 <- NULL
  #'
  #'
  #' And extract the information to the new data set.
  #'
  #'
  df_basque$temp <- extract(rasters_temp_mean, df_basque)
  #'
  #'

  # Precipitation -----------------------------------------------------------

  #'
  #' ## Precipitation (Mar - Sep)
  #'
  #' We load all images for the months July - September.
  #' These are clipped in a rectangular box around the Basque Country.
  #'
  #'
  # load only nov-april
  #'
  #'
  #' We load in each raster and set the projection.
  #' Next, we mask the values by the study area extent and rescale the precerature values to have mm/m² values.
  #'
  #' Then a stack is created from all the rasters and the mean is computed across all layers.
  #'
  #'
  # set up list with monthly tifs and rescale values
  precipitation %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area1) %>%
      mask(study_area1) %>%
      divide_by(10)
    return(tmp)
  })

  rasters_prec_stack <- stack(precipitation)
  rasters_prec_sum <- stackApply(rasters_prec_stack,
                                 indices = c(rep(1, 3)), fun = sum
  )

  df_basque$p_sum <- extract(rasters_prec_sum, df_basque)

  # PISR --------------------------------------------------------------------

  #' ## PISR (Mar - Sep)
  #' We load all images for the months July - September.
  #' These are clipped in a rectangular box around the Basque Country.
  #' We load in each raster and set the projection.
  #' Next, we mask the values by the study area extent and rescale the sRaderature values to have mm/m² values.
  #'
  #' Then a stack is created from all the rasters and the mean is computed across all layers.

  # set up list with monthly tifs and rescale values
  pisr %<>% map(~ {
    tmp <- raster(.x, layer = 1)
    # apply CRS
    crs(tmp) <- "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs"
    # subset and rescale
    tmp %<>%
      crop(study_area1) %>%
      mask(study_area1)
    # divide_by(mean(.)) - 1
    return(tmp)
  })

  rasters_r_sum_stack <- stack(pisr)
  rasters_r_sum <- stackApply(rasters_r_sum_stack,
                              indices = c(rep(1, 3)), fun = sum
  )

  # trim outliers; we have around 50000 values with no information that affect the mean
  # these are coming from the sea area where no information is available
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {
    replace(x, x < 2000, NA)
  })

  # rescale to fraction its mean now and remove NA values when calc the mean
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {
    x / mean(x, na.rm = TRUE) - 1
  })

  # again trim negative outliers
  rasters_r_sum <- calc(rasters_r_sum, fun = function(x) {
    replace(x, x < -0.1, -0.1)
  })

  df_basque$r_sum <- extract(rasters_r_sum, df_basque)


  # Slope -------------------------------------------------------------------

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

  env <- rsaga.env(modules = "/usr/lib/x86_64-linux-gnu/saga/")
  rsaga.slope.asp.curv(
    in.dem = dem,
    out.slope = "/data/patrick/mod/DEM/slope/slope_5m",
    unit.slope = "degrees",
    env = env
  )

  rsaga.geoprocessor(
    lib = "io_gdal", module = 2, env = env,
    param = list(
      GRIDS = "/data/patrick/mod/DEM/slope/slope_5m.sgrd",
      FILE = "/data/patrick/mod/DEM/slope/slope_5m.tif"
    )
  )

  raster(dem) %>%
    extract(df_basque) -> df_basque$slope_degrees

  # Lithology ---------------------------------------------------------------

  #' Read, reproject and select desired column of lithology ressource.

  lithology %<>%
    st_set_crs("+proj=utm +zone=30 +ellps=GRS80 +units=m +no_defs") %>%
    st_transform(32630) %>%
    dplyr::select(COD_LITOLO)

  #' Make it a valid polygon.
  #' See also `?st_is_valid()`.

  litho_valid <- st_make_valid(lithology) %>%
    st_cast("POLYGON")

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


  # Soil --------------------------------------------------------------------

  #' ## Soil

  study_area2 <- study_area %>%
    st_transform("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") %>%
    as("Spatial")

  soil %<>%
    crop(study_area2) %>%
    mask(study_area2) %>%
    projectRaster(crs = "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")

  df_basque$soil <- extract(soil, df_basque)
  # "Acrisols" = "0" should be NA actually, but the 2 obs will be removed anyways
  # "Albeluvisol" = "Retisols"
  # as they are located in the water
  df_basque %<>%
    st_as_sf() %>%
    mutate(soil = as.factor(as.integer(soil))) %>%
    mutate(soil = fct_recode(soil,
                             "Acrisols" = "0", "Acrisols" = "1",
                             "Acrisols" = "2", "Acrisols" = "3",
                             "Acrisols" = "4", "Acrisols" = "5",
                             "Acrisols" = "6",
                             "Retisols" = "7", "Retisols" = "8",
                             "Alisols" = "10", "Alisols" = "11",
                             "Andosols" = "12", "Andosols" = "13",
                             "Andosols" = "14", "Arenosols" = "15",
                             "Arenosols" = "16", "Arenosols" = "17",
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

  # Extract values to object `df_basque`.

  hail %>%
    extract(df_basque) -> df_basque$hail_prob

  # Elevation ---------------------------------------------------------------

  raster(dem) %>%
    extract(df_basque) -> df_basque$elevation

  # ph ----------------------------------------------------------------------

  #' Read in the study area polygon and crop the raster image to it.
  #' For speed reasons, we first project the `pH` raster to the CRS of `study_area` and coerce it to the CRS of `df_basque` after the `crop()` call.

  study_area3 <- study_area %>%
    st_transform(3035) %>%
    as("Spatial")

  crs(ph) <- "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

  ph %<>%
    crop(study_area3) %>%
    mask(study_area3) %>%
    projectRaster(crs = "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")

  #' Finally, extract values to `df_basque`.
  extract(ph, df_basque) -> df_basque$ph

  #' ## Remove NAs
  df_basque %<>% na.omit()

  # Predict -----------------------------------------------------------------

  #' Make prediction data.frame

  df_basque_pred <- df_basque
  df_basque_pred <- st_set_geometry(df_basque_pred, NULL)
  df_basque_pred$x <- NULL
  df_basque_pred$y <- NULL
  df_basque_pred$index_1 <- NULL

  df_basque_pred <- createDummyFeatures(
    df_basque_pred,
    # target = "heterobasidion",
    cols = c(
      "lithology",
      "soil"
    )
  )

  return(df_basque_pred)
}

prediction_custom = function(task, learner, param_set, tune_ctrl, resampling, prediction_data) {

  configureMlr(on.learner.error = "warn", on.error.dump = TRUE)

  browser()
  # Tune all models ---------------------------------------------------------

  if (learner != rlang::syms("lrn_glm")) {
    parallelStart(
      mode = "multicore", level = "mlrMBO.feval", cpus = 30,
      mc.set.seed = TRUE
    )
    set.seed(12345)
    models_tuned <- tuneParams(learner,
                               task = task, resampling = resampling,
                               par.set = param_set, control = tune_ctrl,
                               show.info = TRUE, measure = list(brier)
    )
    parallelStop()
  }

  # Train all models ---------------------------------------------------------

  learner_tuned %<>% map2(~ setHyperPars(.x,
                                         par.vals = models_tuned[[.y]]$x
  ))

  # append glm learner
  learner_tuned = list(learned_tuned, learner[[5]])


  fit_armillaria <- map(learner_tuned, ~ train(.x, armillaria_task))

  # Create predictions ---------------------------------------------------


  browser()

  if (fit_armillaria$learner.model == "xgboost") {
    fit_armillaria <- fit_armillaria[.x$learner.model$feature_names]
  }
  predictions <- predict(.x, newdata = pred_data)

  # Create prediction maps ---------------------------------------------------

  # this object contains the coordinates that we need to attach to the predictions
  df_basque <- readRDS("/data/patrick/mod/prediction/temporary/df_basque.rda")

  walk2(predictions, list("ranger", "xgboost", "svm", "binomial", "kknn"), ~{

    #' # Visualize all predictors

    # mapview(df_basque)

    # pred_data$x = as.integer(st_coordinates(df_basque)[, 1])
    # pred_data$y = as.integer(st_coordinates(df_basque)[, 2])

    coords <- as.data.frame(st_coordinates(df_basque))
    colnames(coords) <- c("x", "y")
    # we need to make sure that the rownames of `coords` mirror the ones from `df_basque `
    rownames(coords) <- rownames(df_basque)

    # we join the predictions and coordinates based on the rownames of both objects
    pred_xy_xg <- left_join(rownames_to_column(.x$data),
                            rownames_to_column(coords),
                            by = "rowname"
    )

    pred_xy_xg <- SpatialPixelsDataFrame(
      points = pred_xy_xg[, c("x", "y")],
      data = as.data.frame(pred_xy_xg[, "prob.1"]),
      proj4string = CRS("+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")
    )
    names(pred_xy_xg) <- "probability"

    # mapview(pred_xy_xg, legend = TRUE, zcol = "probability",
    #         at = c(0, 0.25, 0.5, 0.75, 1), layer.name = "probability")

    # write out raster
    raster_xg <- raster(pred_xy_xg)
    raster_xg <- projectRaster(raster_xg, crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ")

    writeRaster(raster_xg, glue("/data/patrick/mod/pathogen-prediction/07-prediction/tiffs/armillaria-{.y}.tif"),
                overwrite = TRUE
    )

    study_area <- st_read("/data/patrick/raw/boundaries/basque-country/Study_area.shp",
                          quiet = TRUE
    ) %>%
      st_transform(32630) %>%
      as("Spatial")

    study_area %<>%
      st_as_sf() %>%
      st_transform(4326) %>%
      as("Spatial")

    map_xgboost <- levelplot(
      raster_xg[["probability"]],
      main = substitute(paste(
        "Probability of tree infections by ",
        italic("armillaria mellea")
      )),
      margin = FALSE,
      between = list(x = 0.0, y = 0.0),
      at = seq(0, 1, length.out = 100),
      colorkey = list(
        width = 0.75,
        space = "right",
        labels = list(
          at = c(0, 0.25, 0.5, 0.75, 1),
          font = 4
        ),
        axis.line = list(col = "black")
      ),
      par.strip.text = list(col = "white", cex = 1.2),
      col.regions = viridis
    )

    png(glue("/data/patrick/mod/pathogen-prediction/08-imgs/single/prediction_{.y}_armillaria.png"))
    plot(map_xgboost)
    dev.off()
  })

}

