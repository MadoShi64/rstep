% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step_Dbarplot.R
\name{step_Dbarplot}
\alias{step_Dbarplot}
\title{Double bar graph for a selected variable}
\usage{
step_Dbarplot(
  dataframe,
  file.name,
  filepath,
  varname,
  fun = "sum",
  ylab = NULL
)
}
\arguments{
\item{dataframe}{the name of the dataframe generated with the function gen_table}

\item{file.name}{the name of the file with informations about
the start and the end of the seasons}

\item{filepath}{path of the file named in "file.name".
Usually the path of the folder daily_original}

\item{varname}{the name of the STEP variable}

\item{fun}{the operation you want to perform : sum or mean}

\item{ylab}{name of the y axis}
}
\value{
a double bar graph of the annual sum or mean of the selected variable
}
\description{
step_Dbarplot displays a double bar graph of the annual sum or mean of the selected variable
}
\examples{
\dontrun{
step_Dbarplot(dataframe=df,file.name = "SeasonDahra2012-2020",
filepath = filepath,fun="sum",
varname = "CO2Soil",ylab="CO2 emitted per season (gC/m2)")
}


}
