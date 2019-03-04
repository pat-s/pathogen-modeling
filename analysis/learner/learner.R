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
  predict.type = "prob",
  scale = FALSE
)

# KNN ---------------------------------------------------------------------

lrn_kknn <- makeLearner("classif.kknn",
  predict.type = "prob",
  kernel = "rectangular"
)

# BRT ---------------------------------------------------------------------

lrn_brt <- makeLearner("classif.gbm",
                       predict.type = "prob",
                       distribution = "bernoulli"
)

# GAM ---------------------------------------------------------------------

lrn_gam_diplodia_perf <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "diplo01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) +
                                                s(age, k = 15) + s(ph, k = 15) + lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth + year.2010 + year.2011 + year.2012"

)

# "pred" without variable and "year"
lrn_gam_diplodia_pred <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "diplo01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock + lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)

lrn_gam_fusarium_perf <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "fus01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) +
                                                s(age, k = 15) + s(ph, k = 15) + lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth + year.2010 + year.2011 + year.2012"
)

# "pred" without variable and "year"
lrn_gam_fusarium_pred <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "fus01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock + lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)

lrn_gam_armillaria_perf <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "armillaria ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock + lithology.chemical.sedimentary.rock +
                                                lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)

# "pred" without variable and "year"
lrn_gam_armillaria_pred <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "armillaria ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)

lrn_gam_heterobasidion_perf <- makeLearner("classif.gam",
                                       family = "binomial",
                                       binomial.link = "logit",
                                       predict.type = "prob",
                                       method = "GCV.Cp",
                                       fix.factors.prediction = TRUE,
                                       formula = "heterobasi ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)

# "pred" without variable and "year"
lrn_gam_heterobasidion_pred <- makeLearner("classif.gam",
                                       family = "binomial",
                                       binomial.link = "logit",
                                       predict.type = "prob",
                                       method = "GCV.Cp",
                                       fix.factors.prediction = TRUE,
                                       formula = "heterobasi ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth"
)


lrn_gam_diplodia_perf_non <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "diplo01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) +
                                                s(age, k = 15) + s(ph, k = 15) + lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth + year.2010 + year.2011 + year.2012",
                                     sp = rep(0, 7)
)


lrn_gam_fusarium_perf_non <- makeLearner("classif.gam",
                                     family = "binomial",
                                     binomial.link = "logit",
                                     predict.type = "prob",
                                     method = "GCV.Cp",
                                     fix.factors.prediction = TRUE,
                                     formula = "fus01 ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) +
                                                s(age, k = 15) + s(ph, k = 15) + lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth + year.2010 + year.2011 + year.2012",
                                     sp = rep(0, 7)
)



lrn_gam_armillaria_perf_non <- makeLearner("classif.gam",
                                       family = "binomial",
                                       binomial.link = "logit",
                                       predict.type = "prob",
                                       method = "GCV.Cp",
                                       fix.factors.prediction = TRUE,
                                       formula = "armillaria ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth",
                                       sp = rep(0, 6)
)


lrn_gam_heterobasidion_perf_non <- makeLearner("classif.gam",
                                           family = "binomial",
                                           binomial.link = "logit",
                                           predict.type = "prob",
                                           method = "GCV.Cp",
                                           fix.factors.prediction = TRUE,
                                           formula = "heterobasi ~ s(temp, k = 15) + s(precip, k = 15) + s(pisr, k = 15) +
                                                 s(slope_degrees, k = 15) + s(hail_probability, k = 15) + s(ph, k = 15) +
                                                 lithology.clastic.sedimentary.rock +
                                                lithology.chemical.sedimentary.rock + lithology.magmatic.rock +
                                                soil.soils.with.little.or.no.profile.differentiation +
                                                soil.pronounced.accumulation.of.organic.matter.in.the.mineral.topsoil +
                                                soil.soils.with.limitations.to.root.growth",
                                           sp = rep(0, 6)
)

# GLM ---------------------------------------------------------------------

lrn_glm <- makeLearner("classif.binomial",
  link = "logit",
  predict.type = "prob",
  fix.factors.prediction = TRUE
)
