
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rstep

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/MadoShi64/rstep.svg?branch=master)](https://travis-ci.com/MadoShi64/rstep)
[![R-CMD-check](https://github.com/MadoShi64/rstep/workflows/R-CMD-check/badge.svg)](https://github.com/MadoShi64/rstep/actions)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/MadoShi64/rstep?branch=master&svg=true)](https://ci.appveyor.com/project/MadoShi64/rstep)
[![Codecov test
coverage](https://codecov.io/gh/MadoShi64/rstep/branch/master/graph/badge.svg)](https://app.codecov.io/gh/MadoShi64/rstep?branch=master)
<!-- badges: end -->

The goal of rstep is to Provide functionality for quick processing of
STEP model outputs.

## Installation

You can install the development version of rstep like so:

``` r
install.packages("rstep")
```

## Example

This is a basic example which shows you how to perform a linear
regression for a variable of interest and display the graph and metrics

``` r
library(rstep)
#> Warning in as.POSIXlt.POSIXct(Sys.time()): unable to identify current timezone 'C':
#> please set environment variable 'TZ'
## basic example code
```

An example with a random dataset.

``` r
set.seed(15)
Etr = abs(rnorm(30))# Etr = Etr measured 
Etr.simu = abs(rnorm(30)) # Etr.simu = Etr simulated with STEP

# create data frame
data = data.frame(Etr,Etr.simu) 

# Plot the graph of the regression
step_reg(data,"Etr","plot")
#> `geom_smooth()` using formula 'y ~ x'
```

<img src="man/figures/README-cars-1.png" width="100%" />

``` r
# Check the metrics of the linear regression 
step_reg(data,"Etr","metric")
#>   r.squared      rmse       mae accuracy       bias
#> 1 0.1652742 0.8668114 0.6749571        0 -0.1425967
```
