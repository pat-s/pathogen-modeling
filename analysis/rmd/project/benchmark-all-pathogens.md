---
title: "Evaluating classifier performance on pathogens"
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
author: "Patrick Schratz, Friedrich-Schiller-University Jena"
bibliography: ../bibliography.bib
link-citations: yes
---



# Introduction

This document shows the predictive performances for the possible infection risk of trees in the Basque Country by the following pathogens:

- _Armillaria mellea_
- _Diplodia sapinea_
- _Fusarium circinatum_
- _Heterobasidion annosum_

The following algorithms were benchmarked:

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

Due to two missing results for the pathogen _Armillaria mellea_, this pathogen could not be included in the plots comparing all pathogens against each other.

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

# Resampling strategies {.tabset .tabset-fade}

## Spatial-Spatial


```
##           task.id            learner.id brier.test.mean
## 1        diplodia classif.xgboost.tuned       0.2178637
## 2        diplodia     classif.svm.tuned       0.2000721
## 3        diplodia     classif.gam.tuned       0.1899124
## 4        diplodia    classif.kknn.tuned       0.1877918
## 5        diplodia  classif.ranger.tuned       0.1594762
## 6        diplodia     classif.gbm.tuned       0.1590360
## 7        fusarium classif.xgboost.tuned       0.1922855
## 8        fusarium    classif.kknn.tuned       0.1515723
## 9        fusarium     classif.svm.tuned       0.1439149
## 10       fusarium     classif.gam.tuned       0.1283013
## 11       fusarium     classif.gbm.tuned       0.1277329
## 12       fusarium  classif.ranger.tuned       0.1225918
## 13 heterobasidion classif.xgboost.tuned       0.2129888
## 14 heterobasidion     classif.gam.tuned       0.1958724
## 15 heterobasidion     classif.svm.tuned       0.1943352
## 16 heterobasidion    classif.kknn.tuned       0.1928612
## 17 heterobasidion  classif.ranger.tuned       0.1685481
## 18 heterobasidion     classif.gbm.tuned       0.1664094
##    timetrain.test.mean
## 1            946.32196
## 2            149.20248
## 3            176.39624
## 4             95.99820
## 5            177.86819
## 6           1121.80053
## 7            733.95156
## 8             95.93280
## 9            120.55818
## 10           181.92803
## 11          1693.52777
## 12           164.99343
## 13           838.91396
## 14           162.28879
## 15           161.48656
## 16            93.12099
## 17           178.44129
## 18          1200.25454
```

### Boxplot comparison

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-3-1.png" title="plot of chunk benchmark-eval-all-3" alt="plot of chunk benchmark-eval-all-3" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-4-1.png" title="plot of chunk benchmark-eval-all-4" alt="plot of chunk benchmark-eval-all-4" width="100%" style="display: block; margin: auto;" />

## Spatial-Non-Spatial


```
##           task.id            learner.id brier.test.mean
## 1      armillaria     classif.gam.tuned       0.3013001
## 2      armillaria    classif.kknn.tuned       0.2939335
## 3      armillaria     classif.gbm.tuned       0.2935869
## 4      armillaria classif.xgboost.tuned       0.2487059
## 5      armillaria     classif.svm.tuned       0.2412515
## 6      armillaria  classif.ranger.tuned       0.2396800
## 7        diplodia classif.xgboost.tuned       0.2144304
## 8        diplodia     classif.svm.tuned       0.2125015
## 9        diplodia     classif.gam.tuned       0.1922458
## 10       diplodia    classif.kknn.tuned       0.1882630
## 11       diplodia     classif.gbm.tuned       0.1637896
## 12       diplodia  classif.ranger.tuned       0.1528584
## 13       fusarium classif.xgboost.tuned       0.1903816
## 14       fusarium    classif.kknn.tuned       0.1517528
## 15       fusarium     classif.svm.tuned       0.1441707
## 16       fusarium     classif.gam.tuned       0.1286404
## 17       fusarium     classif.gbm.tuned       0.1150637
## 18       fusarium  classif.ranger.tuned       0.1033548
## 19 heterobasidion classif.xgboost.tuned       0.2094289
## 20 heterobasidion     classif.gam.tuned       0.1945875
## 21 heterobasidion    classif.kknn.tuned       0.1888104
## 22 heterobasidion     classif.gbm.tuned       0.1853278
## 23 heterobasidion     classif.svm.tuned       0.1810352
## 24 heterobasidion  classif.ranger.tuned       0.1620154
##    timetrain.test.mean
## 1            155.49509
## 2             93.92069
## 3           1597.77275
## 4           1125.08578
## 5            178.60313
## 6            284.36938
## 7           1051.59241
## 8            224.75722
## 9            178.56731
## 10            97.78483
## 11          1287.93435
## 12           261.55123
## 13           759.92304
## 14            97.29542
## 15           131.12090
## 16           182.45493
## 17          1751.59618
## 18           190.07404
## 19           934.11537
## 20           161.58275
## 21            94.50761
## 22          1859.37079
## 23           166.40502
## 24           229.09685
```

