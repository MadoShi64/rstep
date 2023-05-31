
#' Bar graph for a selected variable
#'
#' @param dataframe the name of the dataframe generated with the function gen_table
#' @param varname the name of the STEP variable
#' @param fun the operation you want to perform : sum or mean
#' @param errorbar notify whether or not you want to display errorbars
#'
#' @description step_barplot displays a bar graph of the annual sum or mean of the selected variable
#'
#' @return a bar graph of the annual sum or mean of the selected variable
#' @export
#'
#'
#' @importFrom stats sd
#' @importFrom stats aggregate
#' @import ggplot2
#' @import dplyr
#'
#'
#'
#' @examples
#' \dontrun{
#' step_barplot(dataframe = df, varname = "Etr",fun="sum",errorbar = TRUE)
#' }
#'
step_barplot = function(dataframe,
                        varname,
                        fun,
                        errorbar){
  thm = theme_classic()+
    theme(panel.grid.major= element_line(linetype="dotted"),
          panel.border = element_rect(color = "black",fill = NA),
          axis.title.x = element_text(size = 10, face = "bold", color="black"),
          axis.text.x = element_text(size = 10, face = "bold", color="black"),
          axis.title.y = element_text(size = 10, face = "bold", color="black"))

  dataframe$years <- format(dataframe$Date, "%Y")
  sumYear1 <- aggregate(dataframe[,varname]~years, dataframe, "mean")
  sumYear2 <- aggregate(dataframe[,varname]~years, dataframe, "sum")
  sumYear3 <- aggregate(dataframe[,varname]~years, dataframe, "sd")

  sum <- cbind(sumYear1,sumYear2$`dataframe[, varname]`)
  sumYear <- cbind(sum,sumYear3$`dataframe[, varname]`)

  names(sumYear)[names(sumYear) == "dataframe[, varname]"] <- "mean"
  names(sumYear)[names(sumYear) == "sumYear2$`dataframe[, varname]`"] <- "sum"
  names(sumYear)[names(sumYear) == "sumYear3$`dataframe[, varname]`"] <- "sd"
  sumYear=sumYear %>%
    mutate_if(is.numeric,round,digits=1)

  if(fun=="mean"){yval = mean}
  if(fun=="sum"){yval=sum}
  if(errorbar==FALSE){
    g = ggplot(data = sumYear,aes(x = years,y= yval)) +
      geom_bar(stat="identity",position=position_dodge(),alpha=0.7)+
      geom_text(aes(label=mean), vjust=1.6, color="black", position = position_dodge(1.5), size=3)+
      labs(x = "Year",y = paste0(varname," [annual mean]")) +thm
  }else{
    g+geom_errorbar(aes(ymax=mean+sd, ymin=mean-sd), size=.4, width=.15, linetype="solid", position=position_dodge(.9))
  }
  return(g)
}
