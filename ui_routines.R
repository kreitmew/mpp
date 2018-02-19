
placeCellPanel <- function(x.length, y.length){
   
  x.unit <- (x.length / 3)
  y.unit <- (y.length / 3)
  rect1.lb.x <- ( 0.05 - 0.3 ) * x.unit
  rect1.lb.y <- ( 0.05 - 0.0 ) * y.unit

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

  rownames(df) <- c(paste(g_dist_holes_name, " 1 - ", g_dist_holes_expl, sep = ""),
    paste(g_dist_holes_name, " 2 - ", g_dist_holes_expl, sep = ""), 
    paste(g_dist_holes_name, " 3 - ", g_dist_holes_expl, sep = ""))
  
  write.xlsx(df, file = path, sheetName = "Lochabstaende",
             col.names = FALSE, row.names = TRUE, append = TRUE) 
  
  df <- df.absorption
  colnames(df) <- c("Frequenz", "Absorptionswert")
  write.xlsx(df, file = path, sheetName = "Absorptionskennline",
             col.names = TRUE, row.names = FALSE, append = TRUE) 
  
}


calcCount <- function(l, r, lhole){
  n <- floor((l-r)/lhole + (lhole - 2*r)/lhole)
  return(n)
}

calcCoordinatesHoles <- function(l,b,r,lhole, shift){
  origin <- c(shift, 2 * r, 2 * r)
  df <- NULL
  for (i in c(1:calcCount(b, r, lhole))){
    for (j in c(1:calcCount(l, r, lhole))){
      if (is.null(df)){
        df <- origin
      } else {
        delta <- c( 0, (j-1) * lhole, (i-1) * lhole )
        df <- rbind(df, origin + delta)
      }
    }
  }
  return(df)
}


drawRectangle <- function(l, b, t, start){
  x <- rep(start,8)
  y <- c(0,l,l,l,l,0,0,0)
  z <- c(0,0,0,b,b,b,b,0)
  segments3d(x,y,z, col = "blue")
  segments3d(x+t,y,z, col = "blue")
  Vectorize(FUN = function(i){segments3d(c(x[i], x[i]+t),c(y[i], y[i]),c(z[i], z[i]), col = "blue")},
            vectorize.args = "i")(c(1,2,4,6))
}


drawTube <- function(x,y,z,r,t){
  ctr <- c(x, y, z)
  tube <- cylinder3d(center = rbind(ctr, c(ctr[1] + t, ctr[2:3])), radius = r, sides = 50)
  shade3d(tube, col = "blue", alpha=0.2)
}

drawMultipleTubes <- Vectorize(drawTube, vectorize.args = c("x", "y", "z"))

prepareInputRGL <- function(d, t, r, por){
  lhole.panel <- r * (pi / por)^0.5 
  l.panel <- 5 * max(lhole.panel) 
  b.panel <- 0.66 * l.panel
  n <- 1000
  return(list(n*l.panel, n*b.panel, n*t, n*d, n*lhole.panel, n*r))
}


generateRGLExample <- function(l.panel, b.panel, t.panel, d.panel, lhole.panel, radius.panel){
  open3d(useNULL=T)
  c.shift <- c(0, d.panel[1] + t.panel[1], d.panel[1] + t.panel[1] + d.panel[2] + t.panel[2])
  for (i in c(1,2,3)) {
    drawRectangle(l.panel, b.panel, t.panel[i], c.shift[i])
    df <- calcCoordinatesHoles(l.panel, b.panel, radius.panel[i], lhole.panel[i], c.shift[i])
    drawMultipleTubes(df[,1], df[,2], df[,3], radius.panel[i], t.panel[i])
  }
  s <- sum(d.panel) + sum(t.panel)
  drawRectangle(l.panel, b.panel, 0.01 * s, s)
  axes3d()
  title3d(xlab="X in mm", ylab="Y in mm", zlab="Z in mm")
  par3d(viewport = c(0,0,14,8), windowRect = c(0,0, 1200, 1200))
  rgl.viewpoint(userMatrix = 
                  rotationMatrix(0, 0, 0, 1) %*% rotationMatrix(pi/5, 0, 1, 0) %*% rotationMatrix(-pi/2, 1, 0, 0)
                  %*% t(translationMatrix(0,0,0)), 
                zoom = 0.8, interactive = TRUE )
  rglwidget()
}


convertListToDataFrame <- function(mpp.list){
  vec <- unlist(mpp.list)
  df <- data.frame(vec[c(1,2,3)])
  df <- cbind(df, vec[c(4,5,6)])
  df <- cbind(df, vec[c(7,8,9)])
  df <- cbind(df, vec[c(10,11,12)])
  colnames(df) <- c(g_cavern_descr,
                    g_thickness_descr,
                    g_radius_descr,
                    g_porosity_descr)
  rownames(df) <- c("Platte 1", "Platte 2", "Platte 3")
  df <- df[,c(2,3,4,1)]
  
  return(df)
}


checkInputValueGeneric <- function(lb, ub, input, type.value){
  if (is.numeric(input) == FALSE){
    return(paste("Bitte numerischen Wert (", type.value, ") eingeben!", sep =""))
  } else {
    if ( input < lb ) {
      return(paste(paste("Wert (", type.value, ") unterschreitet die Untergrenze von ", sep = ""), lb, sep =""))
    } else {
      if ( input > ub ) {
        return(paste(        paste("Wert (", type.value, ") ueberschreitet die Obergrenze von ", sep = ""), ub, sep =""))
      } else { return(NULL)  }
    }
  }
}


roundValue <- function(xmin, xmax, dx, x){
  
  l <- floor((x - xmin)/dx)
  x0 <- xmin + l*dx
  x1 <- xmin + (l+1)*dx
  if ((x - x0) < (x1 - x)) {
    x <- x0
  } else {
    x <- x1
  }
  x <- max(x0, min(x, xmax))
  return(x)
  
}


