
#' Generate an example of STEP initialisation file in excel format
#'
#' @param filepath path to where you want to store the file generated
#' @param filename the name of the initialisation file you want to generate
#'
#'
#' @description gen_step_xlsx generates examples of STEP initialisation file in excel format.
#' filename = "dat" generates pluri.dat file in excel format to edit.
#' filename = "bmt" generates S100112.bmt file in excel format to edit.
#' filename = "burn" generates S100112.burn file in excel format to edit.
#' filename = "cha" generates S100112.cha file in excel format to edit.
#' filename = "cle" generates S100112.cle file in excel format to edit.
#' filename = "disp"generates S100112.disp file in excel format to edit.
#' filename = "sol" generates S100112.sol file in excel format to edit.
#' filename = "veg" generates S100112.veg file in excel format to edit.
#' filename = "wet" generates S100112.wet file in excel format to edit.
#'
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
gen_step_xlsx <- function(filepath = NULL, filename) {
  if (filename %in% c("dat", "bmt", "burn", "cha", "cle", "disp", "sol", "veg", "wet")) {
    write.xlsx(get(filename), file = paste0(filepath, "/", filename, ".xlsx"))
  } else {
    stop("Invalid filename provided.")
  }
}




