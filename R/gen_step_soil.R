

#' Write STEP-GENDEC-N2O soil input file for each simulation grid cell
#'
#' @param dataframe the data frame containing the data required to create the soil file
#' e.g. of variable names: id, coord, albedo, soil_water1, soil_temp1, clay1, sand1, pH1, silt1,
#' soil_water2,soil_temp2, clay2, sand2, pH2, silt2,soil_water3, soil_temp3, clay3, sand3, pH3,silt3,
#' soil_water4, soil_temp4, clay4, sand4, pH4, silt4, soil_temp5
#' @param start_yr the two last digits of the first year of simulation. e.g. for 2012 it is "12"
#' @param end_yr the two last digits of the last year of simulation.. e.g. for 2020 it is "20"
#' @param folder_patch path to where you want to store the file generated
#'
#' @description gen_step_file generates examples of STEP initialisation file in excel format
#'
#' @return 2D STEP-GENDEC-NC input file formats ".sol" for all simulation grid cells
#' @export
#'
#' @importFrom
#'
#' @examples
#' \dontrun{
#' gen_step_soil(dataframe,start_yr,end_yr,folder_patch)
#' }
#'
# id, coord, albedo, soil_water1, soil_temp1, clay1, sand1, pH1, silt1, soil_water2,
# soil_temp2, clay2, sand2, pH2, silt2,soil_water3, soil_temp3, clay3, sand3, pH3,
# silt3, soil_water4, soil_temp4, clay4, sand4, pH4, silt4, soil_temp5

gen_step_soil <- function(dataframe,
                          start_yr,
                          end_yr,
                          folder_patch
                          ){


  for(i in 1:nrow(dataframe)){

    # import sol file from rstep
    t = sol
    t[2,2][t[2,2]=="ZONE SAHELIENNE DU SENEGAL"] <- paste0("ZONE SAHELIENNE")

    # format the sol file for each site using the dataset
    t[1,2][t[1,2] =="SITE RSP_six_forage"] <- paste0("SITE_",dataframe[i,"id"]," [long_lat: ",dataframe[i,"coord"],"]")
    t[3,2][t[3,2]=="0.29648000000000002"] <- paste0(dataframe[i,"albedo"])
    t[5,2][t[5,2] =="0.6"] <- paste0(dataframe[i,"soil_water1"])
    t[6,2][t[6,2] =="17.87"] <- paste0(dataframe[i,"soil_temp1"])
    t[8,2][t[8,2] == "5"] <-paste0(dataframe[i,"clay1"])
    t[9,2][t[9,2] == "93"] <-paste0(dataframe[i,"sand1"])
    t[10,2][t[10,2] == "7.4"] <-paste0(dataframe[i,"pH1"])
    t[11,2][t[11,2] == "2"] <- paste0(dataframe[i,"silt1"])

    t[5,3][t[5,3] == t[5,3]] <- dataframe[i,"soil_water2"]
    t[6,3][t[6,3] == t[6,3]] <- dataframe[i," soil_temp2"]
    t[8,3][t[8,3] == t[8,3]] <-dataframe[i,"clay2"]
    t[9,3][t[9,3] == t[9,3]] <-dataframe[i,"sand2"]
    t[10,3][t[10,3] == t[10,3]] <-dataframe[i,"pH2"]
    t[11,3][t[11,3] == t[11,3]] <- dataframe[i,"silt2"]

    t[5,4][t[5,4] == t[5,4]] <- dataframe[i,"soil_water3"]
    t[6,4][t[6,4] == t[6,4]] <- dataframe[i,"soil_temp3"]
    t[8,4][t[8,4] == t[8,4]] <-dataframe[i,"clay3"]
    t[9,4][t[9,4] == t[9,4]] <-dataframe[i,"sand3"]
    t[10,4][t[10,4] == t[10,4]] <-dataframe[i,"pH3"]
    t[11,4][t[11,4] == t[11,4]] <- dataframe[i,"silt3"]

    t[5,5][t[5,5] == t[5,5]] <- dataframe[i,"soil_water4"]
    t[6,5][t[6,5] == t[6,5]] <- dataframe[i,"soil_temp4"]
    t[8,5][t[8,5] == t[8,5]] <-dataframe[i,"clay4"]
    t[9,5][t[9,5] == t[9,5]] <-dataframe[i,"sand4"]
    t[10,5][t[10,5] == t[10,5]] <-dataframe[i,"pH4"]
    t[11,5][t[11,5] == t[11,5]] <- dataframe[i,"silt4"]

    t[6,6][t[6,6] == t[6,6]] <- dataframe[i,"soil_temp5"]

    # write sol file in the new folder
    for(yr in start_yr:end_yr){
      myfile <- file.path(paste0(folder_patch,"/",dataframe[i,"id"],"/S01001",yr,".sol"))
      write.table(t, file = myfile,sep="\t",col.names=FALSE,row.names=FALSE,na="",quote=FALSE)
    }
  }
}
