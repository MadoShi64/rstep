
#' Generate an example of STEP initialisation file in excel format
#'
#' @param filepath path to where you want to store the file generated
#' @param filename the name of the initialisation file you want to generate
#'
#'
#' @description gen_step_xlsx generates examples of STEP initialisation file in excel format
#' if filename = ".dat" it generates pluri.dat file in excel format to edit
#' if filename = ".bmt" it generates S100112.bmt file in excel format to edit
#' if filename = ".burn" it generates S100112.burn file in excel format to edit
#' if filename = ".cha" it generates S100112.cha file in excel format to edit
#' if filename = ".cle" it generates S100112.cle file in excel format to edit
#' if filename = ".disp" it generates S100112.disp file in excel format to edit
#' if filename = ".sol" it generates S100112.sol file in excel format to edit
#' if filename = ".veg" it generates S100112.veg file in excel format to edit
#' if filename = ".wet" it generates S100112.wet file in excel format to edit
#'
#' @importFrom openxlsx write.xlsx
#'
#' @return An excel file to edit
#' @export
#'
#' @examples
#' \dontrun{
#' gen_step_xlsx(filepath,"sol")
#' }
#'
#'
gen_step_xlsx = function(filepath=NULL,filename){
  if (filename == "dat"){
    write.xlsx(.dat,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "bmt"){
    write.xlsx(.bmt,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "burn"){
    write.xlsx(.burn,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "cha"){
    write.xlsx(.cha,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "cle"){
    write.xlsx(.cle,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "disp"){
    write.xlsx(.disp,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "sol"){
    write.xlsx(.sol,paste0(filepath,filename,".xlsx"))
  }
  if (filename == ".veg"){
    write.xlsx(.veg,paste0(filepath,filename,".xlsx"))
  }
  if (filename == "wet"){
    write.xlsx(.wet,paste0(filepath,filename,".xlsx"))
  }
}





