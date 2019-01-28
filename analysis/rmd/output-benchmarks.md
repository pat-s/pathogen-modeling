---
title: "Evaluating classifiers on pathogens"
#output: html_notebook
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



# Print benchmark results


```r
getBMRAggrPerformances(bm_sp_sp_all, as.df = TRUE) %>%
  arrange(task.id, desc(brier.test.mean))
```

```
## Error in checkClass(x, classes, ordered, null.ok): Objekt 'bm_sp_sp_all' nicht gefunden
```

# Visualize


```r
plt = plotBMRBoxplots(bmr_all, measure = brier, pretty.names = FALSE, 
  order.lrn = getBMRLearnerIds(bmr_all)) +
  # aes(color = learner.id) +
  # scale_color_viridis_d() +
  theme(strip.text.x = element_text(size = 8)) + 
  theme_pubr()
```

```
## Error in checkClass(x, classes, ordered, null.ok): Objekt 'bmr_all' nicht gefunden
```

```r
levels(plt$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
```

```
## Error in levels(plt$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", : Objekt 'plt' nicht gefunden
```

```r
levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", "GAM")
```

```
## Error in levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", : Objekt 'plt' nicht gefunden
```

```r
plt + ylab("Performance")
```

```
## Error in eval(expr, envir, enclos): Objekt 'plt' nicht gefunden
```

## Aggregated performances


```r
plt2 = plotBMRSummary(bmr_all) + 
  theme_pubr()
```

```
## Error in checkClass(x, classes, ordered, null.ok): Objekt 'bmr_all' nicht gefunden
```

```r
levels(plt2$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
```

```
## Error in levels(plt2$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", : Objekt 'plt2' nicht gefunden
```

```r
levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", "GAM")
```

```
## Error in levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", : Objekt 'plt' nicht gefunden
```

```r
plt2
```

```
## Error in eval(expr, envir, enclos): Objekt 'plt2' nicht gefunden
```

## Calculating and visualizing ranks


```r
m = convertBMRToRankMatrix(bmr_all, brier)
```

```
## Error in checkClass(x, classes, ordered, null.ok): Objekt 'bmr_all' nicht gefunden
```

```r
as_tibble(m)
```

```
## Error in as_tibble(m): Objekt 'm' nicht gefunden
```


```r
plt3 = plotBMRRanksAsBarChart(bmr_all, pos = "tile", order.lrn = getBMRLearnerIds(bmr_all)) +
  theme_pubr()
```

```
## Error in checkClass(x, classes, ordered, null.ok): Objekt 'bmr_all' nicht gefunden
```

```r
levels(plt3$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", "Heterobasidion")
```

```
## Error in levels(plt3$data$task.id) = c("Armillaria", "Diplodia", "Fusarium", : Objekt 'plt3' nicht gefunden
```

```r
levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", "GAM")
```

```
## Error in levels(plt$data$learner.id) = c("RF", "SVM", "KNN", "BRT", "GLM", : Objekt 'plt' nicht gefunden
```

```r
plt3
```

```
## Error in eval(expr, envir, enclos): Objekt 'plt3' nicht gefunden
```

