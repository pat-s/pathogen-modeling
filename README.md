
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--05--20-brightgreen.svg)](https://github.com/pat-s/pathogen-modeling/commits/master)
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

In addition, it contains code and results for the [LIFE Healthy
Forest](http://www.lifehealthyforest.com/) project. The following
reports are available:

  - [Benchmark comparison of all pathogens]()
  - [Benchmark comparison of *Diplodia sapinea* only]()
  - [Prediction maps of all
    pathogens](https://jupiter.geogr.uni-jena.de/life-healthy-forest/action-B1-pathogen-infection/pathogen-prediction-report.html)
  - [Visualization of (spatial) resampling partitions]()
  - [Visualization of hyperparameter optimization paths]()

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

# Structure of the analysis

In the `drake` philosophy, every R object is a “target” with
dependencies. This repository contains more targets than actually needed
to replicate the associated publication.

If you want to replicate the publication, you need to build the
following targets:

  - `pathogens_performance_diplodia` (Benchmark comparison report)
  - `visualize_opt_paths`(Optimization path figure)
  - `visualize_tuning_effects` (Tuning effects figure)
  - `visualize_partitions` (Partition figure)

Please note that when replicating these targets you cannot use the same
HPC infrastructure that was used to generate the outputs. This means
that replicating this analysis sequentially will take weeks (\> 4).
Unless you have a scalable system to run the analysis on, sequential
replication is not encouraged.

#### Other practical notes

  - All “diplodia” targets (`bm_sp_sp_diplodia`, `bm_sp_nsp_diplodia`
    and `bm_nsp_nsp_diplodia`) are built with
    `mlr::benchmark(keep.extract = TRUE)` in
    [benchmark\_custom](https://github.com/pat-s/pathogen-modeling/blob/335ca2c5bd92f04b6eba78f1b414fa61b1d6fb5c/R/benchmark-functions.R).
    This slot is needed to perform analysis on the tuning results. All
    other pathogens are built with `mlr::benchmark(keep.extract =
    FALSE)` to save disk space of the resulting R objects. BMR + tuning
    results = ~ 3 GB, BMR - tuning results = xx
MB.

# Licenses

| Text                                                    | Code                                                                                                | Data                                                   |
| ------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| CC-BY-4.0 <http://creativecommons.org/licenses/by/4.0/> | MIT <http://opensource.org/licenses/MIT><br>year: 2018 - 2019,<br>copyright holder: Patrick Schratz | CC0 <http://creativecommons.org/publicdomain/zero/1.0> |

Text: CC-BY-4.0 <http://creativecommons.org/licenses/by/4.0/>

Code: MIT <http://opensource.org/licenses/MIT> year: 2018 - 2019,
copyright holder: Patrick Schratz

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
