output$plotMPPModels <- renderPlotly(  generatePlotModels(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points),
                                                        g_environ = list(input$press, input$temp, input$humid/100),
                                                        g_mpp = list(list(input$d1ui/1000, input$d2ui/1000, input$d3ui/1000),
                                                                     list(input$t1ui/1000, input$t2ui/1000, input$t3ui/1000),
                                                                     list(input$r1ui/1000, input$r2ui/1000, input$r3ui/1000),
                                                                     list(input$phi1ui, input$phi2ui, input$phi3ui)),
                                                        abs.window = list(input$leftEdge, input$rightEdge, input$thresh)) )