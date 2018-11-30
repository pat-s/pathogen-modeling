# Random Forest -----------------------------------------------------------

lrn_rf <- makeLearner(
  "classif.ranger",
  predict.type = "prob"
)

saveRDS(lrn_rf, "/data/patrick/mod/pathogen-prediction/02-learners/learner-ranger.rda")

# xgboost -----------------------------------------------------------------

lrn_xg <- makeLearner(
  "classif.xgboost",
  predict.type = "prob"
)

saveRDS(lrn_xg, "/data/patrick/mod/pathogen-prediction/02-learners/learner-xgboost.rda")

# SVM ---------------------------------------------------------------------

# lrn_svm <- makeLearner(
#   "classif.svm",
#   predict.type = "prob",
#   kernel = "rbfdot",
#   scaled = FALSE
# )

lrn_svm <- makeLearner(
  "classif.svm",
  predict.type = "prob"
)

saveRDS(lrn_svm, "/data/patrick/mod/pathogen-prediction/02-learners/learner-svm.rda")

# KNN ---------------------------------------------------------------------

lrn_knn <- makeLearner("classif.kknn",
  predict.type = "prob",
  kernel = "rectangular"
)

# GLM ---------------------------------------------------------------------

lrn_glm <- makeLearner("classif.binomial",
  link = "logit",
  predict.type = "prob",
  fix.factors.prediction = TRUE
)
