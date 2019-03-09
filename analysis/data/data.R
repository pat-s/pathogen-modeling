
# Clean data sets -----------------------------------------------------------


armillaria_data = preprocessing_custom("https://zenodo.org/record/2582970/files/heterobasidion-armillaria.gpkg",
                                       study_area = data_basque, drop_vars = "heterobasi",
                                       response = "armillaria",
                                       soil = soil, lithology = lithology, slope = slope,
                                       temperature = temperature_mean, ph = ph,
                                       hail = hail_raw, precipitation = precipitation_sum,
                                       pisr = pisr, elevation = elevation, age = FALSE)
heterobasidion_data = preprocessing_custom("https://zenodo.org/record/2582970/files/heterobasidion-armillaria.gpkg",
                                           study_area = data_basque, drop_vars = "armillaria",
                                           response = "heterobasi",
                                           soil = soil, lithology = lithology, slope = slope,
                                           temperature = temperature_mean, ph = ph,
                                           hail = hail_raw, precipitation = precipitation_sum,
                                           pisr = pisr, elevation = elevation, age = FALSE)
diplodia_data = preprocessing_custom("https://zenodo.org/record/2582970/files/diplodia-fusarium.gpkg",
                                     study_area = data_basque, drop_vars = "fus01",
                                     response = "diplo01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail_raw, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation, age = TRUE)
test_data =  preprocessing_custom_v2("data-clean.gpkg",
                                     study_area = data_basque,
                                     response = "diplo01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail_raw, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation, age = TRUE)


fusarium_data = preprocessing_custom("https://zenodo.org/record/2582970/files/diplodia-fusarium.gpkg",
                                     study_area = data_basque, drop_vars = "diplo01",
                                     response = "fus01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail_raw, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation, age = TRUE)

# Raw Data preprocessing ------------------------------------------------------------

data_basque = st_read("https://zenodo.org/record/2582970/files/study-area.gpkg",
                      quiet = TRUE)

dem_raw = dem_download("https://zenodo.org/record/2582970/files/dem.zip")
slope = slope_processing(path = dem_raw)
elevation = elevation_preprocessing(path = dem_raw)

temperature_mean = temperature_preprocessing(atlas_climatico = atlas_climatico)
precipitation_sum = precipitation_preprocessing(atlas_climatico = atlas_climatico)
pisr = pisr_preprocessing(atlas_climatico = atlas_climatico)

lithology_raw = lithology_download(path = "https://zenodo.org/record/2582970/files/lithology.zip")
lithology = lithology_preprocessing(lithology_raw)

ph_raw = ph_download("https://zenodo.org/record/2582970/files/ph.zip")
ph = ph_preprocessing(path = ph_raw,
                      study_area = data_basque)

soil_raw = soil_download("https://zenodo.org/record/2582970/files/soil.tif")
soil = soil_preprocessing(path = soil_raw,
                          study_area = data_basque)

atlas_climatico_raw = atlas_climatico_download("https://zenodo.org/record/2582970/files/atlas-climatico.zip")
atlas_climatico = atlas_climatico_preprocessing(path = atlas_climatico_raw,
                                                study_area = data_basque)

hail_raw = hail_download(path = "https://zenodo.org/record/2582970/files/hail-probability.tif")

# Prediction data ---------------------------------------------------------

pred_data = create_prediction_data(temperature = temperature_mean,
                                   precipitation = precipitation_sum,
                                   pisr = pisr,
                                   elevation = elevation,
                                   soil = soil,
                                   slope = slope,
                                   lithology = lithology,
                                   hail = hail_raw,
                                   ph = ph)
