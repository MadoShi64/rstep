


#' Double bar graph for a selected variable
#'
#' @param dataframe the name of the dataframe generated with the function gen_table
#' @param file.name the name of the file with informations about
#' the start and the end of the seasons
#' @param filepath path of the file named in "file.name".
#' Usually the path of the folder daily_original
#' @param varname the name of the STEP variable
#' @param fun the operation you want to perform : sum or mean
#' @param ylab name of the y axis
#' @param errorbar notify weather or not you want to display errorbars
#'
#' @description step_Dbarplot displays a double bar graph of the annual sum or mean of the selected variable
#'
#' @return a double bar graph of the annual sum or mean of the selected variable
#' @export
#'
#' @importFrom stats sd
#' @importFrom stats aggregate
#' @import ggplot2
#' @import dplyr
#' @importFrom readxl read_excel
#'
#'
#' @examples
#' \dontrun{
#' step_Dbarplot(dataframe=df,file.name = "SeasonDahra2012-2020",
#' filepath = filepath,fun="sum",errorbar = FALSE,
#' varname = "CO2Soil",ylab="CO2 emitted per season (gC/m2)")
#' }
#'
#'
step_Dbarplot = function(dataframe,file.name,filepath,varname,fun,ylab=NULL,errorbar=FALSE){
  df_in1 <-read_excel(paste0(filepath,"/",file.name,'.xlsx'))
  df1 <- cbind(dataframe,df_in1[,2])
  names(df1)[names(df1) == "df_in1[, 2]"] <- "Season"

  df1$years <- format(df1$Date, "%Y")
  sumYear1 <- aggregate(df1[,varname]~years+Season, df1, "mean")
  sumYear2 <- aggregate(df1[,varname]~years+Season, df1, "sum")
  sumYear3 <- aggregate(df1[,varname]~years+Season, df1, "sd")

  sum <- cbind(sumYear1,sumYear2$`df1[, varname]`)
  sumYear <- cbind(sum,sumYear3$`df1[, varname]`)

  names(sumYear)[names(sumYear) == "df1[, varname]"] <- "mean"
  names(sumYear)[names(sumYear) == "sumYear2$`df1[, varname]`"] <- "sum"
  names(sumYear)[names(sumYear) == "sumYear3$`df1[, varname]`"] <- "sd"

  sumYear=sumYear %>%
    mutate_if(is.numeric,round,digits=1)

  if(fun=="mean"){
    g= ggplot(data = sumYear,
                       aes(x    = years,
                           y    = mean,
                           fill = Season)) +

      # add the bars (means)
      geom_bar(stat="identity", position=position_dodge()) +
      # fill the bars manually
      scale_fill_manual(name   = 'Season:',
                        breaks = c("dry_season", "wet_season"),
                        values = c("dry_season" = "gray70",
                                   "wet_season" = "gray40"),
                        labels = c("Dry season", "Wet season")) +

      # plot CIs (add a point shape as well)
      #geom_point(position=position_dodge(width=.9), shape="-", show.legend = FALSE) +

      # set order of discrete values on OX axes & adjust the distance (gap) from OY axes
      #scale_x_discrete(limits = c("control", "T1", "T2", "T1&2"),
      #                labels = c("control", "Treatment 1", "Treatment 2", "Treatment 1 \n and Treatment 2"),
      #               expand = c(0, .5)) +
      scale_x_discrete(expand = c(0, 1)) +
      # set range on OY axes and adjust the distance (gap) from OX axes
      #scale_y_continuous(limits = c(0, 10), expand = c(0, 0)) +

      geom_text(aes(label=mean), vjust=1.5, color="black", position = position_dodge(1), size=3)+


      # Final adjustments:
      # set axis labels
      labs(x = "Year", y = paste0(ylab)) +
      theme_bw() + # eliminate default background
      theme(panel.grid.major = element_blank(), # eliminate major grids
            panel.grid.minor = element_blank(), # eliminate minor grids
            # set font family for all text within the plot ("serif" should work as "Times New Roman")
            # note that this can be overridden with other adjustment functions below
            text = element_text(family="serif"),
            # adjust X-axis title
            axis.title.x = element_text(size = 10, face = "bold"),
            # adjust X-axis labels
            axis.text.x = element_text(size = 10, face = "bold", color="black"),
            # adjust Y-axis title
            axis.title.y = element_text(size = 11, face = "bold"),
            # adjust legend title appearance
            legend.title = element_text(size = 8, face = "bold"),
            # adjust legend label appearance
            legend.text = element_text(size = 8, face = "italic"),
            # change spacing between legend items
            legend.key.height = unit(4, "mm"),
            # don't draw legend box (check element_rect() for borders and backgrounds)
            legend.background = element_blank(),
            # Put upper-left corner of legend box in upper-left corner of graph
            # Note that the numeric position in legend.position below is relative to the entire area,
            # including titles and labels, not just the plotting area
            legend.justification = c(0,1),
            legend.position = c(0,1))
    g
    if (errorbar==FALSE){
      g
    }else{
      g+geom_errorbar(aes(ymax=mean+sd, ymin=mean-sd), size=.4, width=.15, linetype="solid", position=position_dodge(.9))

    }
  }else{
    g= ggplot(data = sumYear,
                       aes(x    = years,
                           y    = sum,
                           fill = Season)) +

      # add the bars (means)
      geom_bar(stat="identity", position=position_dodge()) +
      # fill the bars manually
      scale_fill_manual(name   = 'Season:',
                        breaks = c("dry_season", "wet_season"),
                        values = c("dry_season" = "gray70",
                                   "wet_season" = "gray40"),
                        labels = c("Dry season", "Wet season")) +

      scale_x_discrete(expand = c(0, 1)) +
      geom_text(aes(label=sum), vjust=1.5, color="black", position = position_dodge(1.5), size=3)+
      labs(x = "Year", y = paste0(ylab)) +
      theme_bw() + # eliminate default background
      theme(panel.grid.major = element_blank(), # eliminate major grids
            panel.grid.minor = element_blank(), # eliminate minor grids
            text = element_text(family="serif"),
            axis.title.x = element_text(size = 10, face = "bold"),
            axis.text.x = element_text(size = 10, face = "bold", color="black"),
            axis.title.y = element_text(size = 11, face = "bold"),
            legend.title = element_text(size = 8, face = "bold"),
            legend.text = element_text(size = 8, face = "italic"),
            legend.key.height = unit(4, "mm"),
            legend.background = element_blank(),
            legend.justification = c(0,1),
            legend.position = c(0,1))
    g
  }


}
