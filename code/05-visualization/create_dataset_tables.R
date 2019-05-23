diplodia_table_continuous = create_dataset_tables(diplodia_data,
                                                  stats = c("n", "min", "q1",
                                                            "median", "mean",
                                                            "q3", "max",
                                                            "iqr", "na"),
                                                  type = "continuous")

diplodia_table_nominal = create_dataset_tables(diplodia_data,
                                               type = "nominal",
                                               drop_vars = )
