
#' Generate dataframe for processing
#'
#' @param filepath path of the files obs_data.xlsx and test0_data.xlsx.
#' Usually the path of the folder daily_original
#' @param workspace path of the folder where you stored the STEP
#' output file you are processing
#' @param filename the name of the STEP output file your are processing
#' @param sim_variables names of the variables you want to process
#' e.g. sim_variables = c("Rain","CO2Soil","Shum_1_per")
#' @param obs notify whether or not you have observation data of the variables of interest (if the file "obs_data.xlsx" is present in filepath's folder)
#' @param test0 notify whether or not you want to process data from a previous simulation (if the file "test0_data.xlsx" is present in filepath's folder)
#'
#' @description gen_table generates dataframe to process selected variables
#'
#' @return a dataframe of the variables of interest. the observation data and the result
#' of the current and the previous simulation "test0_data", all bind together
#' @export
#'
#' @importFrom readr read_csv
#' @importFrom readr cols
#' @importFrom readr col_date
#'
#' @importFrom readxl read_excel
#'
#'
#' @examples
#' \dontrun{
#' gen_table(filepath = filepath,workspace = workspace,filename = "Dahra",
#' sim_variables = sim_variables,obs=T,test0=F)
#' }
#'
#'
#'
gen_table = function(filepath,
                     workspace,
                     filename,
                     sim_variables,
                     obs=F,
                     test0 =F){
  #library(readr)
  if (obs == T & test0 == T){
    simu= read_csv(paste0(workspace,"/",filename,".csv"),
                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))

    simu = data.frame(Date=as.POSIXct(simu$Date),simu[sim_variables])


    obs=readxl::read_excel(paste0(filepath,"/obs_data.xlsx"))
    obs<-replace(obs,obs == -999,NA)
    obs = cbind(obs[1], obs[sim_variables])

    test0 = readxl::read_excel(paste0(filepath,"/test0_data.xlsx"))
    test0 = cbind(test0[1], test0[sim_variables])

    data = merge(simu,test0,by.x = "Date", by.y = "Date",suffixes = c(".simu",".simu0"))
    data1 = merge(obs,data,by.x = "Date", by.y = "Date")

    data1$Date = as.Date(data1$Date)

    return(data1)
  }
  if(obs == T & test0 == F){
    simu= read_csv(paste0(workspace,"/",filename,".csv"),
                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))

    simu = data.frame(Date=as.POSIXct(simu$Date),simu[sim_variables])


    obs=readxl::read_excel(paste0(filepath,"/obs_data.xlsx"))
    obs<-replace(obs,obs == -999,NA)
    obs = cbind(obs[1], obs[sim_variables])

    data = merge(obs,simu,by.x = "Date", by.y = "Date", suffixes = c("",".simu"))
    data$Date = as.Date(data$Date)

    return(data)

  }
  if(obs == F & test0 == T){
    simu= read_csv(paste0(workspace,"/",filename,".csv"),
                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))

    simu = data.frame(Date=as.POSIXct(simu$Date),simu[sim_variables])

    test0 = readxl::read_excel(paste0(filepath,"/test0_data.xlsx"))
    test0 = cbind(test0[1], test0[sim_variables])

    data = merge(simu,test0,by.x = "Date", by.y = "Date",suffixes = c(".simu",".simu0"))

    data$Date = as.Date(data$Date)

    return(data)
  }else{
    simu= read_csv(paste0(workspace,"/",filename,".csv"),
                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))

    simu = data.frame(Date=as.POSIXct(simu$Date),simu[sim_variables])
    return(simu)
  }

}

