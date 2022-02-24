


#' Global radiation from W to MJ
#'
#' @param x global radiation in W
#' @param unit time step (e.g. "hour" for MJ/hr, "day", "min", "quarter", "sec", "half")
#'
#' @return global radiation in MJ
#' @export
#'
#' @examples
#' \dontrun{
#' W_to_MJ(566,"hour")
#' }
#'
W_to_MJ=function (x,
                  unit){
  # convert global radiation (W/m^2) to MJ/m2/hr
  # 1MJ = 1000000J and 1W = 1J/s
  # Rayglo(W/m^2) = Rayglo (J/m^2/s)f
  # Rayglo (J/m^2/s) * 3600 (sec/hr) = Rayglo (J/m^2/hr)
  # Rayglo (J/m^2/hr) / 1000000 = Rayglo (MJ/m^2/hr)
  # Rayglo (MJ/m^2/hr) = (Rayglo(w/m^2) * 3600) / 1000000
  if (unit=="hour"){
    y = (x*3600)/1000000
    return(y)
  }
  if(unit=="day"){
    y = (x*86400)/1000000
    return(y)
  }
  if(unit == "min"){
    y = (x*60)/1000000
    return(y)
  }
  if(unit == "quarter"){
    y = (x*900)/1000000
    return(y)
  }
  if(unit == "sec"){
    y = (x*1)/1000000
    return(y)
  }
  if(unit == "half"){
    y = (x*1800)/1000000
    return(y)
  }
}



#' Title Compute vapor pressure (hPa)
#'
#' @param relative_humidity relative humidity in %
#' @param mean_temperature mean temperature in deg C
#'
#' @return vapor pressure in hPa
#' @export
#'
#' @examples
#' \dontrun{
#' cal_pvap_hPa(57,20)
#' }
#'
cal_pvap_hPa = function (relative_humidity,
                         mean_temperature){
  #compute vapor pressure (hPa) from relative humidity(%) and mean temperature (degC)
  y = (relative_humidity/100)*(6.11*exp((17.27*mean_temperature) / (237.3 + mean_temperature)))
  return(y)
}
