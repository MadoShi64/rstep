
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rstep: a workflow for [STEP-GENDEC-CN](https://zenodo.org/record/7973200) model under R <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/fredi-agbohessou/rstep/workflows/R-CMD-check/badge.svg)](https://github.com/fredi-agbohessou/rstep/actions)
<!-- badges: end -->

## Overview

Introducing rstep: Automating Workflow for 1D and 2D STEP-GENDEC-CN
simulations

rstep is an R package designed to simplify and automate the essential
tasks involved in performing 1D or 2D STEP-GENDEC-CN simulations. With
rstep, you can streamline your workflow, from preparing model input data
to executing the model and visualizing the results, all within the
comfort of your Rstudio environment.

Key Features of rstep:

1- Model Input Data Preparation: rstep provides automated functions to
simplify the preparation of model input data. Say goodbye to manual
formatting and transformation, and effortlessly convert your data into a
suitable format for STEP-GENDEC-CN.

2- Seamless Model Execution: Execute your 1D or 2D simulations directly
from Rstudio with ease. rstep seamlessly interfaces with STEP-GENDEC-CN,
allowing you to initiate simulations and monitor progress without the
need to switch between environments.

3- Automated Visualization: Save time by automating the visualization of
your simulation results. rstep offers a range of visualization tools and
functions, enabling you to generate informative plots and graphs
effortlessly.

## Installation

The development version of rstep can be installed from GitHub:

``` r
install.packages("remotes")
remotes::install_github("fredi-agbohessou/rstep")
```

## Some examples

Calling a STEP soil file for formatting

``` r
rstep::sol
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
