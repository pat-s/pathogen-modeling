reports_plan = drake_plan(

  pathogens_performance_diplodia = knitr::knit(
    knitr_in("analysis/rmd/paper/pathogens-performance-diplodia.Rmd"),
    output = file_out("analysis/rmd/paper/pathogens-performance-diplodia.md"),
    quiet = TRUE),

  pathogens_performance = knitr::knit(
    knitr_in("analysis/rmd/project/pathogens-performance.Rmd"),
    output = file_out("analysis/rmd/project/pathogens-performance.md"),
    quiet = TRUE),

  pathogens_prediction = knitr::knit(
    knitr_in("analysis/rmd/project/pathogen-prediction.Rmd"),
    output = file_out("analysis/rmd/project/pathogens-prediction.md"),
    quiet = TRUE),

  pathogens_prediction_debugging = knitr::knit(
    knitr_in("analysis/rmd/project/pathogens-prediction-debugging.Rmd"),
    output = file_out("analysis/rmd/project/pathogens-prediction-debugging.md"),
    quiet = TRUE),

  visualize_partitions = knitr::knit(
    knitr_in("analysis/rmd/paper/visualize-partitions.Rmd"),
    output = file_out("analysis/rmd/paper/visualize-partitions.md"),
    quiet = TRUE),

  visualize_opt_paths = knitr::knit(
    knitr_in("analysis/rmd/paper/vis-opt-paths.Rmd"),
    output = file_out("analysis/rmd/paper/vis-opt-paths.md"),
    quiet = TRUE),

  visualize_tuning_effects = knitr::knit(
    knitr_in("analysis/rmd/paper/vis-tuning-effects.Rmd"),
    output = file_out("analysis/rmd/paper/vis-tuning-effects.md"),
    quiet = TRUE),

  strings_in_dots = "literals"
)
