output$plotMPPModels <- renderPlotly(  generatePlotModels(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points),
                                                        g_environ = list(input$press, input$temp, input$humid/100),
                                                        g_mpp = list(list(input$d1ui, input$d2ui, input$d3ui),
                                                                     list(input$t1ui, input$t2ui, input$t3ui),
                                                                     list(input$r1ui, input$r2ui, input$r3ui),
                                                                     list(input$phi1ui, input$phi2ui, input$phi3ui)),
                                                        abs.window = list(input$leftEdge, input$rightEdge, input$thresh)) )