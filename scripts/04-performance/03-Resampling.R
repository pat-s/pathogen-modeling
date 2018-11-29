inner <- makeResampleDesc("SpCV", iters = 5)
outer <- makeResampleDesc("SpRepCV", folds = 5, reps = 100)

saveRDS(inner, "/data/patrick/mod/pathogen-prediction/03-resampling/spcv-5iters-1rep.rda")
saveRDS(outer, "/data/patrick/mod/pathogen-prediction/03-resampling/sprepcv-5iters-100rep.rda")