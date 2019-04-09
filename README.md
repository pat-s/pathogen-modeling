
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--04--09-brightgreen.svg)](https://github.com/pat-s/pathogen-modeling/commits/master)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-brightgreen.svg)](https://cran.r-project.org/)
[![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/)  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2582969.svg)](https://doi.org/10.5281/zenodo.2582969)

**Hyperparameter tuning and performance assessment of statistical and
machine-learning models using spatial data.**

# Authors

**Patrick Schratz** (<patrick.schratz@gmail.com>)
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0003-0748-6624)  
Jannes Muenchow
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-7834-4717)  
Eugenia Iturritxa
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-0577-3315)  
Jakob Richter
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0003-4481-5554)  
Alexander Brenning
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-6640-679X)

# Contents

This repository contains the research compendium of the above mentioned
paper.

  - [Paper](https://github.com/pat-s/pathogen-modeling/tree/master/analysis/paper/submission/3)  
  - [Appendices](https://github.com/pat-s/pathogen-modeling/tree/master/analysis/paper/submission/3/appendices)

# How to use

## Read the code, access the data

See the
[`analysis`](https://github.com/pat-s/pathogen-modeling/tree/master/analysis)
directory on GitHub for the source code that generated the figures and
statistical results contained in the manuscript. The raw data is stored
on [Zenodo](https://doi.org/10.5281/zenodo.2582970) and will be
downloaded when starting the analysis.

## Install the R package

[![Build
Status](https://travis-ci.org/pat-s/pathogen-modeling.svg?branch=master)](https://travis-ci.org/pat-s/pathogen-modeling)

This repository is organized as an R package, providing functions and
raw data to reproduce and extend the analysis reported in the
publication. Note that this package has been written explicitly for this
project and may not be suitable for general use.

This project is setup with a [drake
workflow](https://github.com/ropensci/drake), ensuring reproducibility.
Intermediate targets/objects will be stored in a hidden `.drake`
directory.

The R library of this project is managed by
[packrat](https://rstudio.github.io/packrat/). This makes sure that the
exact same package versions are used when recreating the project. When
calling `packrat::restore()`, all required packages will be installed
with their specific version.

Please note that this project was built with R version 3.5.1 on a CentOS
7.5 operating system. The packrat packages from this project **are not
compatible with R versions prior version 3.5.0.** (In general, it should
be possible to reproduce the analysis on any other operating system.)

To clone the project, a working installation of `git` is required. Open
a terminal in the directory of your choice and execute:

``` sh
git clone git@github.com:pat-s/pathogen-modeling.git
```

Then start R in this directory and run

``` r
packrat::restore() # restores all R packages with their specific version
r_make() # recreates the analysis
```

# Runtime

Predicted total runtime. The time is based on all targets that have been
created so far in the project. Estimated time will differ depending on
the CPU speed and possible availability of a HPC. Here, we assume that
the analysis is run on a cluster with three compute nodes (=
    “jobs”).

``` r
source("_drake.R")
```

    ## The interface at https://ropenscilabs.github.io/drake-manual/plans.html#large-plans is better than evaluate_plan(), map_plan(), gather_by(), etc.

    ## cache /home/patrick/git/pathogen-modeling/.drake

    ## analyze environment

    ## analyze 59 imports: dataset_tables_plan, prediction_prob_plan, age_imput...

    ## analyze 308 targets: armillaria_data, heterobasidion_data, diplodia_data...

    ## construct graph edges

    ## construct graph

``` r
config = drake_config(plan, targets = "benchmark_evaluation_report_diplodia")
predict_runtime(config, from_scratch = TRUE, jobs = 3)
```

    ## [1] "404.412s (~6.74 minutes)"

# Licenses

Text: CC-BY-4.0 <http://creativecommons.org/licenses/by/4.0/>

Code: MIT <http://opensource.org/licenses/MIT> year: 2019, copyright
holder: Patrick Schratz

Data: CC0 <http://creativecommons.org/publicdomain/zero/1.0/>

# Notes and resources

  - The [issues
    tracker](https://github.com/pat-s/pathogen-modeling/issues) is the
    place to report problems or ask questions

  - See the repository
    [history](https://github.com/pat-s/pathogen-modeling/commits/master)
    for a fine-grained view of progress and changes.

  - The structure of this compendium is based on the work of [Carl
    Boettiger](http://www.carlboettiger.info/) and [Ben
    Marwick](https://github.com/benmarwick).
