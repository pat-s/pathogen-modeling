---
title: "Evaluating classifiers on Diplodia Sapinea data"
output: html_document
author: "Patrick Schratz, FSU Jena"
---

This report evaluates the performance of the algorithms 

* _Boosted Regression Trees_ (BRT), 
* _Random Forest_ (RF), 
* _Support Vector Machine_ (SVM) 
* _Extreme Gradient Boosting_ (xgboost) 
* _Generalized Linear Model_ (GLM) 
* _Generalized Additive Model_ (GAM) 
* _k-Nearest Neighbor_ (KNN)

on four different pathogens:

- _Armillaria mellea_
- _Diplodia sapinea_
- _Fusarium mellea_
- _Heterobasidion mellea_



Models that did not converge:

- Armillaria: XGBOOST (sp/sp)
- Armillaria: GAM     (sp/sp)

# Resampling strategies {.tabset .tabset-fade}

## Spatial-Spatial


```r
bm_all_pathogens_sp_sp %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id            learner.id brier.test.mean
## 1        diplodia classif.xgboost.tuned       0.2223977
## 2        diplodia     classif.gam.tuned       0.2118220
## 3        diplodia     classif.svm.tuned       0.1972381
## 4        diplodia    classif.kknn.tuned       0.1956182
## 5        diplodia     classif.gbm.tuned       0.1780292
## 6        diplodia  classif.ranger.tuned       0.1650495
## 7        fusarium classif.xgboost.tuned       0.1930103
## 8        fusarium    classif.kknn.tuned       0.1573031
## 9        fusarium     classif.svm.tuned       0.1426939
## 10       fusarium     classif.gam.tuned       0.1373138
## 11       fusarium     classif.gbm.tuned       0.1354728
## 12       fusarium  classif.ranger.tuned       0.1283875
## 13 heterobasidion     classif.gam.tuned       0.2157003
## 14 heterobasidion    classif.kknn.tuned       0.2119746
## 15 heterobasidion classif.xgboost.tuned       0.2118857
## 16 heterobasidion     classif.svm.tuned       0.1908778
## 17 heterobasidion     classif.gbm.tuned       0.1828938
## 18 heterobasidion  classif.ranger.tuned       0.1657267
##    timetrain.test.mean
## 1            928.52180
## 2            170.01416
## 3            113.22662
## 4             90.70678
## 5            925.19630
## 6            150.69493
## 7            718.34417
## 8            108.11546
## 9            100.13127
## 10           180.05010
## 11          1236.72109
## 12           198.59888
## 13           161.43181
## 14            88.70464
## 15           822.48470
## 16           135.53046
## 17          1000.97538
## 18           140.02765
```

### Visualize


