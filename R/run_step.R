
#' Run STEP model from R
#'
#' @param step_daily_original Path to the directory containing the model's code
#' @param daily_original Path to the directory containing the model's input files
#'
#' @description Run STEP model using R
#'
#' @return Model output files in a folder called Output
#' @export
#'
#' @examples
#' \dontrun{
#' run_step_1D(step_daily_original,daily_original)
#' }
#'
run_step_1D<-function(step_daily_original=step_daily_original,
                      daily_original=daily_original){
  setwd(get(".rs.getProjectDirectory")())
  setwd(step_daily_original)
  system("make")
  unlink("*.o")
  setwd(get(".rs.getProjectDirectory")())
  file.copy(from = paste0(step_daily_original,"/Stepatsec.exe"),
            to = paste0(daily_original,"/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)
  setwd(get(".rs.getProjectDirectory")())
  setwd(daily_original)
  system("./Stepatsec")
  unlink("*.exe")
  setwd(get(".rs.getProjectDirectory")())
  dir.create("2-outputs/Output", showWarnings = FALSE, recursive = FALSE)
  files=Sys.glob(file.path(paste0(daily_original, "/*.out")))
  file.copy(from = files,to = "2-outputs/Output/",
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)
  unlink(files)
}





