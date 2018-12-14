wrapper_custom <- function(lrn, param_set, resampling, tune_ctrl) {

  wrapper <- makeTuneWrapper(
    lrn,
    resampling = resampling, par.set = param_set,
    control = tune_ctrl, show.info = FALSE,
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

tune_ctrl_mbo_30n_20it = function(param_set) {
  makeTuneControlMBO(
    mbo.control = makeMBOControl(propose.points = 1L) %>%
      setMBOControlTermination(iters = 70L) %>%
      setMBOControlInfill(crit = crit.ei),
    mbo.design = generateDesign(n = 30, par.set = param_set)
  )
}
