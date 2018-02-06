
placeCellPanel <- function(x.length, y.length){
   
  x.unit <- (x.length / 3)
  y.unit <- (y.length / 3)
  rect1.lb.x <- 0.05 * x.unit
  rect1.lb.y <- 0.05 * y.unit

  rect1.ru.x <- rect1.lb.x + 0.9 * x.unit
  rect1.ru.y <- rect1.lb.y + 0.9 * y.unit    
  
  rect <- list(list(rect1.lb.x, rect1.lb.y, rect1.ru.x, rect1.ru.y), 
               list(rect1.lb.x, rect1.lb.y + x.unit, rect1.ru.x, rect1.ru.y + x.unit), 
               list(rect1.lb.x, rect1.lb.y + 2*x.unit, rect1.ru.x, rect1.ru.y + 2*x.unit))
  
  return(rect)
    
}


placeCircles <- function(porosity, radius, x.ld, y.ld, x.ru, y.ru){
  
  d.x <- (x.ru - x.ld)
  l <- 0.8 * d.x / (1 + 2 * (porosity / pi)^0.5)
  r <- ((porosity / pi)^0.5) * l
  
  return(list(r, x.ld + 0.5 * d.x - l/2, y.ld + 0.5 * d.x - l/2, 
                 x.ld + 0.5 * d.x + l/2, y.ld + 0.5 * d.x - l/2,
                 x.ld + 0.5 * d.x - l/2, y.ld + 0.5 * d.x + l/2,
                 x.ld + 0.5 * d.x + l/2, y.ld + 0.5 * d.x + l/2))
  
}


downloadValuesToExcel <- function(basic.values, panel.thickness, 
                                  panel.radius, panel.porosity, panel.cavern, absorption.window, 
                                  panel.hole.dist, df.absorption, path){
  
  df <- data.frame(unlist(basic.values))
  rownames(df) <- c(g_temp_descr, g_press_descr, g_humid_descr,
                    g_vpw_descr, g_sos_descr, g_dvi_descr, g_aid_descr, g_imp_descr)
  write.xlsx(df, file = path, sheetName = "Basiswerte",
               col.names = FALSE, row.names = TRUE, append = FALSE)
  
  df <- data.frame(unlist(panel.thickness))
  rownames(df) <- c(g_thickness_panel1_descr, g_thickness_panel2_descr, g_thickness_panel3_descr)
  write.xlsx(df, file = path, sheetName = g_thickness_descr,
             col.names = FALSE, row.names = TRUE, append = TRUE)
  
  df <- data.frame(unlist(panel.radius))
  rownames(df) <- c(g_radius_panel1_descr, g_radius_panel2_descr, g_radius_panel3_descr)
  write.xlsx(df, file = path, sheetName = g_radius_descr,
             col.names = FALSE, row.names = TRUE, append = TRUE) 
  
  df <- data.frame(unlist(panel.porosity))
  rownames(df) <- c(g_porosity_panel1_descr, g_porosity_panel2_descr, g_porosity_panel3_descr)
  write.xlsx(df, file = path, sheetName = g_porosity_descr,
             col.names = FALSE, row.names = TRUE, append = TRUE)   
  
  df <- data.frame(unlist(panel.cavern))
  rownames(df) <- c(g_cavern_panel1_descr, g_cavern_panel2_descr, g_cavern_panel3_descr)
  write.xlsx(df, file = path, sheetName = g_cavern_descr,
             col.names = FALSE, row.names = TRUE, append = TRUE)  
  
  df <- data.frame(unlist(absorption.window))
  rownames(df) <- c(g_absorption_window_leftEdge_descr, g_absorption_window_rightEdge_descr, 
                    g_absorption_window_thresh_descr)
  write.xlsx(df, file = path, sheetName = "Absorptionsfenster",
             col.names = FALSE, row.names = TRUE, append = TRUE) 
  
  df <- data.frame(unlist(panel.hole.dist))
  rownames(df) <- c(g_dist_holes_panel1_descr, g_dist_holes_panel2_descr, 
                    g_dist_holes_panel3_descr)
  write.xlsx(df, file = path, sheetName = "Lochabstaende",
             col.names = FALSE, row.names = TRUE, append = TRUE) 
  
  df <- df.absorption
  colnames(df) <- c("Frequenz", "Absorptionswert")
  write.xlsx(df, file = path, sheetName = "Absorptionskennline",
             col.names = TRUE, row.names = FALSE, append = TRUE) 
  
}