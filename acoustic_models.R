
iunit <- complex(real = 0, imaginary = 1)


convertIntoKelvin <- function(Tc){
  Tk <- Tc + 273.15
  return(Tk)
}


calcOmega <- function(f){
  return(2 * pi * f)
}

calcBeta <- function(f, Tc){
  return(calcOmega(f) / calcSpeedOfSound(Tc))
}

calcSurfaceResistance <- function(pda, Tc, rh, f, r, t, phi){
  Rs <- (0.5 * calcDynamicViscosityAir(Tc) * calcOmega(f) * calcAirDensity(pda, Tc, rh))^(0.5)
  ee <- 0.48 * r * (pi)^0.5
  zmpp <- (t + 2 * ee) * ( complex(r = 1, i = 1) * 2 * Rs / (phi * r) + 
                             iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) / phi  )
  return(zmpp)
}

calcSurfaceResistanceRuiz <- function(pda, Tc, rh, f, r, t, phi){
  Rs <- (0.5 * calcDynamicViscosityAir(Tc) * calcOmega(f) * calcAirDensity(pda, Tc, rh))^(0.5)
  ee <- 0.425 * (2 * r) * (1 - 1.14 * phi^0.5)
  zmpp <- (t + 2 * ee) * ( complex(r = 1, i = 1) * 4 * Rs / (phi * (2 * r)) + 
                             iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) / phi  )
  return(zmpp)
}


# calcSurfaceResistanceAtallaSgard <- function(pda, Tc, rh, f, r, t, phi){
#   
#   number.prandtl <- 0.718
#   gamma <- 1.4
#   e <- 0.425 * (2 * r) * (1 - 1.14 * phi^0.5)
#   alpha.inf <- 1 + ( 2 * e ) / t
#   sigma <- 8 * calcDynamicViscosityAir(Tc) / (phi * r * r)
#   root <- sqrt(1 + iunit * 4 * calcOmega(f) * calcAirDensity(pda, Tc, rh) *
#                  alpha.inf * alpha.inf * calcDynamicViscosityAir(Tc) / (( sigma * phi * r )^2) )
# 
#   bulk <- sqrt(1 + iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) *
#                  number.prandtl * r * r / (16 * calcDynamicViscosityAir(Tc)) )
# 
# 
#   rho <- ( ( calcAirDensity(pda, Tc, rh) * alpha.inf) ) *
#     ( 1 + root * sigma * phi / ( iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) * alpha.inf ) )
# 
#   modul.inner.bracket <- (1 + iunit * calcAirDensity(pda, Tc, rh) * calcOmega(f) * 
#                             number.prandtl * r * r / ( 16 * calcDynamicViscosityAir(Tc) ))
#   
#   modul.outer.bracket <- 1 + 8 * calcDynamicViscosityAir(Tc) * sqrt(modul.inner.bracket) / 
#     ( iunit * r * r * number.prandtl * calcAirDensity(pda, Tc, rh) * calcOmega(f) )
#     
#   modul <- gamma * pda / ( gamma - (gamma - 1) / modul.outer.bracket )
# 
#   zmpp <- sqrt(rho * modul)
#   return(zmpp)
#   
# }


calcSurfaceResistanceAtallaSgardSimple <- function(pda, Tc, rh, f, r, t, phi){
  
  e <- 0.425 * (2 * r) * (1 - 1.14 * phi^0.5)
  alpha.inf <- 1 + ( 2 * e ) / t
  sigma <- 8 * calcDynamicViscosityAir(Tc) / (phi * r * r)
  
  root <- sqrt(1 + iunit * 4 * calcOmega(f) * calcAirDensity(pda, Tc, rh) *
                 alpha.inf * alpha.inf * calcDynamicViscosityAir(Tc) / (( sigma * phi * r )^2) )
  
  rho <- ( ( calcAirDensity(pda, Tc, rh) * alpha.inf) ) *
    ( 1 + root * sigma * phi / ( iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) * alpha.inf ) )
  
  zmpp <- iunit * rho * t * calcOmega(f) / phi
  return(zmpp)
  
}


