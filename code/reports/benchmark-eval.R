reports = drake_plan(
  # Work around https://github.com/rstudio/rmarkdown/issues/1268
  benchmark_evaluation_report = knitr::knit(
    knitr_in("code/rmd/benchmark-eval.Rmd"),
    output = file_out("code/rmd/output-benchmarks.md"), # Important: must be the output file
    quiet = TRUE),
  strings_in_dots = "literals"
)
