# Random Forest -----------------------------------------------------------

ps_rf <- makeParamSet(
  makeIntegerParam("mtry", lower = 1, upper = 9),
  makeIntegerParam("min.node.size", lower = 1, upper = 10),
  makeNumericParam("sample.fraction", lower = 0.2, upper = 0.9)
)

# xgboost -----------------------------------------------------------------

ps_xgboost = makeParamSet(
  makeIntegerParam("nrounds", lower = 10, upper = 600),
  makeNumericParam("colsample_bytree", lower = 0.3, upper = 0.7),
  makeNumericParam("subsample", lower = 0.25, upper = 1),
  makeIntegerParam("max_depth", lower = 1, upper = 10),
  makeNumericParam("gamma", lower = 0, upper = 10),
  makeNumericParam("eta", lower = 0.001, upper = 0.6),
  makeNumericParam("min_child_weight", lower = 0, upper = 20)
)

# SVM ---------------------------------------------------------------------

ps_svm = makeParamSet(
  makeNumericParam("cost", lower = -5, upper = 15,
                   trafo = function(x) 2 ^ x),
  makeNumericParam("gamma", lower = -15, upper = 3,
                   trafo = function(x) 2 ^ x)
)

# KNN ---------------------------------------------------------------------

ps_kknn <- makeParamSet(
  makeIntegerParam("k", lower = 1, upper = 250),
  makeIntegerParam("distance", lower = 1, upper = 300)
)
