---
title: "Evaluating classifiers on pathogens"
output: html_notebook
author: "Patrick Schratz, FSU Jena"
---

This report evaluates the performance of the algorithms 

* _Boosted Regression Trees_ (BRT), 
* _Random Forest_ (RF), 
* _Support Vector Machine_ (SVM) 
* _Extreme Gradient Boosting_ (xgboost) 
* _Generalized Linear Model_ (GLM) 
* _Generalized Additive Model_ (GAM) 

on four different pathogens:

- _Armillaria mellea_
- _Diplodia sapinea_
- _Fusarium mellea_
- _Heterobasidion mellea_



# Resampling strategies {.tabset .tabset-fade}

## Spatial-Spatial


```r
bm_sp_sp_all %>%
  getBMRAggrPerformances(as.df = TRUE) %>% 
  arrange(task.id, desc(brier.test.mean))
```

```
##           task.id           learner.id brier.test.mean timetrain.test.mean
## 1      armillaria    classif.gam.tuned       0.3038929            145.6856
## 2      armillaria   classif.kknn.tuned       0.2969674            189.7474
## 3      armillaria    classif.gbm.tuned       0.2563035           6888.9986
## 4      armillaria    classif.svm.tuned       0.2560318           1345.0041
## 5      armillaria classif.ranger.tuned       0.2412010           1182.8924
## 6        diplodia   classif.kknn.tuned       0.1926498            194.8018
## 7        diplodia    classif.svm.tuned       0.1893523           1099.2276
## 8        diplodia    classif.gbm.tuned       0.1865641           7741.5988
## 9        diplodia classif.ranger.tuned       0.1684367           1119.2085
## 10       diplodia    classif.gam.tuned       0.1461461           2238.4151
## 11       fusarium    classif.gbm.tuned       0.1604329           9731.5089
## 12       fusarium   classif.kknn.tuned       0.1344326            235.0002
## 13       fusarium    classif.svm.tuned       0.1253279           1214.5147
## 14       fusarium classif.ranger.tuned       0.1179570           1068.5116
## 15       fusarium    classif.gam.tuned       0.1016272           2905.7360
## 16 heterobasidion    classif.gam.tuned       0.2252331            155.3237
## 17 heterobasidion   classif.kknn.tuned       0.2075295            188.5293
## 18 heterobasidion    classif.gbm.tuned       0.1874179           7678.8998
## 19 heterobasidion    classif.svm.tuned       0.1860947           1291.9247
## 20 heterobasidion classif.ranger.tuned       0.1746158           1010.2954
```

### Visualize


```r
plt = plotBMRBoxplots(bm_sp_sp_all, measure = brier, pretty.names = FALSE, 
                      order.lrn = c("classif.ranger.tuned", "classif.svm.tuned", "classif.kknn.tuned",
                                    "classif.gbm.tuned" , "classif.gam.tuned")) +
  #order.lrn = getBMRLearnerIds(bm_sp_sp_all_reduced)) + # gam again duplicated -.-
  aes(color = learner.id) +
  geom_boxplot(width = 0.6, outlier.size = 0.3, outlier.shape = 19) +
  scale_colour_nejm() +
  labs(y = "Brier score", x = "") + 
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()

levels(plt$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GAM")

#plt + ylab("Performance")
plt
```

![plot of chunk benchmark-eval-3](figure/benchmark-eval-3-1.png)

### Aggregated performances


```r
plt2 = plotBMRSummary(bm_sp_sp_all, pretty.names = FALSE) + 
  scale_colour_nejm() +
  theme_pubr()

levels(plt2$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
levels(plt2$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GAM")

plt2
```

![plot of chunk benchmark-eval-4](figure/benchmark-eval-4-1.png)

### Calculating and visualizing ranks


```r
plt3 = plotBMRRanksAsBarChart(bm_sp_sp_all, pos = "tile", 
                              pretty.names = FALSE,
                              order.lrn = c("classif.ranger.tuned", "classif.svm.tuned", "classif.kknn.tuned",
                                            "classif.gbm.tuned" , "classif.gam.tuned")) +
  scale_fill_nejm() +
  theme_pubr()

levels(plt3$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
levels(plt3$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GAM")

plt3
```

![plot of chunk benchmark-eval-6](figure/benchmark-eval-6-1.png)

## Spatial-Non-Spatial

## Non-Spatial-Non-Spatial

## Non-Spatial-No Tuning

## Spatial-No Tuning
