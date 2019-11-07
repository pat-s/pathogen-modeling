#' @title mlr tuning wrapper
#' @template learner
#' @template param_set
#' @template resampling
#' @template tune_ctrl
tuning_wrapper_custom <- function(lrn, param_set, resampling, tune_ctrl) {

  wrapper <- makeTuneWrapper(
    lrn,
    resampling = resampling, par.set = param_set,
    control = tune_ctrl, show.info = FALSE,
    measures = list(brier)
  )
  return(wrapper)
}

#' @title mlrMBO 30n 20 iterations tuning setting
#' @template param_set
tune_ctrl_mbo_30n_20it = function(param_set) {
  makeTuneControlMBO(
    mbo.control = makeMBOControl(propose.points = 1L,
                                 on.surrogate.error = "warn") %>%
      setMBOControlTermination(iters = 20L) %>%
      setMBOControlInfill(crit = crit.ei),
    mbo.design = generateDesign(n = 30, par.set = param_set)
  )
}

#' @title mlrMBO 30n 70 iterations tuning setting
#' @template param_set
tune_ctrl_mbo_30n_70it = function(param_set) {
  makeTuneControlMBO(
    mbo.control = makeMBOControl(propose.points = 1L,
                                 on.surrogate.error = "warn") %>%
      setMBOControlTermination(iters = 70L) %>%
      setMBOControlInfill(crit = crit.ei),
    mbo.design = generateDesign(n = 30, par.set = param_set)
  )
}
