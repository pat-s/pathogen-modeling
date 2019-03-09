reports = drake_plan(
  # Work around https://github.com/rstudio/rmarkdown/issues/1268
  benchmark_evaluation_report_diplodia = knitr::knit(
    #opts_knit$set(base.dir = "analysis/rmd/"),
    knitr_in("analysis/rmd/benchmark-eval-diplodia.Rmd"),
    output = file_out("analysis/rmd/benchmark-eval-diplodia.md"), # Important: must be the output file
    quiet = TRUE),
  benchmark_evaluation_report_all = knitr::knit(
    knitr_in("analysis/rmd/benchmark-eval-all.Rmd"),
    output = file_out("analysis/rmd/benchmark-eval-all.md"), # Important: must be the output file
    fig.path = ('analysis/rmd/figure'),
    quiet = TRUE),
  strings_in_dots = "literals"
)
