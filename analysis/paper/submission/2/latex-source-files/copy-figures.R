library(fs)

# Figure 1
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/01_data/study_area.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/study_area.pdf",
          overwrite = TRUE)
# Figure 2
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/01_data/cross-validation_farbig.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/cross-validation_farbig.pdf",
          overwrite = TRUE)
# Figure 3
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/01_data/spcv_nspcv_folds.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/spcv_nspcv_folds.pdf",
          overwrite = TRUE)
# Figure 4
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/opt-paths-RF-sp-vs-nsp.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/opt-paths-RF-sp-vs-nsp.pdf",
          overwrite = TRUE)
# Figure 5
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/tuning_effects_all_models_mbo.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/tuning_effects_all_models_mbo.pdf",
          overwrite = TRUE)
# Figure 6
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/cv_boxplots_final_brier.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/cv_boxplots_final_brier.pdf",
          overwrite = TRUE)
# Appendix A
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/tuning_effects_appendix_mbo.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/tuning_effects_appendix_mbo.pdf",
          overwrite = TRUE)
# Appendix B
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/opt-paths-BRT.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/opt-paths-BRT.pdf",
          overwrite = TRUE)

# Appendix C
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/opt-paths-GAM.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/opt-paths-GAM.pdf",
          overwrite = TRUE)

# Appendix D
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/opt-paths-KNN.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/opt-paths-KNN.pdf",
          overwrite = TRUE)
# Appendix E
file_copy("/home/patrick/PhD/papers/01_model_comparison/04_figures/02_results/opt-paths-SVM.pdf",
          "/home/patrick/PhD/papers/01_model_comparison/02_writing/submission/2/latex-source-files/opt-paths-SVM.pdf",
          overwrite = TRUE)
