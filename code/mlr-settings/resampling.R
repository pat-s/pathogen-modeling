spcv_inner_fiveF <- makeResampleDesc("SpCV", iters = 5)
spcv_outer_fiveF_hundredR <- makeResampleDesc("SpRepCV", folds = 5, reps = 100)

cv_inner_fiveF <- makeResampleDesc("CV", iters = 5)
cv_outer_fiveF_hundredR <- makeResampleDesc("RepCV", folds = 5, reps = 100)
