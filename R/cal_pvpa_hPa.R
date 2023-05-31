#' Compute vapor pressure in hPa
#'
#' @param relative_humidity relative humidity in \%
#' @param mean_temperature is the mean temperature in deg C
#'
#' @description cal_pvap_hPa Computes vapor pressure hPa
#'
#' @return vapor pressure in hPa
#' @export
#'
#'
#' @examples
#' \dontrun{
#' cal_pvap_hPa(57,20)
#' }
#'
cal_pvap_hPa = function (relative_humidity,
                         mean_temperature){
  y = (relative_humidity/100)*(6.11*exp((17.27*mean_temperature) / (237.3 + mean_temperature)))
  return(y)
}
