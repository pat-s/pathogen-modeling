needs(mlr)

bmr_svm = readRDS("/data/patrick/mod/pathogen-prediction/06-benchmark/svm-all-pathogens.rda")

bmr_ranger_armillaria = readRDS("/data/patrick/mod/pathogen-prediction/06-benchmark/ranger-armillaria.rda")
bmr_ranger_diplodia = readRDS("/data/patrick/mod/pathogen-prediction/06-benchmark/ranger-diplodia.rda")
bmr_ranger_heterobasidion = readRDS("/data/patrick/mod/pathogen-prediction/06-benchmark/ranger-heterobasidion.rda")
bmr_ranger_fusarium = readRDS("/data/patrick/mod/pathogen-prediction/06-benchmark/ranger-fusarium.rda")

bmr_all = mergeBenchmarkResults(list(bmr_svm, bmr_ranger_armillaria, bmr_ranger_diplodia,
                                     bmr_ranger_heterobasidion, bmr_ranger_fusarium))
