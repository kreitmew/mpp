box(
  title = g_cavern_descr, 
  status = "primary", solidHeader = TRUE, width = NULL,
  splitLayout(h5(g_cavern_panel1_descr), 
              numericInput("d1ui", label = NULL, d1,
                           min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
  splitLayout(h5(g_cavern_panel2_descr), 
              numericInput("d2ui", label = NULL, d2,
                           min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
  splitLayout(h5(g_cavern_panel3_descr), 
              numericInput("d3ui", label = NULL, d3,
                           min = dmin, max = dmax, step = (dmax - dmin)/dgrid))
)