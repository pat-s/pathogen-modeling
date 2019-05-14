---
title: "Visualization of partitions"
output: 
  html_document: 
    css: ../style.css
    theme: readable
    number_sections: yes
    toc: yes
    toc_float: true
    toc_collapsed: true
    df_print: tibble
    includes:
      in_header: ../header.html
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

```
## Error in clustermq:::worker("tcp://edi:6076"): Assertion on 'r$extract' failed: Must be of type 'list', not 'NULL'.
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
                                                   resampling = "Spatial/Spatial",
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

```
## Error in clustermq:::worker("tcp://edi:6076"): Assertion on 'r$extract' failed: Must be of type 'list', not 'NULL'.
```

### KKNN


```r
tuning_effects_diplodia_sp_sp[[1]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_sp' not found
```

### RF 


```r
tuning_effects_diplodia_sp_sp[[2]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_sp' not found
```

### SVM 


```r
tuning_effects_diplodia_sp_sp[[3]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_sp' not found
```

### BRT 


```r
tuning_effects_diplodia_sp_sp[[4]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_sp' not found
```

## Spatial/Non-Spatial


```r
loadd(bm_sp_nsp_diplodia)

tuning_effects_diplodia_sp_nsp = vis_tuning_effects(bm_sp_nsp_diplodia$results$diplodia[2:5],
                                                    model_name = c(
                                                      "KNN", 
                                                      "RF", 
                                                      "SVM", 
                                                      "BRT"),
                                                    resampling = "Spatial/Non-Spatial",
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

```
## Error in clustermq:::worker("tcp://edi:6076"): Assertion on 'r$extract' failed: Must be of type 'list', not 'NULL'.
```

### KKNN


```r
tuning_effects_diplodia_sp_nsp[[1]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_nsp' not found
```

### RF 


```r
tuning_effects_diplodia_sp_nsp[[2]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_nsp' not found
```

### SVM 


```r
tuning_effects_diplodia_sp_nsp[[3]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_nsp' not found
```

### BRT 


```r
tuning_effects_diplodia_sp_nsp[[4]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_sp_nsp' not found
```

## Non-Spatial/Non-Spatial


```r
loadd(bm_nsp_nsp_diplodia)

tuning_effects_diplodia_nsp_nsp = vis_tuning_effects(bm_nsp_nsp_diplodia$results$diplodia[2:5],
                                                     model_name = c(
                                                       "KNN", 
                                                       "RF", 
                                                       "SVM", 
                                                       "BRT"),
                                                     resampling = "Non-Spatial/Non-Spatial",
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

```
## Error in clustermq:::worker("tcp://edi:6076"): Assertion on 'r$extract' failed: Must be of type 'list', not 'NULL'.
```

### KKNN


```r
tuning_effects_diplodia_nsp_nsp[[1]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_nsp_nsp' not found
```

### RF 


```r
tuning_effects_diplodia_nsp_nsp[[2]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_nsp_nsp' not found
```

### SVM 


```r
tuning_effects_diplodia_nsp_nsp[[3]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_nsp_nsp' not found
```

### BRT 


```r
tuning_effects_diplodia_nsp_nsp[[4]]
```

```
## Error in eval(expr, envir, enclos): object 'tuning_effects_diplodia_nsp_nsp' not found
```

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

```
## Error in plot_grid(tuning_effects_diplodia_nsp_nsp[[4]], tuning_effects_diplodia_nsp_nsp[[2]], : object 'tuning_effects_diplodia_nsp_nsp' not found
```

