[![Last-changedate](https://img.shields.io/badge/last%20change-2019--01--29-brightgreen.svg)](https://github.com/pat-s/pathogen-modeling/commits/master) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.5.0-brightgreen.svg)](https://cran.r-project.org/) [![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/)
<!-- [![Travis-CI Build Status](https://travis-ci.org/pat-s/pathogen-modeling.png?branch=master)](https://travis-ci.org/pat-s/pathogen-modeling)  --> [![ORCiD](https://img.shields.io/badge/ORCiD-0000-0003-0748-6624-green.svg)](http://orcid.org/0000-0003-0748-6624)

### Compendium URL

<http://dx.doi.org/10.6084/m9.figshare.1297059>

### Authors

**Patrick Schratz** (<patrick.schratz@gmail.com>) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0003-0748-6624)
Jannes Muenchow (<jannes.muenchow@uni-jena.de>) [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-7834-4717)
Eugenia Iturritxa () [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0002-0577-3315)
Jakob Richter () [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0003-4481-5554)
Alexander Brenning () [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](http://orcid.org/0000-0001-6640-679X)

### Contents

This repository contains the research compendium of our work on comparing algorithms among different resampling settings. The compendium contains all data, code, and text associated with this section of the publication:

### How to use

#### Read the code, access the data

See the [`analysis`](https://github.com/pat-s/pathogen-modeling/tree/master/analysis) directory on GitHub for the source code that generated the figures and statistical results contained in the manuscript. See the [`data`](https://github.com/pat-s/pathogen-modeling/tree/master/vignettes/data) directory for instructions how to access the raw data discussed in the manuscript.

#### Install the R package

[![Build Status](https://travis-ci.org/pat-s/pathogen-modeling.svg?branch=master)](https://travis-ci.org/pat-s/pathogen-modeling)

This repository is organized as an R package, providing functions and raw data to reproduce and extend the analysis reported in the publication. Note that this package has been written explicitly for this project and may not be suitable for more general use. To download the package source as you see it on GitHub, for offline browsing, use this line at the shell prompt:

``` r
git clone https://github.com/pat-s/pathogen-modeling.git
```

Or to install, build and use the package within R, use this line at the R prompt:

``` r
remotes::install_github("pat-s/pathogen-modeling", build_vignettes = TRUE)
```

Then you can read the text & figures using this line at the R prompt:

This R package has several depedencies that are listed below, some of which need to be installed manually if using this package from your local R installation.

This project is setup with a [drake workflow](https://github.com/ropensci/drake), ensuring reproducibility. Intermediate targets/objects will be stored in a hidden `.drake` directory.

The R library of this project is managed by [packrat](https://rstudio.github.io/packrat/). This makes sure that the exact same package versions are used when recreating the project. When calling `packrat::restore()`, all required packages will be installed with their specific version.

Please note that this project was built with R version 3.5.1 on a Debian 9 operating system. The packrat packages from this project **are not compatible with R versions prior version 3.5.0.** For reproducibility, it is recommended to replicate the analysis using the included Dockerfile. Instructions can be found [ħere](https://github.com/pat-s/pathogen-modeling#docker). (In general, it should be possible to reproduce the analysis on any other operating system.)

To clone the project, a working installation of `git` is required. Open a terminal in the directory of your choice and execute:

``` sh
git clone git@github.com:pat-s/pathogen-modeling.git
```

Then start R in this directory and run

``` r
packrat::restore()
source("analysis/drake.R")
make(plan, keep_going = TRUE, console_log_file = stdout()) 
# use more cores with make(plan, jobs = <number of cores>)
```

Runtime
-------

Predicted total runtime (based on all target runtimes ever built and stored in the internal `config` file)

``` r
source("analysis/drake.R")
predict_runtime(config, from_scratch = TRUE)
```

    ## Warning: Some targets were never actually timed, And no hypothetical time was specified in `known_times`. Assuming a runtime of 0 for these targets:
    ##   lrn_gam_diplodia_pred
    ##   lrn_gam_fusarium_pred
    ##   lrn_gam_armillaria_pred
    ##   lrn_gam_heterobasidion_pred
    ##   lrn_gam_diplodia_perf_non
    ##   lrn_gam_fusarium_perf_non
    ##   lrn_gam_armillaria_perf_non
    ##   lrn_gam_heterobasidion_perf_non
    ##   wrapper_xgboost_nsp
    ##   prediction_kknn
    ##   bm_sp_sp_xgboost
    ##   prediction_xgboost
    ##   bm_sp_nsp_gam_armillaria
    ##   bm_sp_nsp_gam_fusarium
    ##   bm_sp_non_gam_armillaria
    ##   bm_sp_non_gam_diplodia
    ##   bm_sp_non_gam_fusarium
    ##   bm_sp_non_gam_heterobasidion
    ##   bm_nsp_nsp_gam_armillaria
    ##   bm_nsp_nsp_gam_diplodia
    ##   bm_nsp_nsp_gam_fusarium
    ##   bm_nsp_nsp_gam_heterobasidion
    ##   bm_nsp_non_gam_armillaria
    ##   bm_nsp_non_gam_diplodia
    ##   bm_nsp_non_gam_fusarium
    ##   bm_nsp_non_gam_heterobasidion
    ##   bm_sp_nsp_xgboost
    ##   bm_sp_nsp_brt
    ##   bm_sp_non_xgboost
    ##   ...

    ## [1] "1968029.341s (~3.25 weeks)"

Acceleration when parallelizing the `make()` call

``` r
time <- c()
for (jobs in 1:10){
  time[jobs] <- predict_runtime(
    drake_config(),
    jobs = jobs,
    from_scratch = TRUE,
    known_times = build_times(targets_only = TRUE)$elapsed
  )
}

library(ggplot2)
ggplot(data.frame(time = time / 3600, jobs = ordered(1:10), group = 1)) +
  geom_line(aes(x = jobs, y = time, group = group)) +
  scale_y_continuous(breaks = 0:10 * 4, limits = c(0, 29)) +
  ggpubr::theme_pubr() +
  xlab("jobs argument of make()") +
  ylab("Predicted runtime of make() (hours)")
```

![](README_files/figure-markdown_github/README-6-1.png)

Docker
------

A Dockerfile is available in `docker/`. It was generated by the R package [`containerit`](https://github.com/o2r-project/containerit) and contains all packrat packages and system libraries with have been used to run the analysis (the file already exists, no need to do this).

``` r
remotes::install_github("pat-s/containerit@packrat")
library(containerit)
container = dockerfile(".", packrat = TRUE)
write(container, "docker/Dockerfile")
```

A docker container can be built and started from this Dockerfile by executing `docker build -t image .` within the `./docker` directory.

Next, the analysis can be started by calling

``` r
source("analysis/drake.R")
make(plan, keep_going = TRUE, console_log_file = stdout()) 
```

### Licenses:

Text: CC-BY-4.0 <http://creativecommons.org/licenses/by/4.0/>

Code: MIT <http://opensource.org/licenses/MIT> year: 2015, copyright holder: Patrick Schratz

Data: CC0 <http://creativecommons.org/publicdomain/zero/1.0/>

### Notes and resources

-   The [issues tracker](https://github.com/pat-s/pathogen-modeling/issues) is the place to report problems or ask questions

-   See the repository [history](https://github.com/pat-s/pathogen-modeling/commits/master) for a fine-grained view of progress and changes.

-   The organisation of this compendium is based on the work of [Carl Boettiger](http://www.carlboettiger.info/) and [Ben Marwick](https://github.com/benmarwick).
