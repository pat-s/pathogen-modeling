#' @title Visualization of partitions used in benchmarking
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

#' @title Visualization of optimization paths
#' @param model2 List of Benchmark/Resample results
#' @param n_folds Number of folds to visualize (e.g. 1-5)
vis_opt_path = function(models) {

  opt_path_list = map(models, function(.i)
    imap(
      .i$extract[1:5],
      ~getOptPathY(.x$opt.path) %>%
        as_tibble() %>%
        mutate(iter = 1:length(value)) %>%
        mutate(value = cummin(value)) %>%
        mutate(fold_id = glue("Fold {.y}"))
    ) %>%
      bind_rows()
  )

  opt_path_plot = imap(opt_path_list, ~
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
                        ggtitle(.y) +
                        geom_vline(xintercept = 30, linetype = "dashed") +
                        theme(axis.title.y =
                                element_text(margin = margin(t = 0, r = 20,
                                                             b = 0, l = 0))) +
                        facet_wrap(~fold_id, scales = "free") # we use the ggplot2 version here as we can specify `scales` which is not possible in the ggpubr argument
  )
}

#' @title Visualization of tuning effects
#' @param models List of Benchmark/Resample results
#' @param model_name Name of algorithm for title
#' @param resampling String specifying the resample setting
#' @param hyperparam String of 2L specyfying the hyperparamters to compare
#' @param xlim x-axis limits
#' @param ylim y-axis limits
#' @param default Default hyperparameter settings (x and y). A red cross will
#'   denote the default settings in the plot.
vis_tuning_effects = function(models, model_name, resampling, hyperparameter,
                              xlim, ylim, default) {


  plot_list = pmap(list(x = models, y = model_name, z = hyperparameter,
                        xlim = xlim, ylim = ylim, default = default),
                   function(x, y, z, xlim, ylim, default) {

    hyperpar_effect <- generateHyperParsEffectData(x, partial.dep = TRUE)

    # find best combinations by folds
    hyperpar_effect$data %<>%
      group_by(nested_cv_run) %>%
      filter(brier.test.mean == min(brier.test.mean, na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(nested_cv_run = as.factor(nested_cv_run))

    plot = ggplot(hyperpar_effect$data, aes_string(x = z[1], y = z[2],
                                                   label = "nested_cv_run")) +
      geom_point(alpha = 0.1) +
      geom_point(aes(x = default[1], y = default[2]), shape = 4,
                 color = "red", size = 3) + # default values for num.trees and mtry
      coord_cartesian(
        ylim = ylim,
        xlim = xlim
      ) +
      labs(
        title = glue("{y} ({resampling})"),
        subtitle = glue("{z[1]} and {z[2]}")
      ) +
      geom_label_repel(
        data = subset(
          hyperpar_effect$data,
          as.integer(nested_cv_run) <= 5),
        min.segment.length = unit(0, "lines")) +
      #scale_y_continuous(breaks = seq(1, 11, 2), labels = seq(1, 11, 2)) +
      theme_pubr() +
      theme(
        axis.text = element_text(size = 12),
        plot.margin = unit(c(0.25, 0.2, 0.5, 0.2), "cm"),
        axis.title.y = element_text(angle = -90, vjust = 1)
      )

    if (y == "SVM") {
      plot = plot +
        labs(
          x = bquote(2^{
            cost
          }),
          y = bquote(2^{
            gamma
          })
        )
    }

    plot_marg <- ggMarginal(plot,
                            type = "density",
                            fill = "transparent", size = 20
    )
  })

}



#' @title Save plot and convert to pdf
#' @param plot A ggplot2 plot
#' @param path The path where to save the plot (including filename)
#' @param nrow number of rows
#' @param ncol number of columns
#'
#' @details Same behaviour as [cowplot::save_plot]
save_plot_custom = function(plot, path, nrow, ncol) {

  save_plot(file_out(path),
            plot, ncol = ncol, nrow = nrow)

  system("cd analysis/figures && exec ls -1 *.png |
       parallel convert '{}' '{.}.pdf'")

}

#' @title Create continuos and nominal LaTeX tables from dataset
#' @param data [data.frame]
#' @param type Options: "continuous" or "nominal"
create_dataset_tables = function(data, type = "continuous", drop_vars = NULL,
                                 stats = NULL) {

  if (is.null(stats)) {
    stats = c("n", "min", "q1", "median", "mean", "q3", "max",
              "s", "iqr", "na")
  }

  if (!is.null(drop_vars)) {
    data %<>%
      dplyr::select(-!!drop_vars)
  }

  if (type == "continuous") {

    table = tableContinuous(data[, sapply(data, is.numeric)],
                            longtable = FALSE, cumsum = FALSE,
                            cap = "Summary of numerical predictor variables",
                            label = "table:descriptive_summary_numeric",
                            stats = stats)

  } else if (type == "nominal") {
    table = tableNominal(data[, !sapply(data, is.numeric)],
                         longtable = FALSE, cumsum = FALSE,
                         cap = "Summary of nominal predictor variables",
                         label = "table:descriptive_summary_non_numeric",
                         stats = stats)
  }

  return(table)

}
