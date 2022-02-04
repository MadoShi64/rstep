#' Silly Printer function
#'
#' @param w what you want in the second column
#' @param x what you want int the first column
#'
#' @return A tibble
#' @export
#'
#' @importFrom tibble data_frame
#'
#' @examples
#' printer(w = rnorm(5), x = rnorm(5))
#'
#'
printer = function(w,x){
  x = data_frame(w = w, x = x)
  print(x)
  return(x)
}
