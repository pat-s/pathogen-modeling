# Random Forest -----------------------------------------------------------

lrn_rf <- makeLearner(
  "classif.ranger",
  predict.type = "prob"
)

# xgboost -----------------------------------------------------------------

lrn_xgboost <- makeLearner(
  "classif.xgboost",
  predict.type = "prob"
)

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

# KNN ---------------------------------------------------------------------

lrn_kknn <- makeLearner("classif.kknn",
  predict.type = "prob",
  kernel = "rectangular"
)

# GLM ---------------------------------------------------------------------

lrn_glm <- makeLearner("classif.binomial",
  link = "logit",
  predict.type = "prob",
  fix.factors.prediction = TRUE
)