calcSurfaceResistanceMaaExact <- function(pda, Tc, rh, f, r, t, phi){
  
  d <- 2*r
  s <- d * sqrt(calcOmega(f) * calcAirDensity(pda, Tc, rh) / (4 *  calcDynamicViscosityAir(Tc)))
  eps <- sqrt(phi)
  b.arg <- s * sqrt(-1 * iunit)
  bracket <- 1 - (2 / (s * sqrt(iunit))) * BesselK(b.arg, 1) / BesselK(b.arg, 0) 
  
  zmpp <- sqrt(2) * calcDynamicViscosityAir(Tc) * s / ( phi * d ) +
          (iunit * calcOmega(f) * calcAirDensity(pda, Tc, rh) / phi) *
          ( 0.85 * d / calcFokFunction(eps) +
              t / bracket )
  
  return(zmpp)
  
}



calcFokFunction <- function(eps){
  
  fok <- 1 - 1.4092 * eps + 0.33818 * eps^3 + 0.06793 * eps^5 - 
             0.02287 * eps^6 + 0.03015 * eps^7  - 0.01641 * eps^8
  fok <- 1/fok
  return(fok)
  
}



calcImpedanceBackedMPP <- function(pda, Tc, rh, f, d, Zs){
  beta <- calcBeta(f, Tc)
  Z <- calcAcousticImpedanceOfAir(pda, Tc, rh)
  numerator <- Zs * cos(beta * d) + iunit * Z * sin(beta * d)
  denominator <- Z * cos(beta * d) + iunit * Zs * sin(beta * d)
  Zcav <- Z * ( numerator / denominator )
  return(Zcav)
}


calcImpedanceMPP <- function(f, g_environ, g_mpp, model.fname){
  Zcav3 <- complex(real = 0, 
                   imaginary = -1 * calcAcousticImpedanceOfAir(g_environ[[1]], g_environ[[2]], g_environ[[3]]) 
                                  * (tan(g_mpp[[1]][[3]] * calcBeta(f, g_environ[[2]])))^-1)
  
  Zmpp3 <- do.call(model.fname, list(g_environ[[1]], g_environ[[2]], g_environ[[3]], 
                                      f, g_mpp[[3]][[3]], g_mpp[[2]][[3]], g_mpp[[4]][[3]]))
  
  ZS3 <- Zcav3 + Zmpp3
  Zcav2 <- calcImpedanceBackedMPP(g_environ[[1]], g_environ[[2]], g_environ[[3]], 
                                  f, g_mpp[[1]][[2]], ZS3)

  Zmpp2 <- do.call(model.fname, list(g_environ[[1]], g_environ[[2]], g_environ[[3]], 
                                 f, g_mpp[[3]][[2]], g_mpp[[2]][[2]], g_mpp[[4]][[2]]))  
  
  ZS2 <- Zcav2 + Zmpp2
  Zcav1 <- calcImpedanceBackedMPP(g_environ[[1]], g_environ[[2]], g_environ[[3]], 
                                  f, g_mpp[[1]][[1]], ZS2)
  
  Zmpp1 <- do.call(model.fname, list(g_environ[[1]], g_environ[[2]], g_environ[[3]], 
                                 f, g_mpp[[3]][[1]], g_mpp[[2]][[1]], g_mpp[[4]][[1]]))
  
  ZS1 <- Zcav1 + Zmpp1
  return(ZS1)
}


calcAbsorptionMPP <- function(f, g_environ, g_mpp, model.fname){
  Z <- calcImpedanceMPP(f, g_environ, g_mpp, model.fname)
  Zair <- calcAcousticImpedanceOfAir(g_environ[[1]], g_environ[[2]], g_environ[[3]])
  R <- (Z - Zair) / (Z + Zair)
  alpha <- 1 - (Re(R)^2 + Im(R)^2)
  return(alpha)
}

