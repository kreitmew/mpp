# air density: rho_0 
# use table from https://en.wikipedia.org/wiki/Acoustic_impedance
# air viscosity: eta
# use table from https://www.engineeringtoolbox.com/dry-air-properties-d_973.html
# use formula from http://onlinelibrary.wiley.com/doi/10.1002/9780470516430.app2/pdf
# speed of sound: c_0
# characteristic acoustic impedance of the air: Z_0
# use table from https://en.wikipedia.org/wiki/Acoustic_impedance


convertIntoKelvin <- function(Tc){
  Tk <- Tc + 273.15
  return(Tk)
}

calcDynamicViscosityAir <- function(Tc){
   Tk <- convertIntoKelvin(Tc)
   dvis <- (1.458 * (10^(-6)) * (Tk^1.5))/(Tk + 110.4)
   return(dvis)
}

calcAirDensity <- function(pda, Tc, rh){
  Md <- 0.028964
  Mv <- 0.018016
  R <- 8.314
  rho <- ( pda * Md + rh * calcVaporPressureOfWater(Tc) * Mv ) / 
         ( R * convertIntoKelvin(Tc)  )
  return(rho)
}

calcVaporPressureOfWater <- function(Tc){
# Buck equation  
  p <- (10^3) * 0.61121 * exp((18.678 - Tc/234.5)*(Tc/(Tc+257.14)))
  return(p)
}

calcSpeedOfSound <- function(Tc){
  cair <- 20.05 * (convertIntoKelvin(Tc))^(0.5)
  return(cair)
}

calcAcousticImpedanceOfAir <- function(pda, Tc, rh){
  Zair <- calcAirDensity(pda, Tc, rh) * calcSpeedOfSound(Tc)
  return(Zair)
}


