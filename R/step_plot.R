
#' Dynamic and scatter plots for selected variables
#'
#' @param dataframe the name of the dataframe generated with the function gen_table
#' @param varname the name of the STEP variable
#' @param type the type of plot you want "dynamic time series or a scatter plot)
#' @param obs notify whether or not you want to display the observations alongside
#'
#' @description step_plot displays a dynamic plot or a scatter plot for selected step variable
#'
#' @return a plot "a dynamic time series or a scatter plot"
#' @export
#'
#' @import ggplot2
#' @import tidyr
#' @import dplyr
#' @import lubridate
#'
#' @examples
#' \dontrun{
#' step_plot(dataframe = df, varname = "Etr",type="dynamic",obs=TRUE)
#' }
#'
#'
#'
step_plot = function(dataframe,varname,type,obs=TRUE){
  #library(lubridate)
  #require(ggplot2)
  #library(tidyr)
  #library(dplyr)
  #library(plyr)
  if (type=="scatter"){
    ggplot(dataframe, aes(y=dataframe[,paste0(varname,".simu")], x=dataframe[,varname]))+geom_point(alpha = 0.9,size=2)+
      geom_smooth(colour="red", method="lm", fill="white",size=1.25) +
      ylab(paste0(varname," simulated"))+
      xlab(paste0(varname, " observed")) +
      #theme_classic()+
      theme(axis.text = element_text(colour = "black")) +
      geom_abline(intercept=0, slope=1, colour = "blue", linetype = "dashed")
  }else{
    if (obs == TRUE){
      dataframe = dataframe[,c("Date",varname,paste0(varname,".simu"))]

      var=names(dataframe[c(varname,paste0(varname,".simu"))])

      if (sum(is.na(dataframe[2])) < nrow(dataframe[3])/1.5){
        df2 <- dataframe %>%
          select(Date,all_of(var)) %>%
          gather(key = "variable", value = "value", -Date)
        ggplot(df2, aes(x = ymd(Date), y=value)) +
          geom_line(aes(color = variable), size = 0.5)+
          scale_color_manual(labels = c("Observation","Simulation"),
                             values = c("black","peru")) +
          scale_x_date(date_labels="%Y",date_breaks  ="1 year")+
          theme_classic()+
          ylab(names(dataframe[varname]))+xlab(names(dataframe[1]))+
          theme(panel.background = element_rect(fill = "white"),
                legend.title=element_blank(),legend.text=element_text(size=9,face = "italic"),
                axis.text = element_text(colour = "black"),
                #legend.position = c(0.25, 0.52),
                legend.background = element_rect(fill="transparent"))

      }else{
        df2 <- dataframe %>%
          select(Date,all_of(var)) %>%
          gather(key = "variable", value = "value", -Date)
        ggplot(df2, aes(x=ymd(Date),y=value,colour=variable))+
          geom_line(data=subset(df2,variable == paste0(varname,".simu")),linetype = "solid", size = 0.8)+
          geom_point(data=subset(df2,variable == varname))+
          scale_color_manual(labels = c("Observation","Simulation"),
                             values = c("black","peru")) +
          scale_x_date(date_labels="%Y",date_breaks  ="1 year")+
          theme_classic()+ylab(varname)+xlab("Date")+
          theme(panel.background = element_rect(fill = "white"),
                legend.title=element_blank(),legend.text=element_text(size=9,face = "italic"),
                axis.text = element_text(colour = "black"),
                #legend.position = c(0.25, 0.52),
                legend.background = element_rect(fill="transparent"))
      }
    }else{
      df2 <- df %>%
        select(Date,all_of(varname)) %>%
        gather(key = "variable", value = "value", -Date)
      ggplot(df2, aes(x = ymd(Date), y=value)) +
        geom_line(aes(color = variable), size = 0.65)+
        scale_color_manual(values="peru")+
        scale_x_date(date_labels="%Y",date_breaks  ="1 year")+
        ylab(names(dataframe[varname]))+xlab("Date")+
        theme_bw() + # eliminate default background
        theme(panel.grid.major = element_blank(), # eliminate major grids
              panel.grid.minor = element_blank(), # eliminate minor grids
              text = element_text(family="serif"),
              axis.title.x = element_text(size = 10, face = "bold", color="black"),
              axis.text.x = element_text(size = 10, face = "bold", color="black"),
              axis.title.y = element_text(size = 10, face = "bold", color="black"),
              legend.position = "none"
        )
    }
  }
}
