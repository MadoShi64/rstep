

# gen_step_mto : generate meteo file for step model---------------------------

#' Generate meteo files for STEP model
#'
#' @param workspace where you want to save the mto file
#' @param dataframe the name of the dataframe to convert to mto file
#' @param isite the name of the folder in which the mto file will be stored.
#' Usually the name if the site.
#' @param year the two last digits of the year. e.g. for 2012 it is "12"
#' @param alt the altitude of the site
#' @param lat the latitude of the site
#' @param hautmes the height at which the wind speed was measured
#'
#' @description Formatting csv data in STEP mto format.
#' The function takes dataframe with: names(dataframe)="date" "day" "year" "rain" "RayGlo_MJm" "temp_min"
#'  "temp_max" "pvap_2_m_hPa" "Wind_Speed".
#'
#' @return a folder in the workspace in which there is a mto file. e.g. for
#' site 01 and year 2012 the file name is S0100112.mto
#' @export
#'
#' @importFrom gdata cbindX
#' @importFrom dplyr bind_rows
#' @importFrom dplyr mutate_if
#' @importFrom utils write.table
#'
#' @examples
#' gen_step_mto(workspace = workspace,dataframe=df,isite="Dahra",
#' year = "12",alt=308,lat=15.4,hautmes=2)
#' \dontrun{
#' gen_step_mto(workspace = workspace,dataframe=df,isite="Dahra",
#' year = "12",alt=308,lat=15.4,hautmes=2)
#' }
#'
gen_step_mto <- function(workspace,dataframe,isite,year,alt,lat,hautmes){
  mylist <- list() #create an empty list
  if(nrow(dataframe)==365){     #Normal year (February : 28 days)
    for (i in 3:ncol(dataframe)){
      janvier=data.frame(dataframe[1:31, c(2,i)])  #preallocate a numeric vector
      fevrier=data.frame(dataframe[32:59, i])
      mars=data.frame(dataframe[60:90, i])
      avril=data.frame(dataframe[91:120, i])
      mai=data.frame(dataframe[121:151, i])
      juin=data.frame(dataframe[152:181, i])
      juillet=data.frame(dataframe[182:212, i])
      aout=data.frame(dataframe[213:243, i])
      septembre=data.frame(dataframe[244:273, i])
      octobre=data.frame(dataframe[274:304, i])
      novembre=data.frame(dataframe[305:334, i])
      decembre=data.frame(dataframe[335:365, i])
      mylist[[i]] <- cbindX(janvier, fevrier, mars, avril,mai,juin,juillet,aout,septembre,
                            octobre,novembre,decembre) # bind columns with different number of rows with "gdata"
      myList = mylist[c(4:9)]
    }
  } else{                                         #Leap year (February : 29 days)
    for (i in 3:ncol(dataframe)){
      janvier=data.frame(dataframe[1:31, c(2, i)])  # #preallocate a numeric vector
      fevrier=data.frame(dataframe[32:60, i])
      mars=data.frame(dataframe[61:91, i])
      avril=data.frame(dataframe[92:121, i])
      mai=data.frame(dataframe[122:152, i])
      juin=data.frame(dataframe[153:182, i])
      juillet=data.frame(dataframe[183:213, i])
      aout=data.frame(dataframe[214:244, i])
      septembre=data.frame(dataframe[245:274, i])
      octobre=data.frame(dataframe[275:305, i])
      novembre=data.frame(dataframe[306:335, i])
      decembre=data.frame(dataframe[336:366, i])
      mylist[[i]] <- cbindX(janvier, fevrier, mars,avril,mai,juin,juillet,aout,septembre,
                            octobre,novembre,decembre)
      myList = mylist[c(4:9)]

    }

  }

  dir.create (paste0(workspace,"/",isite))

  for (t in 1:6){  # each of the 4 elements of mylist.c has 6 elements
    colnames(myList[[t]]) <- c("day","January","February","March","April","May","June",
                               "July","August","September","October","November","December" )#rename the cols of each elmt of mylist.c
  }

  dff <- do.call("bind_rows",myList) #combine all vectors into a matrix

  altitude <- data.frame(t(c(alt,lat,hautmes)))# new row for the first line
  blank.names <- function(dat){
    for(z in 1:ncol(dat)){
      names(dat)[z] <- paste(rep(" ",z),collapse="")
    }
    return(dat)
  }
  new0<-blank.names(altitude)
  new1<-blank.names(dff)
  new1[is.na(new1)]<-0             ## replace NAs with 0
  met<-bind_rows(new0,new1)    # bind the rows with "dplyr"
  met=met %>%
    mutate_if(is.numeric,round,digits=2) ##limit the number of decimals to 2 with dplyr
  #assign(paste0("Meteo",1),met)
  myfile <- file.path(paste0(workspace,"/",isite,"/S01001",year, ".mto")) # Start with S0100115
  write.table(met, file = myfile,sep="\t",col.names=FALSE, row.names=FALSE,na="",quote=FALSE)

}
