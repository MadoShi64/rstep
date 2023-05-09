
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
  # Paths
  #step_daily_original=normalizePath("0-step.exe/step_1D/step_daily_original/", winslash = "/")
  #daily_original = normalizePath("0-data/step_1d_simu/daily_original/", winslash = "/")

  #reset path to proj wd
  setwd(get(".rs.getProjectDirectory")())
  #set working dir
  setwd(step_daily_original)

  # generate the model executable
  cmd = "make"
  system(cmd)

  unlink("*.o")

  #reset path to proj wd
  setwd(get(".rs.getProjectDirectory")())
  file.copy(from = paste0(step_daily_original,"/Stepatsec.exe"),
            to = paste0(daily_original,"/"),
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)

  #unlink(paste0(step_daily_original,"/Stepatsec.exe"))

  #reset path to proj wd
  setwd(get(".rs.getProjectDirectory")())
  # reset workdir to daily_original
  setwd(daily_original)
  # run the model
  cmd2 = "./Stepatsec"
  system(cmd2)

  # remove Stepatsec.exe from the directory
  unlink("*.exe")

  # make a directory "Output" in the path below
  #reset path to proj wd
  setwd(get(".rs.getProjectDirectory")())
  dir.create("2-outputs/Output", showWarnings = FALSE, recursive = FALSE)

  # move the *.out files to the directory created above
  # Create copy of files
  files=Sys.glob(file.path(paste0(daily_original, "/*.out")))
  file.copy(from = files,to = "2-outputs/Output/",
            overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)

  # remove .out from the directory
  unlink(files)

}





