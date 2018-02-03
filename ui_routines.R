
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