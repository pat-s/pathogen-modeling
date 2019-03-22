get_stage("script") %>%
  add_step(step_rcmdcheck(error_on = "error", args = c("--no-tests", "--no-manual")))
