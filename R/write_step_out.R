
#' STEP Out files to Excel and CSV
#'
#' @param file.name the name of the file. Usually the name of the site
#' @param workspace the directory, where there are the files you want to format.
#' And where you to store the new files
#' @param state.date the two last digits of the first year. e.g. for 2012 it is "12"
#' @param end.date the two last digits of the last year of simulation.. e.g. for 2020 it is "20"
#'
#' @param format the desired format for the file e.g. xlsx or csv
#'
#' @description write_step_out writes readable output files in the formats xlsx and csv
#'
#' @return a csv or excel file
#' @export
#'
#' @importFrom utils write.table
#' @importFrom utils write.csv
#' @importFrom utils read.table
#' @importFrom openxlsx write.xlsx
#'
#' @examples
#' \dontrun{
#' write_step_out("Dahra",workspace,12,20,"csv")
#' }
#'
#'
write_step_out = function(file.name,workspace,state.date,end.date,format="csv"){

  Output = NULL
  for (i in state.date:end.date){
    df =  read.table(paste0(workspace,"/S01001",i,".out"), header = FALSE, dec=".")
    #assign(paste0("data",i),df)
    Output <- rbind(Output, df) # bind the row of all iterations
  }
  #Combine data frames by rows
  #Output <- rbind(data12, data13, data14, data15, data16, data17, data18, data19, data20)

  #create a sequence of strings for the Titles
  title0 <- c("Jour","Mois","Rain", "Etp","Rayglo","Shum_0","Shum_1","Shum_2","Shum_3","Etot","Trtot","PST","BMs","BMv","Bmlita",
              "Psife","Rstoe","REspCv","REspEv","Psi(1)","Psi(2)","Psi(3)","BMr","RespCr","RespEr","a","BMrs","Epsiloni","Photoresp",
              "Bmlits","Bmburn","Bmfec","Bming","Bmsts","Bmsss","BSOM","Temp","Vent","Vapeur","BurntF","chaTotJ","TqCs",
              "Cs(1)",	"Cs(2)",	"Cs(3)",	"Cs(4)",	"Cs(5)",	"Cs(6)",	"Total_N",	"Amonia",	"End_N_(Norga)",	"Sub_N",	"Bn",	"Co2S","Ih(1)",
              "Ih(2)",	"Ih(3)",	"HCr(1)",	"Hlim",	"HFle",	"HCr(2)",	"Hlim",	"HFle",	"HCr(3)",	"Hlim",	"HFle",	"EP",	"TrP",	"PSTP",	"REspCPv",
              "REspEPv",	"BMPv",	"BPMs",	"(BMPlita)",	"PsifP",	"RstoP",	"BMPr",	"RespCPr",	"RespEPr",	"BMPrs",	"EpsiloniP",	"PhotorespP",
              "(BPburn)", "(BPing)",	"BPsts",	"BPsss",	"BLmv",	"BFlita",	"LAILv",	"hca",	"hcp",	"LAIv",	"LAIPv","G","rss","Snvege","SnSolnu","Sn",
              "Ln",	"Rn",	"H",	"LAIs","LAIPs","LAIlita","vcfv","vcfs","vcfl","vcft","NOFLUX_(kgN/ha/an)","Bc","NOFlux_Process",
              "N2OFlux_Process","NO3","NO2","N2O","En20","wfps","En2o_NOE")#from 52Output put "Vcfs" between Vcfv and Vcfl
  #title <- data.frame(t(title0))# new row for the titles
  #add the column titles to the new data frame
  colnames(Output) <- title0

  #create date column
  Date <- seq.Date(as.Date(paste0("20",state.date,"-01-01")), length.out = nrow(Output), by = "day", drop=FALSE)# 2012-01-01:the 1st date of the simulation | nrow(Output)= number of row output
  df <- data.frame(Date)
  #add date column to Output data frame
  Output1 <- cbind(df,Output)

  Output1$Shum_0_per <- (100*Output1$Shum_0) / 20   #Shum0: 20 mm depth
  Output1$Shum_1_per <- (100*Output1$Shum_1) / 280   #Shum1: 280 mm depth
  Output1$Shum_2_per <- (100*Output1$Shum_2) / 700   #Shum2: 700 mm depth
  Output1$Shum_3_per <- (100*Output1$Shum_3) / 2000  #Shum3: 2000 mm depth
  Output1$fsj <- 1-Output1$vcfv-Output1$vcfs-Output1$vcfl            #ground cover (fsj)
  Output1$Etr <- Output1$Trtot + Output1$Etot               #actual evapotranspiration (etr)
  Output1$vcft <- Output1$vcfv+Output1$vcfs+Output1$vcfl  # total ground cover
  Output1$CO2Soil <- Output1$Co2S/2
  Output1$SoilResp <- (Output1$Co2S/2)+ (Output1$RespCr/2) + (Output1$RespEr/2)
  Output1$Reco <-  (Output1$Co2S/2) + (Output1$RespCr/2) + (Output1$RespEr/2)+ (Output1$REspCv/2) + (Output1$REspEv/2)

  #Output2$fsjposi<-ifelse(Output1$fsj<0,0.01,Output2$fsj) #if fsj<0 print 0.01 else fsj

  if(format == "csv"){
    write.csv(Output1, paste0(workspace,"/",file.name,'.csv'))
  }
  if(format == "xlsx"){
    write.xlsx(Output1,paste0(workspace,"/",file.name,'.xlsx'))
  }
}

