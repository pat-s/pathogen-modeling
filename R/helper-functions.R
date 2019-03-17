##### my.pairs env
the.col.hist <- "cyan"


panel.hist <- function(x, col.hist=the.col.hist,
                       cex.cor=NULL,digits=NULL,col=NULL,pch=NULL,cex=NULL,...)
{
  dummy <- is.character(cex.cor) | is.numeric(digits) | is.character(cex) | is.character(pch) | is.character(col)
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col=col.hist, ...)
}

panel.cor <- function(x, y, digits=2, prefix="", cex.cor=NULL,
                      col.hist=NULL,
                      col=NULL,pch=NULL,cex=NULL,...)
{
  dummy <- is.character(col.hist) | is.character(cex) | is.character(pch) | is.character(col)
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, use="pairwise.complete.obs"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if (is.null(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  #text(0.5, 0.5, txt, cex = cex.cor * r)
  text(0.5, 0.5, txt, cex = cex.cor)
}

my_pairs <- function( x, ... )
{
  pairs( x, ...,
         upper.panel=panel.smooth, lower.panel=panel.cor, diag.panel=panel.hist )
}

age_imputation <- function(x, y, age, print = TRUE) {
  wh <- which(is.na(age))
  N.na <- length(wh)
  set.seed(1234)
  for (i in wh) {
    di <- sqrt((x - x[i])^2 + (y - y[i])^2)
    wh.nn <- which(di < 50 & !is.na(age))
    if (length(wh.nn) < 5)
      wh.nn <- which(di < 100 & !is.na(age))
    if (length(wh.nn) < 5)
      wh.nn <- which(di < 200 & !is.na(age))
    if (length(wh.nn) < 5)
      wh.nn <- which(di < 300 & !is.na(age))
    if (length(wh.nn) < 5)
      wh.nn <- which(di < 400 & !is.na(age))
    if (length(wh.nn) > 0)
      age[i] = sample( age[wh.nn], size=1 )
    age[i] <- median(age[wh.nn])
  }
  if (print) cat("\nImputed", N.na - sum(is.na(age)), "age values.\n\n")
  return(age)
}

test_age_imputation <- function(x, y, age) {
  sel <- !is.na(age)
  x <- x[sel]
  y <- y[sel]
  age <- age[sel]
  res <- rep(NA, length(age))
  for (i in 1:length(res)) {
    temp.age <- age
    temp.age[i] <- NA
    temp.age <- age_imputation(x, y, temp.age, print=FALSE)
    res[i] <- temp.age[i]
  }
  return(data.frame(obs = age,imput = res))
}


# recursive function to remove name from all levels of list
stripname <- function(x, name) {
  thisdepth <- depth(x)
  if (thisdepth == 0) {
    return(x)
  } else if (length(nameIndex <- which(names(x) == name))) {
    x <- x[-nameIndex]
  }
  return(lapply(x, stripname, name))
}

# function to find depth of a list element
# see http://stackoverflow.com/questions/13432863/determine-level-of-nesting-in-r
depth <- function(this, thisdepth=0){
  if (!is.list(this)) {
    return(thisdepth)
  } else{
    return(max(unlist(lapply(this,depth,thisdepth=thisdepth+1))))
  }
}

#' @title remove_extract
#' @description Removes the extract column of a `mlr` BenchmarkResult object
#' @param bm_result BenchmarkResult object
#'
#' @details Typically, tuning results are stored in this slot. Combining many benchmark
#' results can lead to a huge object. For visualizing the performance, the
#' object can be shrinked with this function.
remove_extract = function(bm_result) {

  bm_result[["results"]] = map(bm_result[["results"]], ~
                                 {
                                   map(.x, function(y) list_modify(y, extract = NULL))
                                 })

  return(bm_result)
}

