% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step_barplot.R
\name{step_barplot}
\alias{step_barplot}
\title{Bar graph for a selected variable}
\usage{
step_barplot(dataframe, varname, fun = "sum")
}
\arguments{
\item{dataframe}{the name of the dataframe generated with the function gen_table}

\item{varname}{the name of the STEP variable}

\item{fun}{the operation you want to perform : sum or mean}
}
\value{
a bar graph of the annual sum or mean of the selected variable
}
\description{
step_barplot displays a bar graph of the annual sum or mean of the selected variable
}
\examples{
\dontrun{
step_barplot(dataframe = df, varname = "Etr",fun="sum")
}

}
