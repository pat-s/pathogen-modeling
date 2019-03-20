---
title: "Visualization of partitions"
output: html_document
author: "Patrick Schratz, FSU Jena"
---

Visualization of optimization paths for the first five folds.


```r
knitr::opts_knit$set(base.dir = 'analysis/rmd/')
knitr::opts_chunk$set(fig.retina=3, fig.align = 'center',
                      out.width = "100%")
```

# Resampling strategies {.tabset .tabset-fade}

## Spatial/Spatial


```r
loadd(bm_sp_sp_diplodia)

opt_path_diplodia_sp_sp = vis_opt_path(bm_sp_sp_diplodia$results$diplodia)
```

```
## Warning: Calling `as_tibble()` on a vector is discouraged, because the behavior is likely to change in the future. Use `enframe(name = NULL)` instead.
## This warning is displayed once per session.
```

```
## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes
```

### GAM


```r
opt_path_diplodia_sp_sp[[1]]
```

<img src="../../analysis/figures/opt-path-gam-sp-sp-1.png" title="plot of chunk opt-path-gam-sp-sp" alt="plot of chunk opt-path-gam-sp-sp" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
opt_path_diplodia_sp_sp[[2]]
```

```
## Warning: Removed 78 rows containing missing values (geom_path).
```

<img src="../../analysis/figures/opt-path-knn-sp-sp-1.png" title="plot of chunk opt-path-knn-sp-sp" alt="plot of chunk opt-path-knn-sp-sp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
opt_path_diplodia_sp_sp[[3]]
```

<img src="../../analysis/figures/opt-path-rf-sp-sp-1.png" title="plot of chunk opt-path-rf-sp-sp" alt="plot of chunk opt-path-rf-sp-sp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
opt_path_diplodia_sp_sp[[4]]
```

<img src="../../analysis/figures/opt-path-svm-sp-sp-1.png" title="plot of chunk opt-path-svm-sp-sp" alt="plot of chunk opt-path-svm-sp-sp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
opt_path_diplodia_sp_sp[[5]]
```

<img src="../../analysis/figures/opt-path-brt-sp-sp-1.png" title="plot of chunk opt-path-brt-sp-sp" alt="plot of chunk opt-path-brt-sp-sp" width="100%" style="display: block; margin: auto;" />

## Spatial/Non-Spatial


```r
loadd(bm_sp_nsp_diplodia)

opt_path_diplodia_sp_nsp = vis_opt_path(bm_sp_nsp_diplodia$results$diplodia)
```

```
## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes
```

### GAM


```r
opt_path_diplodia_sp_nsp[[1]]
```

<img src="../../analysis/figures/opt-path-gam-sp-nsp-1.png" title="plot of chunk opt-path-gam-sp-nsp" alt="plot of chunk opt-path-gam-sp-nsp" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
opt_path_diplodia_sp_nsp[[2]]
```

```
## Warning: Removed 78 rows containing missing values (geom_path).
```

<img src="../../analysis/figures/opt-path-knn-sp-nsp-1.png" title="plot of chunk opt-path-knn-sp-nsp" alt="plot of chunk opt-path-knn-sp-nsp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
opt_path_diplodia_sp_nsp[[3]]
```

<img src="../../analysis/figures/opt-path-rf-sp-nsp-1.png" title="plot of chunk opt-path-rf-sp-nsp" alt="plot of chunk opt-path-rf-sp-nsp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
opt_path_diplodia_sp_nsp[[4]]
```

<img src="../../analysis/figures/opt-path-svm-sp-nsp-1.png" title="plot of chunk opt-path-svm-sp-nsp" alt="plot of chunk opt-path-svm-sp-nsp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
opt_path_diplodia_sp_nsp[[5]]
```

<img src="../../analysis/figures/opt-path-brt-sp-nsp-1.png" title="plot of chunk opt-path-brt-sp-nsp" alt="plot of chunk opt-path-brt-sp-nsp" width="100%" style="display: block; margin: auto;" />

## Non-Spatial/Non-Spatial


```r
loadd(bm_nsp_nsp_diplodia)

opt_path_diplodia_nsp_nsp = vis_opt_path(bm_nsp_nsp_diplodia$results$diplodia)
```

```
## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes

## Warning in bind_rows_(x, .id): Vectorizing 'glue' elements may not preserve
## their attributes
```

### GAM


```r
opt_path_diplodia_nsp_nsp[[1]]
```

<img src="../../analysis/figures/opt-path-gam-nsp-nsp-1.png" title="plot of chunk opt-path-gam-nsp-nsp" alt="plot of chunk opt-path-gam-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
opt_path_diplodia_nsp_nsp[[2]]
```

```
## Warning: Removed 78 rows containing missing values (geom_path).
```

<img src="../../analysis/figures/opt-path-knn-nsp-nsp-1.png" title="plot of chunk opt-path-knn-nsp-nsp" alt="plot of chunk opt-path-knn-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
opt_path_diplodia_nsp_nsp[[3]]
```

<img src="../../analysis/figures/opt-path-rf-nsp-nsp-1.png" title="plot of chunk opt-path-rf-nsp-nsp" alt="plot of chunk opt-path-rf-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
opt_path_diplodia_nsp_nsp[[4]]
```

<img src="../../analysis/figures/opt-path-svm-nsp-nsp-1.png" title="plot of chunk opt-path-svm-nsp-nsp" alt="plot of chunk opt-path-svm-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
opt_path_diplodia_nsp_nsp[[5]]
```

<img src="../../analysis/figures/opt-path-brt-nsp-nsp-1.png" title="plot of chunk opt-path-brt-nsp-nsp" alt="plot of chunk opt-path-brt-nsp-nsp" width="100%" style="display: block; margin: auto;" />

# Comparison RF sp vs nsp


```r
# remove title, we use cowplot labels
opt_path_diplodia_sp_sp[[3]] = opt_path_diplodia_sp_sp[[3]] + ggtitle("")
opt_path_diplodia_sp_nsp[[3]] = opt_path_diplodia_sp_nsp[[3]] + ggtitle("")

plot_grid(opt_path_diplodia_sp_sp[[3]], opt_path_diplodia_sp_nsp[[3]],
          labels = c("RF (sp/sp)", "RF (sp/nsp)"),
          ncol = 1, nrow = 2
)
```

<img src="../../analysis/paper/submission/3/latex-source-files/opt-paths-RF-sp-vs-nsp-1.png" title="plot of chunk opt-paths-RF-sp-vs-nsp" alt="plot of chunk opt-paths-RF-sp-vs-nsp" width="100%" style="display: block; margin: auto;" />

