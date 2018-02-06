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
text(7,1.8, g_dist_holes_panel1_descr)
text(7,1.3,input$r1ui * (pi / input$phi1ui)^0.5)

do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(2,3,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(4,5,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(6,7,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(8,9,1)])
text(7,4.8, g_dist_holes_panel2_descr)
text(7,4.3,input$r2ui * (pi / input$phi2ui)^0.5)    

do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(2,3,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(4,5,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(6,7,1)])
do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(8,9,1)])
text(7,7.8, g_dist_holes_panel3_descr)
text(7,7.3,input$r3ui * (pi / input$phi3ui)^0.5)