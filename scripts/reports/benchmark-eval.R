reports = drake_plan(

  benchmark_evaluation_report = rmarkdown::render(
    knitr_in("scripts/rmd/benchmark-eval.Rmd"),
    output_file = file_out("scripts/rmd/benchmark-eval.Rmd"),
    quiet = TRUE),
  strings_in_dots = "literals"
)
