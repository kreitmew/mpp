updateNumericInput(session, "d1ui", label = NULL, calc.result[[1]][[1]], min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "d2ui", label = NULL, calc.result[[1]][[2]], min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "d3ui", label = NULL, calc.result[[1]][[3]], min = dmin, max = dmax, step = (dmax - dmin)/dgrid)

updateNumericInput(session, "t1ui", label = NULL, calc.result[[2]][[1]], min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "t2ui", label = NULL, calc.result[[2]][[2]], min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "t3ui", label = NULL, calc.result[[2]][[3]], min = tmin, max = tmax, step = (tmax - tmin)/tgrid)

updateNumericInput(session, "r1ui", label = NULL, calc.result[[3]][[1]], min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "r2ui", label = NULL, calc.result[[3]][[2]], min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "r3ui", label = NULL, calc.result[[3]][[3]], min = rmin, max = rmax, step = (rmax - rmin)/rgrid)

updateNumericInput(session, "phi1ui", label = NULL, calc.result[[4]][[1]], min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "phi2ui", label = NULL, calc.result[[4]][[2]], min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "phi3ui", label = NULL, calc.result[[4]][[3]], min = phimin, max = phimax, step = (phimax - phimin)/phigrid)