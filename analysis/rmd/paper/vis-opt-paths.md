---
title: "Visualization of optimization paths during hyperparameter tuning"
output: 
  html_document: 
    css: ../style.css
    theme: readable
    number_sections: yes
    toc: yes
    toc_float: true
    toc_collapsed: true
    df_print: tibble
    includes:
      in_header: ../header.html
author: "Patrick Schratz, FSU Jena"
---


```r
knitr::opts_knit$set(base.dir = 'analysis/rmd/')
knitr::opts_chunk$set(fig.retina = 3, 
                      fig.align = 'center',
                      fig.width = 9.93, 
                      fig.height = 4.13,
                      out.width = "100%",
                      fig.path = "../../../analysis/reports/figures-benchmark-eval-diplodia/",
                      echo = FALSE
                      )

loadd(bm_sp_sp_diplodia)
```

Visualization of optimization paths for the first five folds.

# Resampling strategies {.tabset .tabset-fade}

## Spatial/Spatial


```
## Error in `[.data.frame`(data, , x): undefined columns selected
```

### GAM


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

### KKNN


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

### RF 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

### SVM 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

### BRT 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

## Spatial/Non-Spatial


```
## Error in `[.data.frame`(data, , x): undefined columns selected
```

### GAM


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

### KKNN


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

### RF 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

### SVM 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

### BRT 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

## Non-Spatial/Non-Spatial


```
## Error in `[.data.frame`(data, , x): undefined columns selected
```

### GAM


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_nsp_nsp' not found
```

### KKNN


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_nsp_nsp' not found
```

### RF 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_nsp_nsp' not found
```

### SVM 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_nsp_nsp' not found
```

### BRT 


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_nsp_nsp' not found
```

# Comparison RF sp vs nsp


```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_sp' not found
```

```
## Error in eval(expr, envir, enclos): object 'opt_path_diplodia_sp_nsp' not found
```

```
## Error in plot_grid(opt_path_diplodia_sp_sp[[3]], opt_path_diplodia_sp_nsp[[3]], : object 'opt_path_diplodia_sp_sp' not found
```
