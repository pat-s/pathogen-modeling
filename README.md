# LIFE Healthy Forest

Benchmarking classifiers (SVM, RF, XGBOOST) on four different pathogens:

* Armillaria
* Diplodia
* Heterobasidion
* Fusarium

#### Hyperparameter tuning: 

Sequential model-based optimization (SMBO)

#### Data

Stored at [Mendeley Data](http://dx.doi.org/10.17632/kmy95t22fy.1).
Will be downloaded and processed when executing the project.

#### Workflow

This project is setup with a [drake workflow](https://github.com/ropensci/drake), ensuring reproducibility.
The complete project can be run in any R installation by executing:

```r
if (!requireNamespace(c("needs", "drake", "git2r"))) install.packages(c("needs", "drake", "git2r"))
git2r::clone("https://venus.geogr.uni-jena.de/bi28yuv/pathogen-modelling", ".")

source("scripts/drake.R")
make(plan, keep_going = TRUE, console_log_file=stdout()) 
# use more cores with make(plan, jobs = <number of cores>)
```

The dependency graph (subjective grouping) can be visualized using

```r
vis_drake_graph(config, group = "stage", clusters = c("task", "learner", "data"
                                                      "mlr_settings",
                                                      "benchmark",
                                                      "prediction"),
                targets_only = TRUE, show_output_files = FALSE)
```

![](drake.png)

If all required objects should be visualized (not recommended):

```r
vis_drake_graph(config)
```
