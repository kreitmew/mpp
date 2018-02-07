boxPanelRadius <- function(){
  
  return(
    box(
      title = g_radius_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5(g_radius_panel1_descr), 
                  numericInput("r1ui", label = NULL, r1,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5(g_radius_panel2_descr), 
                  numericInput("r2ui", label = NULL, r2,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
      splitLayout(h5(g_radius_panel3_descr), 
                  numericInput("r3ui", label = NULL, r3,
                               min = rmin, max = rmax, step = (rmax - rmin)/rgrid))
    ) 
  )
  
}

 