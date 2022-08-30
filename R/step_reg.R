
#' Perform a linear regression
#'
#' @param dataframe the name of the dataframe generated with the function gen_table
#' @param varname the name of the STEP variable
#' @param target notify your target, the scatterplot, the metric or the summary list of the regression
#'
#'
#' @description step_reg performs a linear regression between observation and simulation.
#' if target = "plot" it displays the scatter plot of the regression,
#' if target = "summary" it displays the summary table of the regression,
#' if target = "metric" it displays the metric of the regression
#'
#'
#' @return a scatter plot, a summary or metrics table of the regression
#' @export
#'
#'
#' @import dplyr
#' @importFrom stats lm
#' @importFrom readr col_date
#' @import Metrics
#' @import ggplot2
#'
#'
#'
#' @examples
#' \dontrun{
#' step_reg(dataframe = df,varname = "CO2Soil",target = "metric")
#' }
#'
#'
step_reg = function (dataframe,
                     varname,
                     target = NULL){
  dff= dataframe
  x<-replace(dff[,varname],dff[,varname]==0,NA)
  assign(paste0(varname),x)
  y<-replace(dff[,paste0(varname,".simu")],dff[,paste0(varname,".simu")]==0,NA)
  assign(paste0(varname,".simu"),y)
  # Filter a specific list of columns to keep only non-missing entries
  vars_to_check <- c(paste0(varname), paste0(varname,".simu"))
  df1=dff %>%
    filter_at(.vars = vars(one_of(vars_to_check)),~ !is.na(.))

  dreg2<- lm(df1[,paste0(varname,".simu")]~df1[,varname], data=df1)
  sum = summary(dreg2)

  rsqrt = sum[["r.squared"]]
  coef = dreg2[["coefficients"]]

  # rmse computes the root mean squared error between two numeric vectors
  rmse=Metrics::rmse(df1[,varname],df1[,paste0(varname,".simu")])

  #mae computes the average absolute difference between two numeric vectors.
  mae = Metrics::mae(df1[,varname],df1[,paste0(varname,".simu")])

  #accuracy = the proportion of elements in actual that are equal to
  #in predicted the corresponding element
  accuracy = Metrics::accuracy(df1[,varname],df1[,paste0(varname,".simu")])

  #bias computes the average amount by which actual is greater than predicted
  bias = Metrics::bias(df1[,varname],df1[,paste0(varname,".simu")])

  metric = data.frame("r.squared"= rsqrt, "rmse"=rmse,"mae"=mae,
                      "accuracy"=accuracy, "bias"=bias)
  #fit = broom::glance(dreg2)


  if (target == "summary"){
    return(sum)
  }

  if (target == "metric"){
    return(metric)
  }

  if (target == "plot"){

    a = round(coef[2],digits=2) ; b = round(coef[1],digits=2)
    c = round(rsqrt,digits=2) ; d = round(rmse,digits = 2)

    plot = ggplot(df1, aes(y=df1[,paste0(varname,".simu")], x=df1[,varname]),color=stu)+
      geom_abline(intercept=0, slope=1, colour = "gray70", linetype = "solid",size=.5)+
      geom_point(alpha = 200,size=.7)+
      geom_smooth(colour="black", method="lm",size=.5) +
      ylab(paste0("Simulated ",varname))+
      xlab(paste0("Observed ",varname)) +
      theme_minimal()+
      theme(axis.text=element_text(colour="black"),
            axis.title=element_text(face = 'italic'),
      )+
      annotate(geom="text", x =max(df1[,varname]),
               y = min(df1[,paste0(varname,".simu")]),
               label = paste0("Y = ",a,"X + ",b,"\n R\u00B2 = ",c," RMSE = ",d),
               size=3.5, fontface = 'italic',
               hjust = 1,
               vjust = 0)
    return(plot)
  }

}
