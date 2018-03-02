 plot(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points),
       calcAbsorptionMPPVec(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points),
                            g_environ = list(input$press, input$temp, input$humid/100),
                            g_mpp = list(list(input$d1ui/1000, input$d2ui/1000, input$d3ui/1000),
                                         list(input$t1ui/1000, input$t2ui/1000, input$t3ui/1000),
                                         list(input$r1ui/1000, input$r2ui/1000, input$r3ui/1000),
                                         list(input$phi1ui, input$phi2ui, input$phi3ui)),
                            model.fname = "calcSurfaceResistanceRuiz"),
       type = "l", xaxt="n", xlab = g_x_axis_descr, ylab = g_y_axis_descr, main = g_main_descr)


  axis(1, xaxp = c(g_lb_absorption, g_ub_absorption, 10), las =2)
  segments(input$leftEdge, 0, input$leftEdge, input$thresh, col = "red")
  segments(input$rightEdge, 0, input$rightEdge, input$thresh, col = "red")
  segments(input$leftEdge, input$thresh, input$rightEdge, input$thresh, col = "red")

  g_chart_absorption <<- recordPlot()
  