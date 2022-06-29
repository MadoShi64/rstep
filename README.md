
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rstep: a workflow for STEP (Sahelian Transpiration Evaporation and Productivity) model under R

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/MadoShi64/rstep.svg?branch=master)](https://travis-ci.com/MadoShi64/rstep)
[![R-CMD-check](https://github.com/MadoShi64/rstep/workflows/R-CMD-check/badge.svg)](https://github.com/MadoShi64/rstep/actions)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/MadoShi64/rstep?branch=master&svg=true)](https://ci.appveyor.com/project/MadoShi64/rstep)
[![Codecov test
coverage](https://codecov.io/gh/MadoShi64/rstep/branch/master/graph/badge.svg)](https://app.codecov.io/gh/MadoShi64/rstep?branch=master)
<!-- badges: end -->

rstep provides simple functions to automatize the different tasks when performing 1D and/or 2D STEP (Mougin et al. 1995) simulation. It prepares the input data (meteo (file.mto), sol (file.sol), animal load (file.cha), vegetation (file.vge)...) for STEP simulation, by cleaning and formatting the data. It provides a simple workflow for the model parametrization and calibration. It provides a set of functions to automatize the visualisation of the model outputs (1D: plots and 2D: maps), using several functions some of which others come from other packages in the R environment.

## Installation

The development version of rstep can be installed from GitHub:

``` r
install.packages("remotes")
remotes::install_github("MadoShi64/rstep")
```

## Example

This is a basic example which shows you how to perform a linear regression for a variable of interest and display the graph and metrics

``` r
library(rstep)
## basic example code
```

An example with a random dataset.

``` r
set.seed(15)
Etr = abs(rnorm(30))
Etr.simu = abs(rnorm(30)) 

# create data frame
data = data.frame(Etr,Etr.simu) 

# Plot the graph of the regression
step_reg(data,"Etr","plot")
```

<img src="man/figures/README-cars-1.png" width="100%" />

``` r
# Check the metrics of the linear regression 
step_reg(data,"Etr","metric")
#>   r.squared      rmse       mae accuracy       bias
#> 1 0.1652742 0.8668114 0.6749571        0 -0.1425967
```
