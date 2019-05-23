This study was funded by the [EU LIFE Healthy Forest (LIFE14 ENV/ES/000179)](http://ec.europa.eu/environment/life/project/Projects/index.cfm?fuseaction=search.dspPage&n_proj_id=5219) project.

The setup of this benchmark study is described below.
In total, 140 performance estimates have been calculated.

#### Classifiers (7)

- BRT (Boosted Regression Trees)
- GAM (Generalized Additive Model)
- GLM (Generalized Linear Model)
- KNN (k-nearest Neighbor)
- SVM (Support Vector Machine)
- RF (Random Forest)
- XGBOOST (Extreme Gradient Boosting)

#### Datasets (4)

- Armillaria
- Diplodia
- Fusarium
- Heterobasidion

#### Resampling structures (5)

(performance estimation / hyperparameter tuning)

- Spatial/non-spatial
- Spatial/Spatial
- Spatial/No tuning
- Non-spatial/Non-spatial
- Non-spatial/No tuning

## Hyperparameter tuning

Sequential model-based optimization (SMBO)

Initial design: 30 settings
Maximum iterations: 100

## Resampling

Nested cross-validation with five folds in both levels and 100 repetitions (performance level).

## Performance measure

Brier score

Pathogens "Diplodia" and "Fusarium" have the additional variables "age" and "year" during benchmarking compared to "Armillaria" and "Heterobasidion" for which these variables were not available.

Both variables are not used for prediction as they would not be known in a predictive situation.

## Prediction

Probability of occurence for the specific pathogen across the whole Basque country on a 200 x 200 m spatial resolution.

#### External library requirements

- SAGA GIS (for creating the input variable `slope_degrees`)
