boxPanelPorosity <- function(){
  return(
    box(
      title = g_porosity_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5(g_porosity_panel1_descr), 
                  numericInput("phi1ui", label = NULL, phi1,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5(g_porosity_panel2_descr), 
                  numericInput("phi2ui", label = NULL, phi2,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
      splitLayout(h5(g_porosity_panel3_descr), 
                  numericInput("phi3ui", label = NULL, phi3,
                               min = phimin, max = phimax, step = (phimax - phimin)/phigrid))
    ) 
  )
}