### Boxplot comparison

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-6-1.png" title="plot of chunk benchmark-eval-all-6" alt="plot of chunk benchmark-eval-all-6" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-7-1.png" title="plot of chunk benchmark-eval-all-7" alt="plot of chunk benchmark-eval-all-7" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-Non-Spatial


```
##           task.id            learner.id brier.test.mean
## 1      armillaria     classif.gam.tuned      0.22700637
## 2      armillaria classif.xgboost.tuned      0.20195496
## 3      armillaria    classif.kknn.tuned      0.13283583
## 4      armillaria     classif.svm.tuned      0.13054167
## 5      armillaria     classif.gbm.tuned      0.12190209
## 6      armillaria  classif.ranger.tuned      0.10428849
## 7        diplodia classif.xgboost.tuned      0.19924264
## 8        diplodia     classif.gam.tuned      0.13952038
## 9        diplodia     classif.svm.tuned      0.12296446
## 10       diplodia    classif.kknn.tuned      0.12013106
## 11       diplodia     classif.gbm.tuned      0.11186382
## 12       diplodia  classif.ranger.tuned      0.09952600
## 13       fusarium classif.xgboost.tuned      0.17346649
## 14       fusarium     classif.gam.tuned      0.06053425
## 15       fusarium     classif.svm.tuned      0.05512555
## 16       fusarium    classif.kknn.tuned      0.05227486
## 17       fusarium     classif.gbm.tuned      0.03002464
## 18       fusarium  classif.ranger.tuned      0.02947792
## 19 heterobasidion classif.xgboost.tuned      0.18180963
## 20 heterobasidion     classif.gam.tuned      0.14701701
## 21 heterobasidion    classif.kknn.tuned      0.06937628
## 22 heterobasidion     classif.svm.tuned      0.06687576
## 23 heterobasidion     classif.gbm.tuned      0.05104793
## 24 heterobasidion  classif.ranger.tuned      0.04547533
##    timetrain.test.mean
## 1            156.56865
## 2           1140.15437
## 3             94.41191
## 4            182.55720
## 5           1587.09585
## 6            294.32183
## 7           1073.32469
## 8            178.02053
## 9            237.76647
## 10            97.41498
## 11          1238.94289
## 12           263.59719
## 13           783.31661
## 14           181.80679
## 15           120.05680
## 16            99.77238
## 17          1721.67371
## 18           192.82796
## 19           947.41109
## 20           163.14737
## 21            94.01888
## 22           171.49971
## 23          1841.98859
## 24           239.77227
```

### Boxplot comparison

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-9-1.png" title="plot of chunk benchmark-eval-all-9" alt="plot of chunk benchmark-eval-all-9" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-10-1.png" title="plot of chunk benchmark-eval-all-10" alt="plot of chunk benchmark-eval-all-10" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-No Tuning


