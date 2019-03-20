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

tuning_effects_diplodia_sp_sp = vis_tuning_effects(bm_sp_sp_diplodia$results$diplodia[2:5],
                                                   model_name = c(
                                                     "KNN", 
                                                     "RF", 
                                                     "SVM", 
                                                     "BRT"),
                                                   resampling = "spatial/spatial",
                                                   hyperparameter = list(
                                                     c("k", "distance"),
                                                     c("min.node.size", "mtry"),
                                                     c("cost", "gamma"),
                                                     c("n.trees", "shrinkage")),
                                                   xlim = list(
                                                     c(1, 100),
                                                     c(1, 10),
                                                     c(-5, 12),
                                                     c(100, 10000)
                                                     
                                                   ),
                                                   ylim = list(
                                                     c(1, 100),
                                                     c(1, 11),
                                                     c(-12, 3),
                                                     c(0, 0.2)
                                                   ),
                                                   default = list(
                                                     c(7, 2),
                                                     c(1, 3),
                                                     c(1, 1),
                                                     c(100, 0.001)
                                                   )
)
```

# Resampling strategies {.tabset .tabset-fade}

## Spatial/Spatial


```r
loadd(bm_sp_sp_diplodia)

tuning_effects_diplodia_sp_sp = vis_tuning_effects(bm_sp_sp_diplodia$results$diplodia[2:5],
                                                   model_name = c(
                                                     "KNN", 
                                                     "RF", 
                                                     "SVM", 
                                                     "BRT"),
                                                   resampling = "spatial/spatial",
                                                   hyperparameter = list(
                                                     c("k", "distance"),
                                                     c("min.node.size", "mtry"),
                                                     c("cost", "gamma"),
                                                     c("n.trees", "shrinkage")),
                                                   xlim = list(
                                                     c(1, 100),
                                                     c(1, 10),
                                                     c(-5, 12),
                                                     c(100, 10000)
                                                     
                                                   ),
                                                   ylim = list(
                                                     c(1, 100),
                                                     c(1, 11),
                                                     c(-12, 3),
                                                     c(0, 0.2)
                                                   ),
                                                   default = list(
                                                     c(7, 2),
                                                     c(1, 3),
                                                     c(1, 1),
                                                     c(100, 0.001)
                                                   )
)
```

### KKNN


```r
tuning_effects_diplodia_sp_sp[[1]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-knn-sp-sp-1.png" title="plot of chunk tuning-effects-knn-sp-sp" alt="plot of chunk tuning-effects-knn-sp-sp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
tuning_effects_diplodia_sp_sp[[2]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-rf-sp-sp-1.png" title="plot of chunk tuning-effects-rf-sp-sp" alt="plot of chunk tuning-effects-rf-sp-sp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
tuning_effects_diplodia_sp_sp[[3]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-svm-sp-sp-1.png" title="plot of chunk tuning-effects-svm-sp-sp" alt="plot of chunk tuning-effects-svm-sp-sp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
tuning_effects_diplodia_sp_sp[[4]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-brt-sp-sp-1.png" title="plot of chunk tuning-effects-brt-sp-sp" alt="plot of chunk tuning-effects-brt-sp-sp" width="100%" style="display: block; margin: auto;" />

## Spatial/Non-Spatial


```r
loadd(bm_sp_nsp_diplodia)

tuning_effects_diplodia_sp_nsp = vis_tuning_effects(bm_sp_nsp_diplodia$results$diplodia[2:5],
                                                    model_name = c(
                                                      "KNN", 
                                                      "RF", 
                                                      "SVM", 
                                                      "BRT"),
                                                    resampling = "Spatial/Non-spatial",
                                                    hyperparameter = list(
                                                      c("k", "distance"),
                                                      c("min.node.size", "mtry"),
                                                      c("cost", "gamma"),
                                                      c("n.trees", "shrinkage")),
                                                    xlim = list(
                                                      c(1, 100),
                                                      c(1, 10),
                                                      c(-5, 12),
                                                      c(100, 10000)
                                                      
                                                    ),
                                                    ylim = list(
                                                      c(1, 100),
                                                      c(1, 11),
                                                      c(-12, 3),
                                                      c(0, 0.2)
                                                    ),
                                                    default = list(
                                                      c(7, 2),
                                                      c(1, 3),
                                                      c(1, 1),
                                                      c(100, 0.001)
                                                    )
)
```

### KKNN


```r
tuning_effects_diplodia_sp_nsp[[1]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-knn-sp-nsp-1.png" title="plot of chunk tuning-effects-knn-sp-nsp" alt="plot of chunk tuning-effects-knn-sp-nsp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
tuning_effects_diplodia_sp_nsp[[2]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-rf-sp-nsp-1.png" title="plot of chunk tuning-effects-rf-sp-nsp" alt="plot of chunk tuning-effects-rf-sp-nsp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
tuning_effects_diplodia_sp_nsp[[3]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-svm-sp-nsp-1.png" title="plot of chunk tuning-effects-svm-sp-nsp" alt="plot of chunk tuning-effects-svm-sp-nsp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
tuning_effects_diplodia_sp_nsp[[4]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-brt-sp-nsp-1.png" title="plot of chunk tuning-effects-brt-sp-nsp" alt="plot of chunk tuning-effects-brt-sp-nsp" width="100%" style="display: block; margin: auto;" />

## Non-Spatial/Non-Spatial


```r
loadd(bm_nsp_nsp_diplodia)

tuning_effects_diplodia_nsp_nsp = vis_tuning_effects(bm_nsp_nsp_diplodia$results$diplodia[2:5],
                                                     model_name = c(
                                                       "KNN", 
                                                       "RF", 
                                                       "SVM", 
                                                       "BRT"),
                                                     resampling = "Non-Spatial/Non-spatial",
                                                     hyperparameter = list(
                                                       c("k", "distance"),
                                                       c("min.node.size", "mtry"),
                                                       c("cost", "gamma"),
                                                       c("n.trees", "shrinkage")),
                                                     xlim = list(
                                                       c(1, 100),
                                                       c(1, 10),
                                                       c(-5, 12),
                                                       c(100, 10000)
                                                       
                                                     ),
                                                     ylim = list(
                                                       c(1, 100),
                                                       c(1, 11),
                                                       c(-12, 3),
                                                       c(0, 0.2)
                                                     ),
                                                     default = list(
                                                       c(7, 2),
                                                       c(1, 3),
                                                       c(1, 1),
                                                       c(100, 0.001)
                                                     )
)
```

### KKNN


```r
tuning_effects_diplodia_nsp_nsp[[1]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-knn-nsp-nsp-1.png" title="plot of chunk tuning-effects-knn-nsp-nsp" alt="plot of chunk tuning-effects-knn-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### RF 


```r
tuning_effects_diplodia_nsp_nsp[[2]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-rf-nsp-nsp-1.png" title="plot of chunk tuning-effects-rf-nsp-nsp" alt="plot of chunk tuning-effects-rf-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### SVM 


```r
tuning_effects_diplodia_nsp_nsp[[3]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-svm-nsp-nsp-1.png" title="plot of chunk tuning-effects-svm-nsp-nsp" alt="plot of chunk tuning-effects-svm-nsp-nsp" width="100%" style="display: block; margin: auto;" />

### BRT 


```r
tuning_effects_diplodia_nsp_nsp[[4]]
```

<img src="../../analysis/paper/submission/3/appendices/tuning-effects-brt-nsp-nsp-1.png" title="plot of chunk tuning-effects-brt-nsp-nsp" alt="plot of chunk tuning-effects-brt-nsp-nsp" width="100%" style="display: block; margin: auto;" />

# Grid of most settings


```r
plot_grid(tuning_effects_diplodia_nsp_nsp[[4]], tuning_effects_diplodia_nsp_nsp[[2]],
  tuning_effects_diplodia_nsp_nsp[[3]], tuning_effects_diplodia_nsp_nsp[[1]],
  
  tuning_effects_diplodia_sp_nsp[[4]], tuning_effects_diplodia_sp_nsp[[2]],
  tuning_effects_diplodia_sp_nsp[[3]], tuning_effects_diplodia_sp_nsp[[1]],
  
  tuning_effects_diplodia_sp_sp[[4]], tuning_effects_diplodia_sp_sp[[2]],
  tuning_effects_diplodia_sp_sp[[3]], tuning_effects_diplodia_sp_sp[[1]],
  
  ncol = 4, nrow = 3
)
```

<img src="../../analysis/paper/submission/3/latex-source-files/tuning_effects_all_models_mbo-1.png" title="plot of chunk tuning_effects_all_models_mbo" alt="plot of chunk tuning_effects_all_models_mbo" width="100%" style="display: block; margin: auto;" />

