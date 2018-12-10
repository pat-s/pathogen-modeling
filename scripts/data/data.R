
# Clean data sets -----------------------------------------------------------

armillaria_data = preprocessing_custom(file_in("/data/patrick/raw/pathogens/armillaria_and_heterobasidion/hete-armillaria.shp"),
                                       study_area = data_basque, drop_vars = "heterobasi",
                                       response = "armillaria",
                                       soil = soil, lithology = lithology, slope = slope,
                                       temperature = temperature_mean, ph = ph,
                                       hail = hail, precipitation = precipitation_sum,
                                       pisr = pisr, elevation = elevation, age = FALSE)
heterobasidion_data = preprocessing_custom(file_in("/data/patrick/raw/pathogens/armillaria_and_heterobasidion/hete-armillaria.shp"),
                                           study_area = data_basque, drop_vars = "armillaria",
                                           response = "heterobasi",
                                           soil = soil, lithology = lithology, slope = slope,
                                           temperature = temperature_mean, ph = ph,
                                           hail = hail, precipitation = precipitation_sum,
                                           pisr = pisr, elevation = elevation,)
diplodia_data = preprocessing_custom(file_in("/data/patrick/mod/survey_data/2009-2012/points_mod.shp"),
                                     study_area = data_basque, drop_vars = "fus01",
                                     response = "diplo01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation, age = TRUE)
fusarium_data = preprocessing_custom(file_in("/data/patrick/mod/survey_data/2009-2012/points_mod.shp"),
                                     study_area = data_basque, drop_vars = "diplo01",
                                     response = "fus01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation,age = TRUE)

# Raw Data preprocessing ------------------------------------------------------------

data_basque = st_read(file_in("/data/patrick/raw/boundaries/basque-country/Study_area.shp"),
                      quiet = TRUE)

slope = slope_processing(path = "https://data.mendeley.com/datasets/kmy95t22fy/1/files/56f70601-331a-4d61-9ad0-ec58469e26f2/dem_5m.tif")

temperature_mean = temperature_preprocessing(path = file_in("/data/marc/mod/atlas_climatico"),
                                             atlas_climatico = atlas_climatico)

precipitation_sum = precipitation_preprocessing(path = file_in("/data/marc/mod/atlas_climatico"),
                                                atlas_climatico = atlas_climatico)

pisr = pisr_preprocessing(path = file_in("/data/marc/mod/atlas_climatico"),
                          atlas_climatico = atlas_climatico)

lithology = lithology_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/draft/files/f200186f-ff5e-47a3-a43f-a47e93708d0e/lithology.zip?dl=1")

ph = ph_preprocessing(path = file_in("/data/patrick/raw/ph_europe/ph_cacl2"),
                      study_area = data_basque)

soil = soil_preprocessing(path = file_in("/data/patrick/raw/soil/ISRIC_world_soil_information/TAXNWRB_250m_ll.tif"),
                          study_area = data_basque)

elevation = elevation_preprocessing(path = file_in("/data/patrick/raw/DEM/MDT_LIDAR_2013_5m_ETRS89.zip"))

atlas_climatico = atlas_climatico_preprocessing(path = file_in("/data/patrick/raw/atlas-climatico/cartografia"),
                                                study_area = data_basque)

hail = hail_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/1/files/08fbf8e3-b74a-4a0a-8c02-108fbecd7623/Prob_GAM_square_area.tif")


# Prediction data ---------------------------------------------------------

pred_data = create_prediction_data(data_temperature, data_precipitation, data_pisr,
                                   data_dem, data_soil, data_lithology, data_hail,
                                   data_ph, data_basque)
