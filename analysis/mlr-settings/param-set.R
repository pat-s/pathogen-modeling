# Random Forest -----------------------------------------------------------

ps_rf <- makeParamSet(
  makeIntegerParam("mtry", lower = 1, upper = 9),
  makeIntegerParam("min.node.size", lower = 1, upper = 10),
  makeNumericParam("sample.fraction", lower = 0.2, upper = 0.9)
)

# xgboost -----------------------------------------------------------------

# ps_xgboost = makeParamSet(
#   makeIntegerParam("nrounds", lower = 10, upper = 600),
#   makeNumericParam("colsample_bytree", lower = 0.3, upper = 0.7),
#   makeNumericParam("subsample", lower = 0.25, upper = 1),
#   makeIntegerParam("max_depth", lower = 1, upper = 10),
#   makeNumericParam("gamma", lower = 0, upper = 10),
#   makeNumericParam("eta", lower = 0.001, upper = 0.6),
#   makeNumericParam("min_child_weight", lower = 0, upper = 20)
# )

ps_xgboost = makeParamSet(
  makeNumericParam("eta", lower = 0.01, upper = 0.2),
  makeNumericParam("gamma", lower = -7, upper = 6, trafo = function(x) 2^x),
  makeIntegerParam("max_depth", lower = 3, upper = 20),
  makeNumericParam("colsample_bytree", lower = 0.5, upper = 1),
  makeNumericParam("colsample_bylevel", lower = 0.5, upper = 1),
  makeNumericParam("lambda", lower = -10, upper = 10, trafo = function(x) 2^x),
  makeNumericParam("alpha", lower = -10, upper = 10, trafo = function(x) 2^x),
  makeNumericParam("subsample", lower = 0.5, upper = 1)
)

# SVM ---------------------------------------------------------------------

ps_svm = makeParamSet(
  makeNumericParam("cost", lower = -5, upper = 12,
                   trafo = function(x) 2 ^ x),
  makeNumericParam("gamma", lower = -12, upper = 3,
                   trafo = function(x) 2 ^ x)
)

# KNN ---------------------------------------------------------------------

ps_kknn <- makeParamSet(
  makeIntegerParam("k", lower = 1, upper = 100),
  makeIntegerParam("distance", lower = 1, upper = 100),
  makeDiscreteParam("kernel", values = c("rectangular", "triangular", "epanechnikov", "triweight", "cos", "inv", "gaussian", "rank", "optimal"))
)

# BRT ---------------------------------------------------------------------

ps_brt <- makeParamSet(
  makeIntegerParam("n.trees", lower = 100, upper = 10000),
  makeNumericParam("shrinkage", lower = 0.005, upper = 0.2),
  makeIntegerParam("interaction.depth", lower = 1, upper = 10)
)

# GAM ---------------------------------------------------------------------

ps_gam_armillaria_heterobasidion <- makeParamSet(
  makeNumericVectorParam("sp", len = 6, lower = 0, upper = 500000)
)
ps_gam_diplodia_fusarium <- makeParamSet(
  makeNumericVectorParam("sp", len = 7, lower = 0, upper = 500000)
)
