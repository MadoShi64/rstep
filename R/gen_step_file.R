

#' Write STEP2D input files for each site
#'
#' @param filepath path to where you want to store the file generated
#' @param filename the name of the initialisation file you want to generate (the extension)
#' @param state.date the two last digits of the first year of simulation. e.g. for 2012 it is "12"
#' @param end.date the two last digits of the last year of simulation.. e.g. for 2020 it is "20"
#' @param isite id of the site. e.g. "S02", usually the name of the folder in which you want to store the data
#'
#' @description gen_step_file generates examples of STEP initialisation file in excel format
#'
#' @return STEP input file formats : ".dat",".bmt",".burn",".cha",".cle",".disp",".sol",".veg",".wet"
#' @export
#'
#' @importFrom readxl read_excel
#' @importFrom utils write.table
#'
#' @examples
#' \dontrun{
#' gen_step_file(filepath = filepath,filename ="cha",
#                 state.date = 12,end.date = 20,isite = "S02")
#' }
#'
gen_step_file = function(filepath,filename,
                         state.date,end.date,isite){
  if(filename=="dat"){
    data<-read_excel(paste0(filepath,filename,'.xlsx'))
    myfile <- file.path(paste0(filepath,isite,"/","pluri.", filename))
    write.table(data, file = myfile,sep="\t",col.names=FALSE, row.names=FALSE,na="",quote=FALSE)
  }else{
    data<-read_excel(paste0(filepath,filename,'.xlsx'))
    for (i in state.date:end.date) {
      myfile <- file.path(paste0(filepath,isite,"/","S01001", i,".", filename))
      write.table(data, file = myfile,sep="\t",col.names=FALSE, row.names=FALSE,na="",quote=FALSE)
    }
  }

}
