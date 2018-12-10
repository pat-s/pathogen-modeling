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
