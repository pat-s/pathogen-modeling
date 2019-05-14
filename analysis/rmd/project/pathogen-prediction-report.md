---
title: "Prediction maps of pathogens from various algorithms"
output: 
  html_document: 
    css: style.css
    theme: readable
    number_sections: yes
    toc: yes
    toc_float: true
    toc_collapsed: true
    df_print: tibble
    includes:
      in_header: header.html
author: "Patrick Schratz, Friedrich-Schiller-University Jena"
---



# Introduction

This document shows the prediction maps for the possible infection risk of trees in the Basque Country by the following pathogens:

- _Armillaria mellea_
- _Diplodia sapinea_
- _Fusarium circinatum_
- _Heterobasidion annosum_

The following algorithms were used to create the predictions:

- Boosted Regression Trees (BRT)
- Generalized Additive Model (GAM)
- Generalized Linear Model (GLM)
- k-Nearest Neighbor (KNN)
- Random Forests (RF)
- Support Vector Machine (SVM)
- Extreme Gradient Boosting (XGBOOST)

The following "algorithm-pathogen-resampling" settings did not return a performance result during performance evaluation.
Due to the missing performance result for these combinations no prediction maps were created.

<table class="table table-striped table-hover table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:center;"> Pathogen </th>
   <th style="text-align:center;"> Algorithm </th>
   <th style="text-align:center;"> Resampling </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> Armillaria </td>
   <td style="text-align:center;"> XGBOOST </td>
   <td style="text-align:center;"> spatial/spatial </td>
  </tr>
  <tr>
   <td style="text-align:center;"> Armillaria </td>
   <td style="text-align:center;"> GAM </td>
   <td style="text-align:center;"> spatial/spatial </td>
  </tr>
</tbody>
</table>

Unfortunately, XGBOOST cannot handle new factor levels in prediction data.
Since we predict to the whole Basque Country using environment variables, this case occurs quite often. 
Variables like "soil type" and "lithology type" inherit instances which only occur in some parts of the prediction area but not within the training data.
Therefore, it was not possible to create prediction maps for XGBOOST.

# Prediction Maps {.tabset .tabset-fade}

## Armillaria mellea

### GAM


```
## [1] NA
```

### GLM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-glm -1.png" title="plot of chunk prediction-map-armillaria-glm " alt="plot of chunk prediction-map-armillaria-glm " width="100%" style="display: block; margin: auto;" />

### BRT

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-brt-1.png" title="plot of chunk prediction-map-armillaria-brt" alt="plot of chunk prediction-map-armillaria-brt" width="100%" style="display: block; margin: auto;" />

### RF

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-rf-1.png" title="plot of chunk prediction-map-armillaria-rf" alt="plot of chunk prediction-map-armillaria-rf" width="100%" style="display: block; margin: auto;" />

### SVM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-svm-1.png" title="plot of chunk prediction-map-armillaria-svm" alt="plot of chunk prediction-map-armillaria-svm" width="100%" style="display: block; margin: auto;" />

### KNN

<img src="../../analysis/paper/submission/3/appendices/prediction-map-armillaria-knn-1.png" title="plot of chunk prediction-map-armillaria-knn" alt="plot of chunk prediction-map-armillaria-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```
## [1] NA
```

## Heterobasidion annosum

### GAM


```
## $heterobasidion
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-gam-1.png" title="plot of chunk prediction-map-heterobasidion-gam" alt="plot of chunk prediction-map-heterobasidion-gam" width="100%" style="display: block; margin: auto;" />

### GLM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-glm-1.png" title="plot of chunk prediction-map-heterobasidion-glm" alt="plot of chunk prediction-map-heterobasidion-glm" width="100%" style="display: block; margin: auto;" />

### BRT

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-brt-1.png" title="plot of chunk prediction-map-heterobasidion-brt" alt="plot of chunk prediction-map-heterobasidion-brt" width="100%" style="display: block; margin: auto;" />

### RF

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-rf-1.png" title="plot of chunk prediction-map-heterobasidion-rf" alt="plot of chunk prediction-map-heterobasidion-rf" width="100%" style="display: block; margin: auto;" />

### SVM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-svm-1.png" title="plot of chunk prediction-map-heterobasidion-svm" alt="plot of chunk prediction-map-heterobasidion-svm" width="100%" style="display: block; margin: auto;" />

### KNN