```r
plt = plotBMRBoxplots(bm_all_pathogens_sp_sp, measure = brier, pretty.names = F, 
                      order.lrn = c("classif.gam.tuned", "classif.kknn.tuned",
                                    "classif.ranger.tuned",
                                    "classif.svm.tuned" , "classif.gbm.tuned",
                                    "classif.xgboost.tuned")) +
  #order.lrn = getBMRLearnerIds(bm_all_pathogens_sp_sp)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

#levels(plt$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-3-1.png" title="plot of chunk benchmark-eval-all-3" alt="plot of chunk benchmark-eval-all-3" width="100%" style="display: block; margin: auto;" />

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_all_pathogens_sp_sp, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

#levels(plt2$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt2
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-4-1.png" title="plot of chunk benchmark-eval-all-4" alt="plot of chunk benchmark-eval-all-4" width="100%" style="display: block; margin: auto;" />

## Spatial-Non-Spatial


```r
bm_all_pathogens_sp_nsp %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id            learner.id brier.test.mean
## 1      armillaria    classif.kknn.tuned       0.3270912
## 2      armillaria     classif.gam.tuned       0.3227247
## 3      armillaria     classif.gbm.tuned       0.2915257
## 4      armillaria classif.xgboost.tuned       0.2482235
## 5      armillaria     classif.svm.tuned       0.2414270
## 6      armillaria  classif.ranger.tuned       0.2395426
## 7        diplodia     classif.svm.tuned       0.2239936
## 8        diplodia classif.xgboost.tuned       0.2176628
## 9        diplodia     classif.gam.tuned       0.2126723
## 10       diplodia    classif.kknn.tuned       0.1949616
## 11       diplodia     classif.gbm.tuned       0.1926850
## 12       diplodia  classif.ranger.tuned       0.1607841
## 13       fusarium classif.xgboost.tuned       0.1918548
## 14       fusarium    classif.kknn.tuned       0.1611429
## 15       fusarium     classif.svm.tuned       0.1442020
## 16       fusarium     classif.gam.tuned       0.1381429
## 17       fusarium     classif.gbm.tuned       0.1278374
## 18       fusarium  classif.ranger.tuned       0.1169586
## 19 heterobasidion    classif.kknn.tuned       0.2264248
## 20 heterobasidion     classif.gam.tuned       0.2251266
## 21 heterobasidion classif.xgboost.tuned       0.2095635
## 22 heterobasidion     classif.gbm.tuned       0.1899308
## 23 heterobasidion     classif.svm.tuned       0.1793335
## 24 heterobasidion  classif.ranger.tuned       0.1599481
##    timetrain.test.mean
## 1             88.16312
## 2            153.28864
## 3           2158.87684
## 4           1119.66581
## 5            151.55299
## 6            356.71093
## 7            195.40948
## 8           1025.46221
## 9            173.69348
## 10            92.64619
## 11          1428.34169
## 12           213.12914
## 13           746.44306
## 14            90.48085
## 15           108.29220
## 16           174.80830
## 17          1539.47942
## 18           155.34350
## 19            88.07733
## 20           160.52849
## 21           898.70975
## 22          1639.24550
## 23           137.50787
## 24           180.92813
```

### Visualize


```r
plt = plotBMRBoxplots(bm_all_pathogens_sp_nsp, measure = brier, pretty.names = F, 
                      order.lrn = c("classif.gam.tuned", "classif.kknn.tuned",
                                    "classif.ranger.tuned",
                                    "classif.svm.tuned" , "classif.gbm.tuned",
                                    "classif.xgboost.tuned")) +
  #order.lrn = getBMRLearnerIds(bm_all_pathogens_sp_sp)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

#levels(plt$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-6-1.png" title="plot of chunk benchmark-eval-all-6" alt="plot of chunk benchmark-eval-all-6" width="100%" style="display: block; margin: auto;" />

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_all_pathogens_sp_nsp, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

