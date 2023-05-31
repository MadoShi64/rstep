
<!-- README.md is generated from README.Rmd. Please edit that file -->

# [rstep](https://vezy.github.io/DynACof): a workflow for STEP (Sahelian Transpiration Evaporation and Productivity) model under R <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/MadoShi64/rstep/workflows/R-CMD-check/badge.svg)](https://github.com/MadoShi64/rstep/actions)
[![Codecov test
coverage](https://codecov.io/gh/MadoShi64/rstep/branch/master/graph/badge.svg)](https://app.codecov.io/gh/MadoShi64/rstep?branch=master)
<!-- badges: end -->

## Overview

rstep provides a workflow to automate various tasks when performing STEP
simulations [(Mougin et
al. 1995)](https://www.sciencedirect.com/science/article/abs/pii/0034425794001268).
It prepares the model input data, runs the model from R, and automates
the visualization of the model results.

## Installation

The development version of rstep can be installed from GitHub:

``` r
install.packages("remotes")
remotes::install_github("MadoShi64/rstep")
```

## Some examples

Calling a STEP soil file for formatting

``` r
rstep::sol
#> Warning in Sys.timezone(): unable to identify current timezone 'T':
#> please set environment variable 'TZ'
#> # A tibble: 11 × 7
#>    X1                            ...2               ...3  ...4  ...5  ...6 ...7 
#>    <chr>                         <chr>             <dbl> <dbl> <dbl> <dbl> <chr>
#>  1 <NA>                          SITE RSP_six_for…  NA    NA    NA    NA   <NA> 
#>  2 <NA>                          ZONE SAHELIENNE …  NA    NA    NA    NA   <NA> 
#>  3 <NA>                          0.29648000000000…  NA    NA    NA    NA   ! al…
#>  4 <NA>                          2                  28    70   200    NA   ! ep…
#>  5 <NA>                          0.6                36.4  71.4 156    NA   ! st…
#>  6 <NA>                          17.87              22.8  25.2  28.5  30.5 ! Te…
#>  7 caracteristiques sol deduites <NA>               NA    NA    NA    NA   ! Op…
#>  8 <NA>                          5                   4     4     4    NA   ! % …
#>  9 <NA>                          93                 93    92    92    NA   ! % …
#> 10 <NA>                          7.4                 7.2   7.5   7.5  NA   ! pH 
#> 11 <NA>                          2                   3     4     4    NA   ! pe…
```

Run the model from R

``` r
#run_step_1D(step_daily_original=step_path,
#            daily_original=filepath)
```
