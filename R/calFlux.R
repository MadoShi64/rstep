


#' Global radiation from W to MJ
#'
#' @param x global radiation in W
#' @param unit time step (e.g. "hour" for MJ/hr, "day", "min", "quarter", "sec", "half")
#'
#' @description W_to_MJ convert radiation from W to MJ
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


#' Convert flux data to CO2 equivalent
#'
#' @param x  flux data in CO2-C or CH4-C or N2O-N
#' @param Gas unit of the gas CO2-C or CH4-C or N2O-N
#'
#' @description CH4 and N2O emissions rates can be converted to CO2 equivalents using the ‘100-yr global warming potential’ factors as follows:
#' 1 kg N2O = 298 kg CO2 equivalents. 1 kg CH4 = 25 kg CO2 equivalents.
#' Please note that, according the most recent IPCC report (IPCC, 2013),
#' the conversion of CH4 into CO2eq. should be:  1 kg CH4 = 34 kg CO2 equivalents
#' Reference cited: IPCC (2013) Climate change 2013: the physical science basis. Intergovernmental Panel on Climate Change. Available at https://www.ipcc.ch/report/ar5/wg1/
#' "1 kg CH4-C = (16/12)x1 kg CH4 = 1.33 kg CH4". "1 kg CO2-C = (44/12)x1 kg CO2 =3.67 kg CO2". "1 kg N2O-N = (44/28)*1 kg N2O = 1.57 kg N2O"
#'
#'
#' @return flux value in CO2 equivalent
#' @export
#'
#' @examples
#' \dontrun{
#' CO2equi(0.6,Gas="N2O-N")
#' }
#'
CO2equi = function (x,
                    Gas){
  # 1 kg CH4-C = (16/12)*1 kg CH4 = 1.33 kg CH4
  # 1 kg CO2-C = (44/12)*1 kg CO2 =3.67 kg CO2
  # 1 kg N2O-N = (44/28)*1 kg N2O = 1.57 kg N2O
  # CH4 and N2O emissions rates can be converted to CO2 equivalents using the ‘100-yr global warming potential’ factors as follows:
  #   1 kg N2O = 298 kg CO2 equivalents
  # 1 kg CH4 = 25 kg CO2 equivalents
  # Please note that, according the most recent IPCC report (IPCC, 2013), the conversion of CH4 into CO2eq. should be:
  #   1 kg CH4 = 34 kg CO2 equivalents
  # Reference cited:
  #   IPCC (2013) Climate change 2013: the physical science basis. Intergovernmental Panel on Climate Change. Available at https://www.ipcc.ch/report/ar5/wg1/
  if (Gas == "CH4-C"){
    y = x* 1.33 * 34
    return(y)
  }
  if (Gas == "CO2-C"){
    y = x* 3.67 * 1
    return(y)
  }
  if (Gas == "N2O-N"){
    y = x* 1.57 * 298
    return(y)
  }
}

