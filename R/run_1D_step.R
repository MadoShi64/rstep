
#' Run STEP model from Rstudio
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
#' run_1D_step(step_daily_original,daily_original)
#' }
#'
run_1D_step <- function(step_daily_original, daily_original) {
  project_dir <- get(".rs.getProjectDirectory")()

  # Set working directory to step_daily_original and run make
  setwd(step_daily_original)
  system("make")
  unlink("*.o")

  # Copy the executable to daily_original
  file.copy(
    from = file.path(step_daily_original, "Stepatsec.exe"),
    to = daily_original,
    overwrite = TRUE
  )

  # Set working directory to daily_original and run the executable
  setwd(daily_original)
  system("./Stepatsec")
  unlink("Stepatsec.exe")

  # Create the output directory if it doesn't exist
  output_dir <- file.path(project_dir, "2-outputs", "Output")
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Copy .out files to the output directory and delete the originals
  out_files <- Sys.glob("*.out")
  file.copy(from = out_files, to = output_dir, overwrite = TRUE)
  unlink(out_files)

  # Reset working directory to project directory
  setwd(project_dir)
}






