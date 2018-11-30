# MBO ranger -----------------------------------------------------------

library(mlrMBO)

ps_ranger = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-ranger.rda")

ctrl <- makeMBOControl(propose.points = 1L)
ctrl <- setMBOControlTermination(ctrl, iters = 20L)
ctrl <- setMBOControlInfill(ctrl, crit = crit.ei)
tune.ctrl <- makeTuneControlMBO(
  mbo.control = ctrl,
  mbo.design = generateDesign(n = 30, par.set = ps_ranger)
)

saveRDS(tune.ctrl, "/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-ranger.rda")

# MBO xgboost -----------------------------------------------------------

ps_xgboost = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-xgboost.rda")

ctrl <- makeMBOControl(propose.points = 1L)
ctrl <- setMBOControlTermination(ctrl, iters = 20L)
ctrl <- setMBOControlInfill(ctrl, crit = crit.ei)
tune.ctrl <- makeTuneControlMBO(
  mbo.control = ctrl,
  mbo.design = generateDesign(n = 30, par.set = ps_xgboost)
)

saveRDS(tune.ctrl, "/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-xgboost.rda")

# MBO svm -----------------------------------------------------------

ps_svm = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-svm.rda")

ctrl <- makeMBOControl(propose.points = 1L)
ctrl <- setMBOControlTermination(ctrl, iters = 20L)
ctrl <- setMBOControlInfill(ctrl, crit = crit.ei)
tune.ctrl <- makeTuneControlMBO(
  mbo.control = ctrl,
  mbo.design = generateDesign(n = 30, par.set = ps_svm)
)

saveRDS(tune.ctrl, "/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-svm.rda")

# MBO KNN -----------------------------------------------------------

ps_knn = readRDS("/data/patrick/mod/pathogen-prediction/04-param-sets/param-set-svm.rda")

ctrl <- makeMBOControl(propose.points = 1L)
ctrl <- setMBOControlTermination(ctrl, iters = 20L)
ctrl <- setMBOControlInfill(ctrl, crit = crit.ei)
tune.ctrl <- makeTuneControlMBO(
  mbo.control = ctrl,
  mbo.design = generateDesign(n = 30, par.set = ps_knn)
)

saveRDS(tune.ctrl, "/data/patrick/mod/pathogen-prediction/05-tuning/MBO-30n-20it-1L-knn.rda")