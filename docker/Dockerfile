# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/r-ver:3.5.1

# required
MAINTAINER Patrick Schratz <patrick.schratz@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y update \
  && apt-get install -y gdal-bin \
	git-core \
	libcurl4-openssl-dev \
	libgdal-dev \
	libgeos-dev \
	libgmp-dev \
	libproj-dev \
	libssh2-1-dev \
	libssl-dev \
	libudunits2-dev \
	libxml2-dev \
	make \
	pandoc \
	pandoc-citeproc \
	saga \
	zlib1g-dev
RUN ["install2.r", "-r https://bioconductor.org/packages/3.8/bioc -r https://bioconductor.org/packages/3.8/data/annotation -rhttps://bioconductor.org/packages/3.8/data/experiment -rhttps://bioconductor.org/packages/3.8/workflows", "BiocGenerics", "graph"]
RUN ["install2.r", "acepack", "aqp", "assertthat", "backports", "base64enc", "BBmisc", "bindr", "bindrcpp", "BiocManager", "callr", "checkmate", "class", "classInt", "cli", "cluster", "CodeDepends", "codetools", "colorRamps", "colorspace", "crayon", "curl", "data.table", "DBI", "digest", "dismo", "dplyr", "drake", "e1071", "evaluate", "fastmatch", "FNN", "forcats", "foreign", "formatR", "Formula", "fs", "futile.logger", "futile.options", "ggplot2", "git2r", "glue", "gridExtra", "GSIF", "gstat", "gtable", "hexbin", "Hmisc", "htmlTable", "htmltools", "htmlwidgets", "httr", "igraph", "intervals", "jsonlite", "knitr", "lambda.r", "lattice", "latticeExtra", "lazyeval", "lhs", "magrittr", "MASS", "Matrix", "mco", "memuse", "misc3d", "mlr", "mlrMBO", "munsell", "needs", "nnet", "packrat", "parallelMap", "ParamHelpers", "pillar", "pixmap", "pkgbuild", "pkgconfig", "plot3D", "plotKML", "plotly", "plotrix", "plyr", "prettyunits", "processx", "ps", "purrr", "R.methodsS3", "R.oo", "R.utils", "R6", "raster", "rasterVis", "RColorBrewer", "Rcpp", "remotes", "reshape", "rgdal", "RJSONIO", "rlang", "rmarkdown", "rpart", "rprojroot", "RSAGA", "rstudioapi", "scales", "semver", "sf", "shapefiles", "smoof", "sp", "spacetime", "spData", "storr", "stringi", "stringr", "survival", "tibble", "tidyr", "tidyselect", "units", "usethis", "viridis", "viridisLite", "withr", "XML", "xts", "yaml", "zoo"]
RUN ["installGithub.r", "colorout", "lwgeom", "stevedore"]
WORKDIR /payload/
CMD ["R"]

