updateNumericInput(session, "t1ui", label = NULL, t1, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "t2ui", label = NULL, t2, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
updateNumericInput(session, "t3ui", label = NULL, t3, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)

updateNumericInput(session, "r1ui", label = NULL, r1, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "r2ui", label = NULL, r2, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
updateNumericInput(session, "r3ui", label = NULL, r3, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)

updateNumericInput(session, "phi1ui", label = NULL, phi1, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "phi2ui", label = NULL, phi2, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
updateNumericInput(session, "phi3ui", label = NULL, phi3, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)

updateNumericInput(session, "d1ui", label = NULL, d1, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "d2ui", label = NULL, d2, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
updateNumericInput(session, "d3ui", label = NULL, d3, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)

updateNumericInput(session, "thresh", g_absorption_window_thresh_descr, g_thresh, 
                   min = g_thresh_min, max = g_thresh_max, step = g_thresh_step)

updateNumericInput(session, "leftEdge", g_absorption_window_leftEdge_descr, g_leftEdge, 
                   min = g_leftEdge_min, max = g_leftEdge_max, step = g_leftEdge_step)

updateNumericInput(session, "rightEdge", g_absorption_window_rightEdge_descr, g_rightEdge, 
                   min = g_rightEdge_min, max = g_rightEdge_max, step = g_rightEdge_step)