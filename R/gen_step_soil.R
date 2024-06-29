

#' Write STEP-GENDEC-N2O soil input file for each simulation grid cell
#'
#' @param dataframe the data frame containing the data required to create the soil file
#' e.g. of variable names: id, coord, albedo, soil_water1, soil_temp1, clay1, sand1, pH1, silt1,
#' soil_water2,soil_temp2, clay2, sand2, pH2, silt2,soil_water3, soil_temp3, clay3, sand3, pH3,silt3,
#' soil_water4, soil_temp4, clay4, sand4, pH4, silt4, soil_temp5
#' @param start_yr the two last digits of the first year of simulation. e.g. for 2012 it is "12"
#' @param end_yr the two last digits of the last year of simulation.. e.g. for 2020 it is "20"
#' @param folder_patch path to where you want to store the file generated (file is generated in a folder with the same name as the site id. make sure the folder is already there before beforehand)
#'
#' @description gen_step_file generates examples of STEP initialization file in excel format
#'
#' @return 2D STEP-GENDEC-NC input file formats ".sol" for all simulation grid cells
#' @export
#'
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
    t <- rstep::sol
    t[2,2][t[2,2]=="ZONE SAHELIENNE DU SENEGAL"] <- paste0("ZONE SAHELIENNE")

    # format the sol file for each site using the dataset
    t[1,2][t[1,2] =="SITE RSP_six_forage"] <- paste0("SITE_",dataframe[i,"id"]," [long_lat: ",dataframe[i,"coord.x"],"]")
    t[3,2][t[3,2]=="0.29648000000000002"] <- paste0(dataframe[i,"albedo"])

    # column 2character
    t[5,2][t[5,2] =="0.6"] <- paste0(dataframe[i,"soil_water1"])
    t[6,2][t[6,2] =="17.87"] <- paste0(dataframe[i,"soil_temp1"])
    t[8,2][t[8,2] == "5"] <-paste0(dataframe[i,"clay1"])
    t[9,2][t[9,2] == "93"] <-paste0(dataframe[i,"sand1"])
    t[10,2][t[10,2] == "7.4"] <-paste0(dataframe[i,"pH1"])
    t[11,2][t[11,2] == "2"] <- paste0(dataframe[i,"silt1"])

    # column 3 to 6  = numeric
    for(j in 2:4){
      t[5,j+1][t[5,j+1] == t[5,j+1]] <- dataframe[i, paste0("soil_water", j)]
      t[6,j+1][t[6,j+1] == t[6,j+1]] <- dataframe[i,paste0("soil_temp", j)]
      t[8,j+1][t[8,j+1] == t[8,j+1]] <-dataframe[i,paste0("clay", j)]
      t[9,j+1][t[9,j+1] == t[9,j+1]] <-dataframe[i,paste0("sand", j)]
      t[10,j+1][t[10,j+1] == t[10,j+1]] <-dataframe[i,paste0("pH", j)]
      t[11,j+1][t[11,j+1] == t[11,j+1]] <- dataframe[i,paste0("silt", j)]
    }
    # column 7
    t[6,6][t[6,6] == t[6,6]] <- dataframe[i,"soil_temp5"]

    # write sol file in the new folder
    for(yr in start_yr:end_yr){
      myfile <- file.path(paste0(folder_patch,"/",dataframe[i,"id"],"/S01001",yr,".sol"))
      write.table(t, file = myfile,sep="\t",col.names=FALSE,row.names=FALSE,na="",quote=FALSE)
    }
  }
}
