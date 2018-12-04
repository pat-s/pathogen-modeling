# MBO ranger -----------------------------------------------------------

ctrl_rf <- makeMBOControl(propose.points = 1L) %>%
  setMBOControlTermination(iters = 20L) %>%
  setMBOControlInfill(crit = crit.ei)
tune.ctrl_rf <- makeTuneControlMBO(
  mbo.control = ctrl_rf,
  mbo.design = generateDesign(n = 30, par.set = ps_rf)
)

wrapper_rf <- makeTuneWrapper(
  lrn_rf,
  resampling = spcv_inner_fiveF, par.set = ps_rf,
  control = tune.ctrl_rf, show.info = FALSE,
  measures = list(brier)
)

# MBO xgboost -----------------------------------------------------------

ctrl_xgboost <- makeMBOControl(propose.points = 1L) %>%
  setMBOControlTermination(iters = 20L) %>%
  setMBOControlInfill(crit = crit.ei)
tune.ctrl_xgboost <- makeTuneControlMBO(
  mbo.control = ctrl_xgboost,
  mbo.design = generateDesign(n = 30, par.set = ps_xgboost)
)

wrapper_xgboost <- makeTuneWrapper(
  lrn_xgboost,
  resampling = spcv_inner_fiveF, par.set = ps_xgboost,
  control = tune.ctrl_xgboost, show.info = FALSE,
  measures = list(brier)
)

# MBO svm -----------------------------------------------------------

ctrl_svm <- makeMBOControl(propose.points = 1L) %>%
  setMBOControlTermination(iters = 20L) %>%
  setMBOControlInfill(crit = crit.ei)
tune.ctrl_svm <- makeTuneControlMBO(
  mbo.control = ctrl_svm,
  mbo.design = generateDesign(n = 30, par.set = ps_svm)
)

wrapper_svm <- makeTuneWrapper(
  lrn_svm,
  resampling = spcv_inner_fiveF, par.set = ps_svm,
  control = tune.ctrl_svm, show.info = FALSE,
  measures = list(brier)
)

# MBO KNN -----------------------------------------------------------

ctrl_kknn <- makeMBOControl(propose.points = 1L) %>%
  setMBOControlTermination(iters = 20L) %>%
  setMBOControlInfill(crit = crit.ei)
tune.ctrl_kknn <- makeTuneControlMBO(
  mbo.control = ctrl_kknn,
  mbo.design = generateDesign(n = 30, par.set = ps_kknn)
)

wrapper_kknn <- makeTuneWrapper(
  lrn_kknn,
  resampling = spcv_inner_fiveF, par.set = ps_kknn,
  control = tune.ctrl_kknn, show.info = FALSE,
  measures = list(brier)
)
