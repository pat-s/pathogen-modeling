---
title: "Evaluating classifier performance on _Diplodia sapinea_"
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
bibliography: bibliography.bib
link-citations: yes
---



# Introduction

This document shows the predictive performances for the possible infection risk of trees in the Basque Country by the pathogen _Diplodia sapinea_.

The following algorithms were benchmarked:

- Boosted Regression Trees (BRT)
- Generalized Additive Model (GAM)
- Generalized Linear Model (GLM)
- k-Nearest Neighbor (KNN)
- Random Forests (RF)
- Support Vector Machine (SVM)
- Extreme Gradient Boosting (XGBOOST)

# Resampling Strategies

The abbreviations of the tabbed resampling strategies follow the scheme:

`<outer resampling> / <inner resampling>`

For example, setting "Spatial-Spatial" means that in both levels a "spatial cross-validation" (@Brenning2012) has been applied.

The inner resampling refers to the hyperparameter tuning level of the nested cross-validation that was applied.

# Results structure

The structure of the following results presentation is as follows:

- Table view of all performances for each resampling setting
- Boxplot comparison for each pathogen and algorithm
- Aggregated performances for each pathogen and algorithm

# Performance results {.tabset .tabset-fade}

## Spatial-Spatial


```
##    task.id           learner.id brier.test.mean timetrain.test.mean
## 1 diplodia    classif.gam.tuned       0.2118220            172.8907
## 2 diplodia    classif.svm.tuned       0.1972381            121.7302
## 3 diplodia   classif.kknn.tuned       0.1956182             89.7017
## 4 diplodia    classif.gbm.tuned       0.1780292            914.8390
## 5 diplodia classif.ranger.tuned       0.1650495            152.3016
```

### Boxplot comparison

<img src="figure/benchmark-eval-diplodia-3-1.png" title="plot of chunk benchmark-eval-diplodia-3" alt="plot of chunk benchmark-eval-diplodia-3" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="figure/benchmark-eval-diplodia-4-1.png" title="plot of chunk benchmark-eval-diplodia-4" alt="plot of chunk benchmark-eval-diplodia-4" width="100%" style="display: block; margin: auto;" />

## Spatial-Non-Spatial


```
##    task.id           learner.id brier.test.mean timetrain.test.mean
## 1 diplodia    classif.svm.tuned       0.2239936            193.1366
## 2 diplodia    classif.gam.tuned       0.2126723            166.7119
## 3 diplodia   classif.kknn.tuned       0.1949616             91.2443
## 4 diplodia    classif.gbm.tuned       0.1926850           1415.8899
## 5 diplodia classif.ranger.tuned       0.1607841            213.8969
```

### Boxplot comparison

<img src="figure/benchmark-eval-diplodia-6-1.png" title="plot of chunk benchmark-eval-diplodia-6" alt="plot of chunk benchmark-eval-diplodia-6" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="figure/benchmark-eval-diplodia-7-1.png" title="plot of chunk benchmark-eval-diplodia-7" alt="plot of chunk benchmark-eval-diplodia-7" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-Non-Spatial


```
##    task.id           learner.id brier.test.mean timetrain.test.mean
## 1 diplodia    classif.gam.tuned      0.13828131           168.40803
## 2 diplodia    classif.svm.tuned      0.12183801           198.81407
## 3 diplodia   classif.kknn.tuned      0.11960121            90.90356
## 4 diplodia    classif.gbm.tuned      0.09626146          1265.36845
## 5 diplodia classif.ranger.tuned      0.08844688           222.10920
```

### Boxplot comparison

<img src="figure/benchmark-eval-diplodia-9-1.png" title="plot of chunk benchmark-eval-diplodia-9" alt="plot of chunk benchmark-eval-diplodia-9" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="figure/benchmark-eval-diplodia-10-1.png" title="plot of chunk benchmark-eval-diplodia-10" alt="plot of chunk benchmark-eval-diplodia-10" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-No Tuning


```
##    task.id       learner.id brier.test.mean timetrain.test.mean
## 1 diplodia      classif.svm      0.15953720            0.247544
## 2 diplodia      classif.gam      0.13784101            0.248172
## 3 diplodia classif.binomial      0.11916360            0.021568
## 4 diplodia     classif.kknn      0.11893981            0.000880
## 5 diplodia      classif.gbm      0.10556276            0.051542
## 6 diplodia   classif.ranger      0.09234835            0.251736
```

### Boxplot comparison

<img src="figure/benchmark-eval-diplodia-12-1.png" title="plot of chunk benchmark-eval-diplodia-12" alt="plot of chunk benchmark-eval-diplodia-12" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="figure/benchmark-eval-diplodia-13-1.png" title="plot of chunk benchmark-eval-diplodia-13" alt="plot of chunk benchmark-eval-diplodia-13" width="100%" style="display: block; margin: auto;" />

## Spatial-No Tuning


```
##    task.id       learner.id brier.test.mean timetrain.test.mean
## 1 diplodia      classif.gam       0.2372448            0.248700
## 2 diplodia      classif.svm       0.2008383            0.240998
## 3 diplodia classif.binomial       0.1959824            0.019416
## 4 diplodia      classif.gbm       0.1776288            0.050382
## 5 diplodia     classif.kknn       0.1732633            0.000854
## 6 diplodia   classif.ranger       0.1588658            0.246136
```

### Boxplot comparison

<img src="figure/benchmark-eval-diplodia-15-1.png" title="plot of chunk benchmark-eval-diplodia-15" alt="plot of chunk benchmark-eval-diplodia-15" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="figure/benchmark-eval-diplodia-16-1.png" title="plot of chunk benchmark-eval-diplodia-16" alt="plot of chunk benchmark-eval-diplodia-16" width="100%" style="display: block; margin: auto;" />

# Boxplot comparison of all algorithm/tuning settings





<img src="../../analysis/paper/submission/3/latex-source-files/cv_boxplots_final_brier-1.png" title="plot of chunk cv_boxplots_final_brier" alt="plot of chunk cv_boxplots_final_brier" width="100%" style="display: block; margin: auto;" />

# References