calcAbsorptionMPPVec <- Vectorize(calcAbsorptionMPP, vectorize.args = "f")

calcAbsorptionMPPVecModels <- Vectorize(calcAbsorptionMPPVec, vectorize.args = "model.fname")


minIntegrandSA <- function(f, f0, f1, A, g_environ, g_mpp, model.fname){
  integrand <- 0
  if ((f >= f0) & (f <= f1)){
    integrand <- max(A - calcAbsorptionMPP(f, g_environ, g_mpp, model.fname), 0)
  }
  return(integrand)
}

minSA <- function(f0, f1, A, g_environ, g_mpp, model.fname){
  f.helper <- function(f){
    minIntegrandSA(f, f0, f1, A, g_environ, g_mpp, model.fname)
  }
  return(integrate(Vectorize(f.helper), lower = f0, upper = f1)$value)
}

convertIntoList <- function(arg){
  mpp_arg <- list(list(arg[1], arg[2], arg[3]),
                  list(arg[4], arg[5], arg[6]),
                  list(arg[7], arg[8], arg[9]),
                  list(arg[10], arg[11], arg[12]))
  return(mpp_arg)
}


calcSA <- function(f0, f1, A, g_environ, g_mpp, model.fname, lower, upper){

  if ( checkMPPParametersOnError(lower, upper) == FALSE ) {
    stop()
  }
  
  f.optim <- function(arg){
    return(minSA(f0, f1, A, g_environ, convertIntoList(arg), model.fname))
  }
  
  out.GenSA <- GenSA(par = unlist(g_mpp), 
                     fn = f.optim,
                     lower = lower, 
                     upper = upper,
                     control=list(max.call = 1e2, seed = -11))
  
  out.GenSA$par[c(1,2,3)] <- Vectorize(roundValue, 
                                       vectorize.args = c("x"))(dmin, dmax, (dmax - dmin)/dgrid, 1000 * out.GenSA$par[c(1,2,3)])
  out.GenSA$par[c(4,5,6)] <- Vectorize(roundValue, 
                                       vectorize.args = c("x"))(tmin, tmax, (tmax - tmin)/tgrid, 1000 * out.GenSA$par[c(4,5,6)])
  out.GenSA$par[c(7,8,9)] <- Vectorize(roundValue, 
                                       vectorize.args = c("x"))(rmin, rmax, (rmax - rmin)/rgrid, 1000 * out.GenSA$par[c(7,8,9)])
  out.GenSA$par[c(10,11,12)] <- Vectorize(roundValue, 
                                       vectorize.args = c("x"))(phimin, phimax, (phimax - phimin)/phigrid, out.GenSA$par[c(10,11,12)])  
    
  return(convertIntoList(out.GenSA$par))
}


checkMPPParametersOnError <- function(lower, upper){
  
  val.check.min <- function(min, value){
    if (value >= min) { return(TRUE)  } else { return(FALSE) }
  }
  val.check.max <- function(max, value){
    if (value <= max) { return(TRUE)  } else { return(FALSE) }
  }
  val.check.min.list <- Vectorize(val.check.min, vectorize.args = c("value"))
  val.check.max.list <- Vectorize(val.check.max, vectorize.args = c("value"))

  return(
    as.logical(prod(c(
      as.logical(prod(val.check.min.list(dmin/1000, lower[c(1,2,3)]))),
      as.logical(prod(val.check.min.list(tmin/1000, lower[c(4,5,6)]))),
      as.logical(prod(val.check.min.list(rmin/1000, lower[c(7,8,9)]))),
      as.logical(prod(val.check.min.list(phimin, lower[c(10,11,12)]))),
      as.logical(prod(val.check.max.list(dmax/1000, upper[c(1,2,3)]))),
      as.logical(prod(val.check.max.list(tmax/1000, upper[c(4,5,6)]))),
      as.logical(prod(val.check.max.list(rmax/1000, upper[c(7,8,9)]))),
      as.logical(prod(val.check.max.list(phimax, upper[c(10,11,12)])))
    )))
  )
}


