source("code/drake.R")

armillaria_task = readd("armillaria_task_dummy")
diplodia_task = readd("diplodia_task_dummy_prediction")
lrn_glm = readd("lrn_glm")
lrn_svm = readd("lrn_svm")
pred_data = readd("pred_data")
temperature = readd("temperature_mean")

resampling = readd("spcv_outer_fiveF_hundredR")
param_set = readd("ps_svm")
tune_ctrl = readd("tune_ctrl_svm")

# test = prediction_custom(armillaria_task, learner = lrn_glm,
#                          param_set = NULL, tune_ctrl =  NULL,
#                          resampling = NULL, prediction_data =  pred_data,
#                          pred_grid = temperature)


test = prediction_custom(armillaria_task, learner = lrn_svm,
                         param_set = param_set, tune_ctrl =  tune_ctrl,
                         resampling = resampling, prediction_data =  pred_data,
                         prediction_grid = temperature)


temperature_mean = readd("temperature_mean")
precipitation_sum = readd("precipitation_sum")
pisr = readd("pisr")
elevation = readd("elevation")
soil = readd("soil")
slope = readd("slope")
lithology = readd("lithology")
hail = readd("hail")
ph  = readd("ph")
data_basque = readd("data_basque")
debug(create_prediction_data)

pred_data = create_prediction_data(temperature = temperature_mean,
                                   precipitation = precipitation_sum,
                                   pisr = pisr,
                                   elevation = elevation,
                                   soil = soil,
                                   slope = slope,
                                   lithology = lithology,
                                   hail = hail,
                                   ph = ph, study_area = data_basque)
