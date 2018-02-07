boxPanelThickness <- function(){
  return(
    box(
      title = g_thickness_descr, 
      status = "primary", solidHeader = TRUE, width = NULL,
      splitLayout(h5(g_thickness_panel1_descr), 
                  numericInput("t1ui", label = NULL, t1, 
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5(g_thickness_panel2_descr), 
                  numericInput("t2ui", label = NULL, t2,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
      splitLayout(h5(g_thickness_panel3_descr), 
                  numericInput("t3ui", label = NULL, t3,
                               min = tmin, max = tmax, step = (tmax - tmin)/tgrid))
    )
  )
}

