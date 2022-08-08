
#' Dynamic and scatter plots for selected variables
#'
#' @param dataframe the name of the dataframe generated with the function gen_table
#' @param varname the name of the STEP variable
#' @param type the type of dynamic plot you want "line or point)
#' @param obs notify whether or not you want to display the observations alongside
#' @param unit the variable
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
#' step_plot(dataframe = df, varname = "Etr",type="line",obs=TRUE)
#' }
#'
#'
#'
step_plot = function(dataframe,
                     varname,
                     unit=NULL,
                     type="line",
                     obs=F){

  if (type=="point"){
    df2 <- dataframe %>%
      select(Date,all_of(varname)) %>%
      gather(key = "variable", value = "value", -Date)
    ggplot(df2, aes(x = ymd(Date), y=value)) +
      #geom_line(aes(color = variable), size = 0.65)+
      geom_point(aes(color = variable))+
      scale_color_manual(values="peru")+
      scale_x_date(date_labels="%Y",date_breaks  ="1 year",expand = c(0, 0))+
      ylab(paste0(names(dataframe[varname])," ",unit))+xlab("Date")+
      scale_y_continuous(expand = c(0, 0.01))+
      theme_minimal()+ # eliminate default background
      theme(text = element_text(family="serif"),
            axis.title.x = element_text(size = 10, face = "bold", color="black"),
            axis.text.x = element_text(size = 10, face = "bold", color="black"),
            axis.title.y = element_text(size = 10, face = "bold", color="black"),
            legend.position = "none"
      )
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
          scale_x_date(date_labels="%Y",date_breaks  ="1 year",expand = c(0, 0))+
          ylab(paste0(names(dataframe[varname])," ",unit))+xlab(names(dataframe[1]))+
          theme_minimal()+ # eliminate default background
          scale_y_continuous(expand = c(0, 0.01), limits = c(0, NA))+
          theme(axis.text.x = element_text(size = 10, face = "bold", color="black"),
                axis.title.y = element_text(size = 10, face = "bold", color="black"),
                text = element_text(family="serif"),
                axis.title.x = element_text(size = 10, face = "bold", color="black"),
                legend.position = "bottom",
                legend.title = element_blank()
          )

      }else{
        df2 <- dataframe %>%
          select(Date,all_of(var)) %>%
          gather(key = "variable", value = "value", -Date)
        ggplot(df2, aes(x=ymd(Date),y=value,colour=variable))+
          geom_line(data=subset(df2,variable == paste0(varname,".simu")),linetype = "solid", size = 0.8)+
          geom_point(data=subset(df2,variable == varname))+
          scale_color_manual(labels = c("Observation","Simulation"),
                             values = c("black","peru")) +
          scale_x_date(date_labels="%Y",date_breaks  ="1 year",expand = c(0, 0))+
          ylab(paste0((varname)," ",unit))+xlab("Date")+
          theme_minimal() + # eliminate default background
          scale_y_continuous(expand = c(0, 0.01), limits = c(0, NA))+
          theme(axis.text.x = element_text(size = 10, face = "bold", color="black"),
                axis.title.y = element_text(size = 10, face = "bold", color="black"),
                text = element_text(family="serif"),
                axis.title.x = element_text(size = 10, face = "bold", color="black"),
                legend.position = "bottom",
                legend.title = element_blank()
          )
      }
    }else{
      df2 <- dataframe %>%
        select(Date,all_of(varname)) %>%
        gather(key = "variable", value = "value", -Date)
      ggplot(df2, aes(x = ymd(Date), y=value)) +
        geom_line(aes(color = variable), size = 0.65)+
        #geom_point(aes(color = variable))+
        scale_color_manual(values="peru")+
        scale_x_date(date_labels="%Y",date_breaks  ="1 year",expand = c(0, 0))+
        ylab(paste0(names(dataframe[varname])," ",unit))+xlab("Date")+
        theme_minimal()+# eliminate default background
        scale_y_continuous(expand = c(0, 0.01), limits = c(0, NA))+
        theme(text = element_text(family="serif"),
              axis.title.x = element_text(size = 10, face = "bold", color="black"),
              axis.text.x = element_text(size = 10, face = "bold", color="black"),
              axis.title.y = element_text(size = 10, face = "bold", color="black"),
              legend.position = "none"
        )
    }
  }
}
