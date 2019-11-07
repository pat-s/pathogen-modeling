reports_plan = drake_plan(

  benchmark_diplodia = wflow_publish(knitr_in("analysis/benchmark-diplodia.Rmd"), view = FALSE),

  benchmark_pathogens = wflow_publish(knitr_in("analysis/benchmark-pathogens.Rmd"), view = FALSE),

  prediction_pathogens = wflow_publish(knitr_in("analysis/prediction-pathogens.Rmd"), view = FALSE),

  pathogen_maps_debugging = wflow_publish(knitr_in("analysis/pathogen-maps-debugging.Rmd"), view = FALSE),

  vis_partitions = wflow_publish(knitr_in("analysis/vis-partitions.Rmd"), view = FALSE),

  vis_opt_paths = wflow_publish(knitr_in("analysis/vis-opt-paths.Rmd"), view = FALSE),

  vis_tuning_effects = wflow_publish(knitr_in("analysis/vis-tuning-effects.Rmd"), view = FALSE)

)
