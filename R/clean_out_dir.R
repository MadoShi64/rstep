#' Back up outputs of a previous simulation
#'
#' @param new_outpath the path to the folder new_output (the current directory of the outputs)
#' @param old_outpath the path to a back up folder old_output (the folder in which you want to store the outputs of the previous simulation)
#'
#' @return nothing
#' @export
#'
#' @examples
#' \dontrun{
#' new_outpath = normalizePath("2-outputs/new_output/", winslash = "/")
#' old_outpath = normalizePath("2-outputs/old_output/", winslash = "/")
#'
#' clean_out_dir(new_outpath,old_outpath)
#' }
#'
#'
clean_out_dir=function(new_outpath,
                       old_outpath){
  #move folders from new dir to old dir
  current_files = list.files(new_outpath, full.names = TRUE)
  file.copy(from = current_files, to = old_outpath, overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)

  t = list.files(path=paste0(current_files), pattern=NULL, all.files=FALSE,
                 full.names=TRUE)
  sapply(paste0(t),file.remove)
}