#levels(plt2$data$task.id) = c("Diplodia")
levels(plt2$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT")
```

```
## Error in `levels<-.factor`(`*tmp*`, value = c("GAM", "KNN", "RF", "SVM", : number of levels differs
```

```r
plt2
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-7-1.png" title="plot of chunk benchmark-eval-all-7" alt="plot of chunk benchmark-eval-all-7" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-Non-Spatial


```r
bm_all_pathogens_nsp_nsp %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id            learner.id brier.test.mean
## 1      armillaria     classif.gam.tuned      0.22470562
## 2      armillaria classif.xgboost.tuned      0.19988354
## 3      armillaria    classif.kknn.tuned      0.13476405
## 4      armillaria     classif.svm.tuned      0.13034958
## 5      armillaria     classif.gbm.tuned      0.11599695
## 6      armillaria  classif.ranger.tuned      0.10020974
## 7        diplodia classif.xgboost.tuned      0.19631575
## 8        diplodia     classif.gam.tuned      0.13828131
## 9        diplodia     classif.svm.tuned      0.12183801
## 10       diplodia    classif.kknn.tuned      0.11960121
## 11       diplodia     classif.gbm.tuned      0.09626146
## 12       diplodia  classif.ranger.tuned      0.08844688
## 13       fusarium classif.xgboost.tuned      0.17280562
## 14       fusarium     classif.gam.tuned      0.05773283
## 15       fusarium     classif.svm.tuned      0.05494349
## 16       fusarium    classif.kknn.tuned      0.05315145
## 17       fusarium     classif.gbm.tuned      0.02814927
## 18       fusarium  classif.ranger.tuned      0.02771418
## 19 heterobasidion classif.xgboost.tuned      0.17910151
## 20 heterobasidion     classif.gam.tuned      0.14369552
## 21 heterobasidion    classif.kknn.tuned      0.07001242
## 22 heterobasidion     classif.svm.tuned      0.06608569
## 23 heterobasidion     classif.gbm.tuned      0.04366813
## 24 heterobasidion  classif.ranger.tuned      0.03974149
##    timetrain.test.mean
## 1            153.71260
## 2           1140.98963
## 3            106.51399
## 4            247.97309
## 5           2110.47253
## 6            367.15325
## 7           1047.84021
## 8            173.88212
## 9            201.08392
## 10            92.65495
## 11          1279.78120
## 12           219.48629
## 13           766.93503
## 14           174.18844
## 15            98.38249
## 16            90.71743
## 17          1562.60230
## 18           158.55614
## 19           920.45337
## 20           156.96366
## 21            87.76763
## 22           141.65380
## 23          1683.62186
## 24           187.54481
```

### Visualize


```r
plt = plotBMRBoxplots(bm_all_pathogens_nsp_nsp, measure = brier, pretty.names = F, 
                      order.lrn = c("classif.gam.tuned", "classif.kknn.tuned",
                                    "classif.ranger.tuned",
                                    "classif.svm.tuned" , "classif.gbm.tuned",
                                    "classif.xgboost.tuned")) +
  #order.lrn = getBMRLearnerIds(bm_all_pathogens_sp_sp)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

#levels(plt$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-9-1.png" title="plot of chunk benchmark-eval-all-9" alt="plot of chunk benchmark-eval-all-9" width="100%" style="display: block; margin: auto;" />

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_all_pathogens_nsp_nsp, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

#levels(plt2$data$task.id) = c("Diplodia")
levels(plt2$data$learner.id) = c("GAM", "KNN", "RF", "SVM", "BRT")
```

```
## Error in `levels<-.factor`(`*tmp*`, value = c("GAM", "KNN", "RF", "SVM", : number of levels differs
```

```r
plt2
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-10-1.png" title="plot of chunk benchmark-eval-all-10" alt="plot of chunk benchmark-eval-all-10" width="100%" style="display: block; margin: auto;" />

## Non-Spatial-No Tuning


```r
bm_all_pathogens_nsp_non %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id       learner.id brier.test.mean timetrain.test.mean
## 1      armillaria classif.binomial      0.23292974            0.020256
## 2      armillaria  classif.xgboost      0.18963637            1.295902
## 3      armillaria      classif.gbm      0.16629378            0.047480
## 4      armillaria      classif.gam      0.14250881            0.459406
## 5      armillaria     classif.kknn      0.14164183            0.000592
## 6      armillaria      classif.svm      0.13997486            0.223002
## 7      armillaria   classif.ranger      0.10422809            0.377004
## 8        diplodia  classif.xgboost      0.17769629            1.212052
## 9        diplodia      classif.svm      0.15953720            0.251526
## 10       diplodia      classif.gam      0.13784101            0.268174
## 11       diplodia classif.binomial      0.11916360            0.020952
## 12       diplodia     classif.kknn      0.11893981            0.000590
## 13       diplodia      classif.gbm      0.10556276            0.049274
## 14       diplodia   classif.ranger      0.09234835            0.278520
## 15       fusarium  classif.xgboost      0.14439302            0.085006
## 16       fusarium      classif.gam      0.07716688            0.335502
## 17       fusarium      classif.svm      0.07454755            0.236698
## 18       fusarium     classif.kknn      0.05459185            0.000494
## 19       fusarium classif.binomial      0.04893514            0.023832
## 20       fusarium      classif.gbm      0.03621696            0.049196
## 21       fusarium   classif.ranger      0.02984426            0.166570
## 22 heterobasidion classif.binomial      0.16126069            0.021696
## 23 heterobasidion  classif.xgboost      0.15635915            0.362416
## 24 heterobasidion      classif.gam      0.09450596            0.375880
## 25 heterobasidion      classif.gbm      0.07987779            0.045124
## 26 heterobasidion     classif.kknn      0.07047565            0.000500
## 27 heterobasidion      classif.svm      0.06895227            0.177100
## 28 heterobasidion   classif.ranger      0.04366729            0.205496
```

### Visualize


```r
plt = plotBMRBoxplots(bm_all_pathogens_nsp_non, measure = brier, pretty.names = F, 
                      order.lrn = c("classif.gam", "classif.binomial",
                                    "classif.kknn",
                                    "classif.ranger",
                                    "classif.svm", "classif.gbm",
                                    "classif.xgboost")) +
  #order.lrn = getBMRLearnerIds(bm_all_pathogens_sp_sp)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

#levels(plt$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "GLM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-12-1.png" title="plot of chunk benchmark-eval-all-12" alt="plot of chunk benchmark-eval-all-12" width="100%" style="display: block; margin: auto;" />

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_all_pathogens_nsp_non, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

#levels(plt2$data$task.id) = c("Diplodia")
levels(plt2$data$learner.id) = c("GAM", "GLM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt2
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-13-1.png" title="plot of chunk benchmark-eval-all-13" alt="plot of chunk benchmark-eval-all-13" width="100%" style="display: block; margin: auto;" />

## Spatial-No Tuning


```r
bm_all_pathogens_sp_non %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id       learner.id brier.test.mean timetrain.test.mean
## 1      armillaria      classif.gam       0.3153256            0.418764
## 2      armillaria     classif.kknn       0.3050645            0.000636
## 3      armillaria classif.binomial       0.2935126            0.022772
## 4      armillaria      classif.gbm       0.2807682            0.048160
## 5      armillaria      classif.svm       0.2510060            0.219146
## 6      armillaria  classif.xgboost       0.2443365            1.269788
## 7      armillaria   classif.ranger       0.2381671            0.367380
## 8        diplodia      classif.gam       0.2372448            0.251176
## 9        diplodia  classif.xgboost       0.2069464            1.237910
## 10       diplodia      classif.svm       0.2008383            0.250330
## 11       diplodia classif.binomial       0.1959824            0.035560
## 12       diplodia      classif.gbm       0.1776288            0.048726
## 13       diplodia     classif.kknn       0.1732633            0.000520
## 14       diplodia   classif.ranger       0.1588658            0.275670
## 15       fusarium  classif.xgboost       0.1718123            0.091642
## 16       fusarium      classif.svm       0.1564700            0.228022
## 17       fusarium     classif.kknn       0.1341897            0.000498
## 18       fusarium      classif.gam       0.1287344            0.337176
## 19       fusarium      classif.gbm       0.1181421            0.050476
## 20       fusarium   classif.ranger       0.1167445            0.158228
## 21       fusarium classif.binomial       0.1028080            0.043806
## 22 heterobasidion      classif.gam       0.2741802            0.404308
## 23 heterobasidion     classif.kknn       0.2123064            0.000522
## 24 heterobasidion classif.binomial       0.2027726            0.018896
## 25 heterobasidion  classif.xgboost       0.1981751            0.285728
## 26 heterobasidion      classif.svm       0.1826196            0.170438
## 27 heterobasidion      classif.gbm       0.1805687            0.045606
## 28 heterobasidion   classif.ranger       0.1593167            0.191722
```

### Visualize


```r
plt = plotBMRBoxplots(bm_all_pathogens_sp_non, measure = brier, pretty.names = F, 
                      order.lrn = c("classif.gam", "classif.binomial",
                                    "classif.kknn",
                                    "classif.ranger",
                                    "classif.svm", "classif.gbm",
                                    "classif.xgboost"))  +
  #order.lrn = getBMRLearnerIds(bm_all_pathogens_sp_sp)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

#levels(plt$data$task.id) = c("Diplodia")
levels(plt$data$learner.id) = c("GAM", "GLM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-15-1.png" title="plot of chunk benchmark-eval-all-15" alt="plot of chunk benchmark-eval-all-15" width="100%" style="display: block; margin: auto;" />

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_all_pathogens_sp_non, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

# levels(plt2$data$task.id) = c("Diplodia")
levels(plt2$data$learner.id) = c("GAM", "GLM", "KNN", "RF", "SVM", "BRT", "XGBOOST")

plt2
```

<img src="../../analysis/paper/submission/3/appendices/benchmark-eval-all-16-1.png" title="plot of chunk benchmark-eval-all-16" alt="plot of chunk benchmark-eval-all-16" width="100%" style="display: block; margin: auto;" />
