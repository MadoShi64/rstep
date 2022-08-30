#' Linear Scaling normalization is used when the feature is more-or-less uniformly distributed across a fixed range.
#' # https://www.indeed.com/career-advice/career-development/normalization-formula
#'
#' Linear Scaling normalization
#'
#' @param x the value in the dataset to normalize between 0 and 1
#'
#' @description creating a common scale to compare data sets with very different values
#'
#' @return the normalized x value
#' @export
#'
#' @examples
#' \dontrun{
#' norm_0_1(data$Biomass2019)
#' }
#'
norm_0_1 = function (x){

  # The normalization formula is a statistics formula that can transform a data set so that all of its variations fall between zero and one
  # This can be helpful when comparing two or more data sets with different scales
  # Applying the normalization formula lets you express data points as values from zero to one,
  # with the smallest data point having a normalized value of zero and the largest data point have a normalized value of one.
  # All the other data points have decimal values between these two, in proportion to where that data point is within the range of the data set

  # What is the normalization formula used for?
  # Normalization is useful in statistics for creating a common scale to compare data sets with very different values.
  # This normalization formula, also called scaling to a range or feature scaling, is most commonly used on data sets when
  # the upper and lower limits are known and when the data is relatively evenly distributed across that range

  xnorm = (x-min(x))/(max(x)-min(x))
  return(xnorm)
}


#' Linear Scaling Normalization formula for custom ranges
#'
#' @param x the value in the dataset to normalize between a and b
#' @param a the lowest value of the new range
#' @param b the highest value of the new range
#'
#' @description normalize a dataset with in a custom range where the lowest value is a and the highest value is b
#'
#' @return the normalized x values
#' @export
#'
#' @examples
#' \dontrun{
#' norm_a_b(data$Biomass2019)
#' }
#'
norm_a_b = function(x,a,b){
  xnorm = a +(((x-min(x))*(b-a))/(max(x)-min(x)))
  return(xnorm)
}
