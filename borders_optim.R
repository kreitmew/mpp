boxPanelOptimThickness1 <- function(){
  return(
    box(
      title = g_thickness_panel1_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valThickLowP1", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valThickHighP1", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimThickLowP1", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimThickHighP1", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid))
    )
  )
}

boxPanelOptimThickness2 <- function(){
  return(
    box(
      title = g_thickness_panel2_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valThickLowP2", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valThickHighP2", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimThickLowP2", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimThickHighP2", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid))
    )
  )
}

boxPanelOptimThickness3 <- function(){
  return(
    box(
      title = g_thickness_panel3_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valThickLowP3", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valThickHighP3", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimThickLowP3", label = NULL, tmin, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimThickHighP3", label = NULL, tmax,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid))
    )
  )
}

boxPanelOptimRadius1 <- function(){
  return(
    box(
      title = g_radius_panel1_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valRadiusLowP1", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valRadiusHighP1", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimRadiusLowP1", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimRadiusHighP1", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid))
    )
  )
}


boxPanelOptimRadius2 <- function(){
  return(
    box(
      title = g_radius_panel2_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valRadiusLowP2", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valRadiusHighP2", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimRadiusLowP2", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimRadiusHighP2", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid))
    )
  )
}

boxPanelOptimRadius3 <- function(){
  return(
    box(
      title = g_radius_panel3_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valRadiusLowP3", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valRadiusHighP3", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimRadiusLowP3", label = NULL, rmin, 
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimRadiusHighP3", label = NULL, rmax,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid))
    )
  )
}

boxPanelOptimPoros1 <- function(){
  return(
    box(
      title = g_porosity_panel1_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valPorosLowP1", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valPorosHighP1", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimPorosLowP1", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimPorosHighP1", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid))
    )
  )
}

boxPanelOptimPoros2 <- function(){
  return(
    box(
      title = g_porosity_panel2_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valPorosLowP2", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valPorosHighP2", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimPorosLowP2", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimPorosHighP2", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid))
    )
  )
}

boxPanelOptimPoros3 <- function(){
  return(
    box(
      title = g_porosity_panel3_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valPorosLowP3", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valPorosHighP3", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimPorosLowP3", label = NULL, phimin, 
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimPorosHighP3", label = NULL, phimax,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid))
    )
  )
}

boxPanelOptimCavern1 <- function(){
  return(
    box(
      title = g_cavern_panel1_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valCavernLowP1", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valCavernHighP1", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimCavernLowP1", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimCavernHighP1", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid))
    )
  )
}

boxPanelOptimCavern2 <- function(){
  return(
    box(
      title = g_cavern_panel2_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valCavernLowP2", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valCavernHighP2", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimCavernLowP2", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimCavernHighP2", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid))
    )
  )
}

boxPanelOptimCavern3 <- function(){
  return(
    box(
      title = g_cavern_panel3_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5("UG (fest)"),
                  useShinyjs(),
                  numericInput("valCavernLowP3", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG (fest)"), 
                  useShinyjs(),
                  numericInput("valCavernHighP3", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("UG"),
                  numericInput("valOptimCavernLowP3", label = NULL, dmin, 
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
      splitLayout(h5("OG"), 
                  numericInput("valOptimCavernHighP3", label = NULL, dmax,
                               min = dmin, max = dmax, step = (dmax - dmin)/dgrid))
    )
  )
}

