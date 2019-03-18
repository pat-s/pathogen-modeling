
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--03--18-brightgreen.svg)](https://github.com/pat-s/pathogen-modeling/commits/master)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-brightgreen.svg)](https://cran.r-project.org/)
[![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/)  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2582969.svg)](https://doi.org/10.5281/zenodo.2582969)

**Analyzing the importance of spatial autocorrelation in hyperparameter
tuning and performance estimation of machine-learning algorithms for
spatial data.**

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

This repository contains the research compendium of our work on
comparing algorithms among different resampling settings. The compendium
contains all data, code, and text associated with this section of the
publication:

# How to use

## Read the code, access the data

See the
[`analysis`](https://github.com/pat-s/pathogen-modeling/tree/master/analysis)
directory on GitHub for the source code that generated the figures and
statistical results contained in the manuscript. The raw is stored on
[Zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.2582970.svg)\](<https://doi.org/10.5281/zenodo.2582970>)
and will be downloaded when starting the analysis.

## Install the R package

[![Build
Status](https://travis-ci.org/pat-s/pathogen-modeling.svg?branch=master)](https://travis-ci.org/pat-s/pathogen-modeling)

This repository is organized as an R package, providing functions and
raw data to reproduce and extend the analysis reported in the
publication. Note that this package has been written explicitly for this
project and may not be suitable for more general use.

This project is setup with a [drake
workflow](https://github.com/ropensci/drake), ensuring reproducibility.
Intermediate targets/objects will be stored in a hidden `.drake`
directory.

The R library of this project is managed by
[packrat](https://rstudio.github.io/packrat/). This makes sure that the
exact same package versions are used when recreating the project. When
calling `packrat::restore()`, all required packages will be installed
with their specific version.

Please note that this project was built with R version 3.5.1 on a Debian
9 operating system. The packrat packages from this project **are not
compatible with R versions prior version 3.5.0.** For reproducibility,
it is recommended to replicate the analysis using the included
Dockerfile. Instructions can be found
[ħere](https://github.com/pat-s/pathogen-modeling#docker). (In general,
it should be possible to reproduce the analysis on any other operating
system.)

To clone the project, a working installation of `git` is required. Open
a terminal in the directory of your choice and execute:

``` sh
git clone git@github.com:pat-s/pathogen-modeling.git
```

Then start R in this directory and run

``` r
packrat::restore()
r_make()
```

# Runtime

Predicted total runtime. The time is based on all targets that have been
created so far in the project. Estimated time will differ depending on
the CPU speed and possible availability of a
    HPC.

``` r
r_predict_runtime()
```

    ## The interface at https://ropenscilabs.github.io/drake-manual/plans.html#large-plans is better than evaluate_plan(), map_plan(), gather_by(), etc.
    ## [90mcache[39m /home/patrick/git/pathogen-modeling/.drake
    ## [90manalyze[39m environment
    ## Unloading targets from environment:
    ##   bm_all_pathogens
    ## [90manalyze[39m 80 imports: benchmark_nsp_non_diplodia, benchmark_nsp_nsp_diplodia, p...
    ## [90manalyze[39m 274 targets: armillaria_data, heterobasidion_data, diplodia_data, tes...
    ## [90mconstruct[39m graph edges
    ## [90mconstruct[39m graph
    ## [90mconstruct[39m priority queue
    ## Warning messages:
    ## 1: Arguments `file_targets` and `strings_in_dots` of `drake_plan()` are deprecated. 
    ## 2: Some targets were never actually timed, And no hypothetical time was specified in `known_times`. Assuming a runtime of 0 for these targets:
    ##   benchmark_evaluation_report_diplodia 
    ## Error while shutting down parallel: unable to terminate some child processes

    ## [1] "291268.534s (~3.37 days)"

# Docker

A Dockerfile is available in `docker/`. It was generated by the R
package [`containerit`](https://github.com/o2r-project/containerit) and
contains all packrat packages and system libraries with have been used
to run the analysis (the file already exists, no need to do this).

``` r
remotes::install_github("pat-s/containerit@packrat")
library(containerit)
container = dockerfile(".", packrat = TRUE)
write(container, "docker/Dockerfile")
```

A docker container can be built and started from this Dockerfile by
executing `docker build -t image .` within the `./docker` directory.

Next, the analysis can be started by calling

``` r
r_make()
```

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
