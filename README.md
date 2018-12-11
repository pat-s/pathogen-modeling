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
Data will be downloaded and processed when executing the project.
Store directory will be "./data".
Only raster files will be kept after the download as raster processes require a file stored on disk.

#### Workflow

This project is setup with a [drake workflow](https://github.com/ropensci/drake), ensuring reproducibility.
Intermediate targets/objects will be stored in a hidden `.drake` directory.

The R library of this project is managed by [packrat](https://rstudio.github.io/packrat/).
This makes sure that the exact same package versions are used when recreating the project.
Furthermore there is no need to install any packages as the packrat sources from this repository will be used.

Please note that this project was build with R version 3.5.1.
The packrat packages from this project **are not compatible with R versions prior version 3.5.0.**

The project was built on a Debian 9 Linux system. 
However, it should be reproducible on any other operating system.

To clone the project, a working installation of `git` is required.
Open a terminal in the directory of your choice and execute:

```sh
git clone https://venus.geogr.uni-jena.de/bi28yuv/pathogen-modelling
```

Then open a R session in this directory and run

```r
source("scripts/drake.R")
make(plan, keep_going = TRUE, console_log_file=stdout()) 
# use more cores with make(plan, jobs = <number of cores>)
```

# Dependency graphs

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
