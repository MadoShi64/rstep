#' My Hello World Function
#'
#' @param x The name of the person to say hi to
#'
#' @return The output from \code{\link{print}}
#' @export
#'
#' @examples
#' \dontrun{
#' hello("Odette")
#' }
#'
#'
hello <- function(x) {
  print(paste("Hello ",x, ", this is the world!"))
}