```
##           task.id       learner.id brier.test.mean timetrain.test.mean
## 1      armillaria classif.binomial      0.23430477            0.020556
## 2      armillaria  classif.xgboost      0.19308152            0.492520
## 3      armillaria      classif.gbm      0.17435081            0.046698
## 4      armillaria      classif.gam      0.16339620            0.344802
## 5      armillaria     classif.kknn      0.14319871            0.000606
## 6      armillaria      classif.svm      0.14008004            0.199052
## 7      armillaria   classif.ranger      0.10934871            0.287948
## 8        diplodia  classif.xgboost      0.18104208            0.579908
## 9        diplodia      classif.svm      0.16032300            0.246286
## 10       diplodia      classif.gam      0.14672641            0.395882
## 11       diplodia     classif.kknn      0.11956687            0.000578
## 12       diplodia classif.binomial      0.11861260            0.019850
## 13       diplodia      classif.gbm      0.11375122            0.050644
## 14       diplodia   classif.ranger      0.10170460            0.261038
## 15       fusarium  classif.xgboost      0.14483346            0.171418
## 16       fusarium      classif.svm      0.07603583            0.262310
## 17       fusarium      classif.gam      0.07261828            0.520834
## 18       fusarium     classif.kknn      0.05268736            0.001084
## 19       fusarium classif.binomial      0.04841708            0.032960
## 20       fusarium      classif.gbm      0.03622046            0.073710
## 21       fusarium   classif.ranger      0.03103918            0.199382
## 22 heterobasidion classif.binomial      0.16290012            0.026578
## 23 heterobasidion  classif.xgboost      0.16076201            0.227860
## 24 heterobasidion      classif.gbm      0.09434126            0.048094
## 25 heterobasidion      classif.gam      0.08696898            0.381824
## 26 heterobasidion     classif.kknn      0.07479138            0.000672
## 27 heterobasidion      classif.svm      0.06915348            0.189382
## 28 heterobasidion   classif.ranger      0.04976475            0.252730
```

### Boxplot comparison

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-12-1.png" title="plot of chunk benchmark-eval-all-12" alt="plot of chunk benchmark-eval-all-12" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-13-1.png" title="plot of chunk benchmark-eval-all-13" alt="plot of chunk benchmark-eval-all-13" width="100%" style="display: block; margin: auto;" />

## Spatial-No Tuning


```
##           task.id       learner.id brier.test.mean timetrain.test.mean
## 1      armillaria      classif.gam      0.34203122            0.291280
## 2      armillaria     classif.kknn      0.28773607            0.000554
## 3      armillaria classif.binomial      0.28400164            0.020448
## 4      armillaria      classif.gbm      0.27648700            0.045978
## 5      armillaria  classif.xgboost      0.25095005            0.504856
## 6      armillaria      classif.svm      0.25076442            0.192162
## 7      armillaria   classif.ranger      0.23791242            0.266582
## 8        diplodia      classif.gam      0.25052534            0.366116
## 9        diplodia      classif.svm      0.20094838            0.244696
## 10       diplodia  classif.xgboost      0.19986164            0.399858
## 11       diplodia classif.binomial      0.17030072            0.019524
## 12       diplodia     classif.kknn      0.16892370            0.000540
## 13       diplodia      classif.gbm      0.15981173            0.051166
## 14       diplodia   classif.ranger      0.14990091            0.259162
## 15       fusarium  classif.xgboost      0.17056495            0.171358
## 16       fusarium      classif.svm      0.15712093            0.253972
## 17       fusarium      classif.gam      0.13216430            0.516134
## 18       fusarium     classif.kknn      0.13069975            0.000852
## 19       fusarium      classif.gbm      0.10680714            0.074078
## 20       fusarium   classif.ranger      0.10410518            0.191088
## 21       fusarium classif.binomial      0.09171266            0.042224
## 22 heterobasidion      classif.gam      0.25236362            0.397666
## 23 heterobasidion classif.binomial      0.19785015            0.026464
## 24 heterobasidion  classif.xgboost      0.19305571            0.152206
## 25 heterobasidion      classif.gbm      0.18311438            0.050108
## 26 heterobasidion      classif.svm      0.18252532            0.187578
## 27 heterobasidion     classif.kknn      0.17918672            0.000610
## 28 heterobasidion   classif.ranger      0.16098088            0.240746
```

### Boxplot comparison


```
## Error: Cannot use `+.gg()` with a single argument. Did you accidentally put + on a new line?
```

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-15-1.png" title="plot of chunk benchmark-eval-all-15" alt="plot of chunk benchmark-eval-all-15" width="100%" style="display: block; margin: auto;" />

### Aggregated performances

<img src="../../../analysis/paper/submission/3/appendices/benchmark-eval-all-16-1.png" title="plot of chunk benchmark-eval-all-16" alt="plot of chunk benchmark-eval-all-16" width="100%" style="display: block; margin: auto;" />

# References
