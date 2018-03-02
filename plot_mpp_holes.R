plot.new()

plot.window( xlim=c(0,9), ylim=c(0,9), asp = 1 )

par(lty = 2)
do.call(rect, placeCellPanel(9, 9)[[1]])
do.call(rect, placeCellPanel(9, 9)[[2]])
do.call(rect, placeCellPanel(9, 9)[[3]])


title("Plattenfronten - Porositaet massstabsgetreu")

do.call(draw.circle, do.call(placeCircles , c(list(input$phi1ui, input$r1ui), placeCellPanel(9, 9)[[1]]))[c(2,3,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi1ui, input$r1ui), placeCellPanel(9, 9)[[1]]))[c(4,5,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi1ui, input$r1ui), placeCellPanel(9, 9)[[1]]))[c(6,7,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi1ui, input$r1ui), placeCellPanel(9, 9)[[1]]))[c(8,9,1)])
text(7,2.1, paste(g_dist_holes_name," 1"), pos = 2, offset = 2.8)
text(7,1.6, g_dist_holes_expl, pos = 2, offset = -5.5)
text(7,1.1, formatC( round(input$r1ui * (pi / input$phi1ui)^0.5, digits = 8), format='f', digits=8 ) , pos = 2, offset = 1.2)

do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(2,3,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(4,5,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(6,7,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(8,9,1)])
text(7,5.1, paste(g_dist_holes_name," 2"), pos = 2, offset = 2.8)
text(7,4.6, g_dist_holes_expl, pos = 2, offset = -5.5)
text(7,4.1, formatC( round(input$r2ui * (pi / input$phi2ui)^0.5, digits = 8), format='f', digits=8 ) , pos = 2, offset = 1.2)

do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(2,3,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(4,5,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(6,7,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(8,9,1)])
text(7,8.1, paste(g_dist_holes_name," 3"), pos = 2, offset = 2.8)
text(7,7.6, g_dist_holes_expl, pos = 2, offset = -5.5)
text(7,7.1, formatC( round(input$r3ui * (pi / input$phi3ui)^0.5, digits = 8), format='f', digits=8 ) , pos = 2, offset = 1.2)


g_chart_holes <<- recordPlot()