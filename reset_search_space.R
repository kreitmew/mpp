updateNumericInput(session, "valOptimCavernLowP1", label = NULL, dmin, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "valOptimCavernLowP2", label = NULL, dmin, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "valOptimCavernLowP3", label = NULL, dmin, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)

updateNumericInput(session, "valOptimThickLowP1", label = NULL, tmin, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "valOptimThickLowP2", label = NULL, tmin, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "valOptimThickLowP3", label = NULL, tmin, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)

updateNumericInput(session, "valOptimRadiusLowP1", label = NULL, rmin, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "valOptimRadiusLowP2", label = NULL, rmin, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "valOptimRadiusLowP3", label = NULL, rmin, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)

updateNumericInput(session, "valOptimPorosLowP1", label = NULL, phimin, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "valOptimPorosLowP2", label = NULL, phimin, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "valOptimPorosLowP3", label = NULL, phimin, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)

updateNumericInput(session, "valOptimCavernHighP1", label = NULL, dmax, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "valOptimCavernHighP2", label = NULL, dmax, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "valOptimCavernHighP3", label = NULL, dmax, 
                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)

updateNumericInput(session, "valOptimThickHighP1", label = NULL, tmax, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "valOptimThickHighP2", label = NULL, tmax, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "valOptimThickHighP3", label = NULL, tmax, 
                   min = tmin, max = tmax, step = (tmax - tmin)/tgrid)

updateNumericInput(session, "valOptimRadiusHighP1", label = NULL, rmax, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "valOptimRadiusHighP2", label = NULL, rmax, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "valOptimRadiusHighP3", label = NULL, rmax, 
                   min = rmin, max = rmax, step = (rmax - rmin)/rgrid)

updateNumericInput(session, "valOptimPorosHighP1", label = NULL, phimax, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "valOptimPorosHighP2", label = NULL, phimax, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "valOptimPorosHighP3", label = NULL, phimax, 
                   min = phimin, max = phimax, step = (phimax - phimin)/phigrid)