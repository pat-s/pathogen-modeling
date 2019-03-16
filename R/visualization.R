#' @param resampling_sp A benchmark/resampling object with a spatial resampling
#' @param resampling_nsp A benchmark/resampling object with a non-spatial resampling

vis_partitions = function(data, resampling_sp, resampling_nsp) {
  coordinates <- data[, c("x", "y")]
  data$geometry <- NULL
  data$x = NULL
  data$y = NULL


  task_spatial <- makeClassifTask(id = "pathogen_data", data = data,
                                  target = "diplo01", positive = "1",
                                  coordinates = coordinates)

  plist <- createSpatialResamplingPlots(task_spatial, list("CV" = resampling_nsp$results$diplodia$classif.binomial,
                                                           "SpCV" = resampling_sp$results$diplodia$classif.binomial),
                                        crs = 32630, repetitions = 1, point.size = 1.5,
                                        y.axis.breaks = c(42.8, 43.2),
                                        x.axis.breaks = c(-2, -3),
                                        axis.text.size = 18)

  sp <- plot_grid(plist[["Plots"]][[1]], plist[["Plots"]][[2]],
                  plist[["Plots"]][[3]], ncol = 3, nrow = 1,
                  labels = plist[["Labels"]][1:3], label_size = 18)
  sp2 <- plot_grid(plist[["Plots"]][[4]], plist[["Plots"]][[5]], NULL,
                   ncol = 3, nrow = 1, labels = plist[["Labels"]][4:5],
                   label_size = 18)

  nsp <- plot_grid(plist[["Plots"]][[6]], plist[["Plots"]][[7]],
                   plist[["Plots"]][[8]], ncol = 3, nrow = 1,
                   labels = plist[["Labels"]][6:8],
                   label_size = 18)
  nsp2 <- plot_grid(plist[["Plots"]][[9]], plist[["Plots"]][[10]], NULL,
                    ncol = 3, nrow = 1, labels = plist[["Labels"]][9:10],
                    label_size = 18)

  final_plot <- plot_grid(sp, sp2, nsp, nsp2, ncol = 1)

  return(final_plot)

}

# Explore winning hyperparameter settings Thu Mar 14 14:03:35 2019
# ------------------------------ Load the cross-validation results from all
# models.
#
# Retrival of best hyperparameter settings per fold:
#
# After generating the hyperparameter effect data from the cross-validation
# objects using `generateHyperParsEffectData`, the information is grouped by
# folds. For each fold, we search for the highest AUROC value which then leaves
# us with the winning hyperparamter setting for each fold.
#
# We do so for every cross-validation setting for each fold.
#
# For models BRT and knn with three tunable hyperparameters, we end up with nine
# scatterplots, respectively.

## RF

#' @param models List of Benchmark/Resample results
#' @param resampling String specifying the resample setting
#' @param model_name Name of algorithm for title
#' @param hyperparam String of 2L specyfying the hyperparamters to compare
vis_tuning_effects = function(models, resampling, model_name, hyperparam) {

  hyperpars_effect_data = map(models, ~ generateHyperParsEffectData(.x, partial.dep = TRUE))

  names = map2_chr(model_name, resampling, ~ glue("{.x}-{.y}"))

  # find best combinations by folds
  hyperpars_effect_data$data %<>%
    map(~ group_by(.x, nested_cv_run)) %>%
    map(~ filter(.x, brier.test.mean == min(brier.test.mean))) %>%
    map(~ ungroup(.x)) %>%
    map(~ mutate(.x, nested_cv_run = as.factor(nested_cv_run)))

  plots = map(hyperpars_effect_data$data, ~
                ggplot(.x, aes(x = hyperparam[1], y = hyperparam[2], label = nested_cv_run)) +
                geom_point(alpha = 0.1) +
                geom_point(aes(x = 1, y = 3), shape = 4, color = "red", size = 3) + # default values for num.trees and mtry
                coord_cartesian(
                  ylim = c(1, 11),
                  xlim = c(1, 10)
                ) +
                labs(
                  title = glue("{model_name} ({resampling})"),
                  subtitle = "min.node.size and mtry"
                ) +
                geom_label_repel(
                  data = subset(
                    .x,
                    as.integer(nested_cv_run) <= 5
                  ),
                  min.segment.length = unit(0, "lines")
                ) +
                scale_y_continuous(breaks = seq(1, 11, 2), labels = seq(1, 11, 2)) +
                theme_ipsum_rc(
                  axis_title_size = 12,
                  axis_title_just = "c",
                  plot_title_size = 15
                ) +
                theme(
                  axis.text = element_text(size = 12),
                  plot.margin = unit(c(0.25, 0.2, 0.5, 0.2), "cm"),
                  axis.title.y = element_text(angle = -90, vjust = 1)
                )
  )

  # create marginal plots
  marginal_plots = map(plots, ~ ggMarginal(.x,
                                           type = "density",
                                           fill = "transparent", size = 20)
  )
}

#' @param model2 List of Benchmark/Resample results
#' @param n_folds Number of folds to visualize (e.g. 1-5)

vis_opt_path = function(models, n_folds) {

  opt_path_list = map(models, function(.i)
    imap(
      .i$extract[n_folds],
      ~getOptPathY(.x$opt.path) %>%
        as_tibble() %>%
        mutate(iter = 1:length(value)) %>%
        mutate(value = cummin(value)) %>%
        mutate(fold_id = glue("Fold {.y}"))
    ) %>%
      bind_rows()
  )

  opt_path_plot = map(opt_path_list, ~
                        ggline(.x,
                               x = "iter",
                               y = "value",
                               plot_type = "l",
                               title = "",
                               ylab = "Brier score",
                               xlab = "Iteration",
                               numeric.x.axis = T,
                               point.size = 0.03, facet.by = "fold_id"
                        ) +
                        geom_vline(xintercept = 30, linetype = "dashed") +
                        theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0))) +
                        facet_wrap(~fold_id, scales = "free") # we use the ggplot2 version here as we can specify `scales` which is not possible in the ggpubr argument
  )
}

#' @param list A list generated from `vis_opt_path()`
save_plot_opt_paths = function(list) {

  # TODO: auto-parse names from model and resamp setting

  imgs = map(list, ~ save_plot(file_out("analysis/figures/opt-paths-RF-sp-vs-nsp.png")),
             .x,
             ncol = 1, nrow = 2, base_width = 12
  )
  return(imgs)
}
