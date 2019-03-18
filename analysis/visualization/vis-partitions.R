plot_partitions = vis_partitions(diplodia_data, bm_sp_non_diplodia_glm, bm_nsp_non_diplodia_glm)

img_plot_partitions = save_plot_custom(plot_partitions, "analysis/figures/spcv_nspcv_folds.png",
                                       ncol = 3, nrow = 4)

img_plot_opt_paths = save_plot_opt_paths()
