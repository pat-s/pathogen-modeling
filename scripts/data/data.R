
# Clean data sets -----------------------------------------------------------

armillaria_data = preprocessing_custom("https://data.mendeley.com/datasets/kmy95t22fy/2/files/41deb463-d378-46da-a25e-26044ce253fe/heterobasidion-armillaria.gpkg?dl=1https://data.mendeley.com/datasets/kmy95t22fy/2/files/41deb463-d378-46da-a25e-26044ce253fe/heterobasidion-armillaria.gpkg",
                                       study_area = data_basque, drop_vars = "heterobasi",
                                       response = "armillaria",
                                       soil = soil, lithology = lithology, slope = slope,
                                       temperature = temperature_mean, ph = ph,
                                       hail = hail, precipitation = precipitation_sum,
                                       pisr = pisr, elevation = elevation, age = FALSE)
heterobasidion_data = preprocessing_custom("https://data.mendeley.com/datasets/kmy95t22fy/2/files/41deb463-d378-46da-a25e-26044ce253fe/heterobasidion-armillaria.gpkg",
                                           study_area = data_basque, drop_vars = "armillaria",
                                           response = "heterobasi",
                                           soil = soil, lithology = lithology, slope = slope,
                                           temperature = temperature_mean, ph = ph,
                                           hail = hail, precipitation = precipitation_sum,
                                           pisr = pisr, elevation = elevation,)
diplodia_data = preprocessing_custom("https://data.mendeley.com/datasets/kmy95t22fy/2/files/d928133b-e199-4ed1-af8b-ac2f5c1ed309/diplodia-fusarium.gpkg",
                                     study_area = data_basque, drop_vars = "fus01",
                                     response = "diplo01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation, age = TRUE)
fusarium_data = preprocessing_custom("https://data.mendeley.com/datasets/kmy95t22fy/2/files/d928133b-e199-4ed1-af8b-ac2f5c1ed309/diplodia-fusarium.gpkg",
                                     study_area = data_basque, drop_vars = "diplo01",
                                     response = "fus01",
                                     soil = soil, lithology = lithology, slope = slope,
                                     temperature = temperature_mean, ph = ph,
                                     hail = hail, precipitation = precipitation_sum,
                                     pisr = pisr, elevation = elevation,age = TRUE)

# Raw Data preprocessing ------------------------------------------------------------

data_basque = st_read("https://data.mendeley.com/datasets/kmy95t22fy/2/files/13fcf51e-c528-4af4-9f71-f9feaa6c4b0c/study-area.gpkg",
                      quiet = TRUE)

slope = slope_processing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/6d827708-dd7b-4929-93c0-3c6f6ecd8397/dem.zip")

temperature_mean = temperature_preprocessing(atlas_climatico = atlas_climatico)

precipitation_sum = precipitation_preprocessing(atlas_climatico = atlas_climatico)

pisr = pisr_preprocessing(atlas_climatico = atlas_climatico)

lithology = lithology_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/073658ff-936c-4f12-939b-7d3e3f7eaa19/lithology.zip")

ph = ph_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/2f867057-bcc4-452e-95ff-279dd5127043/ph.zip",
                      study_area = data_basque)

soil = soil_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/44f00c51-5da5-4d54-b5a7-f2334da62ce2/soil.tif",
                          study_area = data_basque)

elevation = elevation_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/6d827708-dd7b-4929-93c0-3c6f6ecd8397/dem.zip")

atlas_climatico = atlas_climatico_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/c8a78642-091b-4d37-a20a-12bca03d8338/atlas-climatico.zip",
                                                study_area = data_basque)

hail = hail_preprocessing(path = "https://data.mendeley.com/datasets/kmy95t22fy/2/files/08fbf8e3-b74a-4a0a-8c02-108fbecd7623/hail-probability.tif")


# Prediction data ---------------------------------------------------------

pred_data = create_prediction_data(temperature = temperature_mean,
                                   precipitation = precipitation_sum,
                                   pisr = pisr,
                                   elevation = elevation,
                                   soil = soil,
                                   slope = slope,
                                   lithology = lithology,
                                   hail = hail,
                                   ph = ph, study_area = data_basque)
