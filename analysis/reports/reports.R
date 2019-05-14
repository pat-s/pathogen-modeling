reports_plan = drake_plan(

  benchmark_diplodia = knitr::knit(
    knitr_in("analysis/rmd/paper/benchmark-diplodia.Rmd"),
    output = file_out("analysis/rmd/paper/benchmark-diplodia.md"),
    quiet = TRUE),

  benchmark_all_pathogens = knitr::knit(
    knitr_in("analysis/rmd/project/benchmark-all-pathogens.Rmd"),
    output = file_out("analysis/rmd/project/benchmark-all-pathogens.md"),
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

  prediction_maps = knitr::knit(
    knitr_in("analysis/rmd/project/pathogen-prediction-report.Rmd"),
    output = file_out("analysis/rmd/project/pathogen-prediction-report.md"),
    quiet = TRUE),

  strings_in_dots = "literals"
)
