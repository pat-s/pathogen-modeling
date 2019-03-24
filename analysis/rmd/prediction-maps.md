---
title: "Prediction maps of classifiers"
output: html_document
author: "Patrick Schratz, FSU Jena"
---

Models that did not converge:

- Armillaria: XGBOOST (sp/sp)
- Armillaria: GAM     (sp/sp)

Since we got no performance estimate of these combinations, we did not create prediction maps.

Furthermore, XGBOOST cannot handle new levels factors of the prediction data (or at least I do not know how to solve this).
Therefore, no prediction maps for XGBOOST as the prediction values are all NA.





# Pathogens {.tabset .tabset-fade}

## Armillaria

### GAM


```r
NA
```

```
## [1] NA
```

### GLM


```r
maps_glm_armillaria
```

```
## Error in eval(expr, envir, enclos): object 'maps_glm_armillaria' not found
```

### BRT


```r
maps_brt[[1]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-brt-1.png" title="plot of chunk prediction-map-armillaria-brt" alt="plot of chunk prediction-map-armillaria-brt" width="100%" style="display: block; margin: auto;" />

### RF


```r
maps_rf[[1]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-rf-1.png" title="plot of chunk prediction-map-armillaria-rf" alt="plot of chunk prediction-map-armillaria-rf" width="100%" style="display: block; margin: auto;" />

### SVM


```r
maps_svm[[1]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-svm-1.png" title="plot of chunk prediction-map-armillaria-svm" alt="plot of chunk prediction-map-armillaria-svm" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
maps_kknn[[1]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230743 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-knn-1.png" title="plot of chunk prediction-map-armillaria-knn" alt="plot of chunk prediction-map-armillaria-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```r
NA
```

```
## [1] NA
```


## Heterobasidion

### GAM


```r
maps_gam_heterobasidion
```

```
## $heterobasidion
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-gam-1.png" title="plot of chunk prediction-map-heterobasidion-gam" alt="plot of chunk prediction-map-heterobasidion-gam" width="100%" style="display: block; margin: auto;" />

### GLM


```r
maps_glm_heterobasidion
```

```
## Error in eval(expr, envir, enclos): object 'maps_glm_heterobasidion' not found
```

### BRT


```r
maps_brt[[2]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230707 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-brt-1.png" title="plot of chunk prediction-map-heterobasidion-brt" alt="plot of chunk prediction-map-heterobasidion-brt" width="100%" style="display: block; margin: auto;" />

### RF


```r
maps_rf[[2]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-rf-1.png" title="plot of chunk prediction-map-heterobasidion-rf" alt="plot of chunk prediction-map-heterobasidion-rf" width="100%" style="display: block; margin: auto;" />

### SVM


```r
maps_svm[[2]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-svm-1.png" title="plot of chunk prediction-map-heterobasidion-svm" alt="plot of chunk prediction-map-heterobasidion-svm" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
maps_kknn[[2]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230706 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-knn-1.png" title="plot of chunk prediction-map-heterobasidion-knn" alt="plot of chunk prediction-map-heterobasidion-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```r
NA
```

```
## [1] NA
```


## Diplodia

### GAM


```r
maps_gam_diplodia
```

```
## $diplodia
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-gam-1.png" title="plot of chunk prediction-map-diplodia-gam" alt="plot of chunk prediction-map-diplodia-gam" width="100%" style="display: block; margin: auto;" />

### GLM


```r
maps_glm_diplodia
```

```
## Error in eval(expr, envir, enclos): object 'maps_glm_diplodia' not found
```

### BRT


```r
maps_brt[[3]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-brt-1.png" title="plot of chunk prediction-map-diplodia-brt" alt="plot of chunk prediction-map-diplodia-brt" width="100%" style="display: block; margin: auto;" />

### RF


```r
maps_rf[[3]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-rf-1.png" title="plot of chunk prediction-map-diplodia-rf" alt="plot of chunk prediction-map-diplodia-rf" width="100%" style="display: block; margin: auto;" />

### SVM


```r
maps_svm[[3]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-svm-1.png" title="plot of chunk prediction-map-diplodia-svm" alt="plot of chunk prediction-map-diplodia-svm" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
maps_kknn[[3]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-knn-1.png" title="plot of chunk prediction-map-diplodia-knn" alt="plot of chunk prediction-map-diplodia-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```r
NA
```

```
## [1] NA
```

## Fusarium

### GAM


```r
maps_gam_fusarium
```

```
## $fusarium
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-gam-1.png" title="plot of chunk prediction-map-fusarium-gam" alt="plot of chunk prediction-map-fusarium-gam" width="100%" style="display: block; margin: auto;" />

### GLM


```r
maps_glm_fusarium
```

```
## Error in eval(expr, envir, enclos): object 'maps_glm_fusarium' not found
```

### BRT


```r
maps_brt[[4]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-brt-1.png" title="plot of chunk prediction-map-fusarium-brt" alt="plot of chunk prediction-map-fusarium-brt" width="100%" style="display: block; margin: auto;" />

### RF


```r
maps_rf[[4]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-rf-1.png" title="plot of chunk prediction-map-fusarium-rf" alt="plot of chunk prediction-map-fusarium-rf" width="100%" style="display: block; margin: auto;" />

### SVM


```r
maps_svm[[4]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230705 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-svm-1.png" title="plot of chunk prediction-map-fusarium-svm" alt="plot of chunk prediction-map-fusarium-svm" width="100%" style="display: block; margin: auto;" />

### KKNN


```r
maps_kknn[[4]]
```

```
## Zoom: 8
```

```
## Warning: Removed 230706 rows containing missing values (geom_raster).
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-knn-1.png" title="plot of chunk prediction-map-fusarium-knn" alt="plot of chunk prediction-map-fusarium-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```r
NA
```

```
## [1] NA
```