<img src="../../analysis/paper/submission/3/appendices/prediction-map-heterobasidion-knn-1.png" title="plot of chunk prediction-map-heterobasidion-knn" alt="plot of chunk prediction-map-heterobasidion-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```
## [1] NA
```


## Diplodia sapinea

### GAM


```
## $diplodia
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-gam-1.png" title="plot of chunk prediction-map-diplodia-gam" alt="plot of chunk prediction-map-diplodia-gam" width="100%" style="display: block; margin: auto;" />

### GLM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-glm-1.png" title="plot of chunk prediction-map-diplodia-glm" alt="plot of chunk prediction-map-diplodia-glm" width="100%" style="display: block; margin: auto;" />

### BRT

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-brt-1.png" title="plot of chunk prediction-map-diplodia-brt" alt="plot of chunk prediction-map-diplodia-brt" width="100%" style="display: block; margin: auto;" />

### RF

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-rf-1.png" title="plot of chunk prediction-map-diplodia-rf" alt="plot of chunk prediction-map-diplodia-rf" width="100%" style="display: block; margin: auto;" />

### SVM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-svm-1.png" title="plot of chunk prediction-map-diplodia-svm" alt="plot of chunk prediction-map-diplodia-svm" width="100%" style="display: block; margin: auto;" />

### KNN

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-knn-1.png" title="plot of chunk prediction-map-diplodia-knn" alt="plot of chunk prediction-map-diplodia-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```
## [1] NA
```

### Debugging

No Temperature

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-temp-1.png" title="plot of chunk prediction-map-diplodia-no-temp" alt="plot of chunk prediction-map-diplodia-no-temp" width="100%" style="display: block; margin: auto;" />

No Precipitation

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-precip-1.png" title="plot of chunk prediction-map-diplodia-no-precip" alt="plot of chunk prediction-map-diplodia-no-precip" width="100%" style="display: block; margin: auto;" />

No hail

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-hail-1.png" title="plot of chunk prediction-map-diplodia-no-hail" alt="plot of chunk prediction-map-diplodia-no-hail" width="100%" style="display: block; margin: auto;" />

No ph

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-ph-1.png" title="plot of chunk prediction-map-diplodia-no-ph" alt="plot of chunk prediction-map-diplodia-no-ph" width="100%" style="display: block; margin: auto;" />

No soil

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-soil-1.png" title="plot of chunk prediction-map-diplodia-no-soil" alt="plot of chunk prediction-map-diplodia-no-soil" width="100%" style="display: block; margin: auto;" />

No lithology

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-lithology-1.png" title="plot of chunk prediction-map-diplodia-no-lithology" alt="plot of chunk prediction-map-diplodia-no-lithology" width="100%" style="display: block; margin: auto;" />

No slope

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-slope-1.png" title="plot of chunk prediction-map-diplodia-no-slope" alt="plot of chunk prediction-map-diplodia-no-slope" width="100%" style="display: block; margin: auto;" />

No pisr

<img src="../../analysis/paper/submission/3/appendices/prediction-map-diplodia-no-pisr-1.png" title="plot of chunk prediction-map-diplodia-no-pisr" alt="plot of chunk prediction-map-diplodia-no-pisr" width="100%" style="display: block; margin: auto;" />

## Fusarium circinatum

### GAM


```
## $fusarium
```

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-gam-1.png" title="plot of chunk prediction-map-fusarium-gam" alt="plot of chunk prediction-map-fusarium-gam" width="100%" style="display: block; margin: auto;" />

### GLM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-glm-1.png" title="plot of chunk prediction-map-fusarium-glm" alt="plot of chunk prediction-map-fusarium-glm" width="100%" style="display: block; margin: auto;" />

### BRT

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-brt-1.png" title="plot of chunk prediction-map-fusarium-brt" alt="plot of chunk prediction-map-fusarium-brt" width="100%" style="display: block; margin: auto;" />

### RF

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-rf-1.png" title="plot of chunk prediction-map-fusarium-rf" alt="plot of chunk prediction-map-fusarium-rf" width="100%" style="display: block; margin: auto;" />

### SVM

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-svm-1.png" title="plot of chunk prediction-map-fusarium-svm" alt="plot of chunk prediction-map-fusarium-svm" width="100%" style="display: block; margin: auto;" />

### KNN

<img src="../../analysis/paper/submission/3/appendices/prediction-map-fusarium-knn-1.png" title="plot of chunk prediction-map-fusarium-knn" alt="plot of chunk prediction-map-fusarium-knn" width="100%" style="display: block; margin: auto;" />

### XGBOOST


```
## [1] NA
```
