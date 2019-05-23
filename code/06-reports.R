reports_plan = drake_plan(

  benchmark_diplodia = wflow_build(knitr_in("analysis/benchmark_diplodia.Rmd"), view = FALSE),

  benchmark_pathogens = wflow_build(knitr_in("analysis/benchmark_pathogens.Rmd"), view = FALSE),

  prediction_pathogens = wflow_build(knitr_in("analysis/prediction-pathogens.Rmd"), view = FALSE),

  pathogen_maps_debugging = wflow_build(knitr_in("analysis/pathogen-maps-debugging.Rmd"), view = FALSE),

  vis_partitions = wflow_build(knitr_in("analysis/vis-partitions.Rmd"), view = FALSE),

  vis_opt_paths = wflow_build(knitr_in("analysis/vis-opt-paths.Rmd"), view = FALSE),

  vis_tuning_effects = wflow_build(knitr_in("analysis/vis-tuning-effects.Rmd"), view = FALSE),

  strings_in_dots = "literals"
)
