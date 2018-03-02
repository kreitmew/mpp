withProgress(message = "Optimierungsberechnung laeuft.....das kann bis zu mehrere Minuten dauern", value = 0.5, {
  
  r.message <<- "<b> <span style='color:#000000'> Diese berechneten Werte sind in die Simulationsmaske uebernommen worden. </b>"
  
  calc.result <- tryCatch({calcSA(input$leftEdge, 
                                  input$rightEdge, 
                                  input$thresh, 
                                  list(input$press, input$temp, input$humid/100), 
                                  g_mpp = list(list(input$d1ui/1000, input$d2ui/1000, input$d3ui/1000),
                                       list(input$t1ui/1000, input$t2ui/1000, input$t3ui/1000),
                                       list(input$r1ui/1000, input$r2ui/1000, input$r3ui/1000),
                                       list(input$phi1ui, input$phi2ui, input$phi3ui)),
                                  model.fname = "calcSurfaceResistanceRuiz",
                                  lower = c(c(input$valOptimCavernLowP1/1000, input$valOptimCavernLowP2/1000, input$valOptimCavernLowP3/1000), 
                                            c(input$valOptimThickLowP1/1000, input$valOptimThickLowP2/1000, input$valOptimThickLowP3/1000),
                                            c(input$valOptimRadiusLowP1/1000, input$valOptimRadiusLowP2/1000, input$valOptimRadiusLowP3/1000),
                                            c(input$valOptimPorosLowP1, input$valOptimPorosLowP2, input$valOptimPorosLowP3)),
                                  upper = c(c(input$valOptimCavernHighP1/1000, input$valOptimCavernHighP2/1000, input$valOptimCavernHighP3/1000),
                                            c(input$valOptimThickHighP1/1000, input$valOptimThickHighP2/1000, input$valOptimThickHighP3/1000),
                                            c(input$valOptimRadiusHighP1/1000, input$valOptimRadiusHighP2/1000, input$valOptimRadiusHighP3/1000),
                                            c(input$valOptimPorosHighP1, input$valOptimPorosHighP2, input$valOptimPorosHighP3)))},
                          error = function(e){
                            r.message <<- "<b> <span style='color:#000000'> Es trat ein Fehler bei der Berechnung auf. Die bisherigen Maskenwerte
                            werden beibehalten. Ggf. versuchen Sie es erneut mit einem anderen Absorptionsfenster. 
                            Pruefen Sie auch nach, ob bei den Parametern zur Suchraumeinschraenkung alle Werte
                            positiv und numerisch sind, sich innerhalb der fest eingestellten Ober- und
                            Untergrenzen bewegen und immer UG echt kleiner OG ist. </b>"
                            return(source("mpp_list.R", local = TRUE)$value)
                          })
  showNotification(paste("Berechnung beendet. ", calc.result$message, sep=""), duration = 2)
  
  isolate({ source("update_mpp_values.R", local = TRUE) })
  
  isolate({
    output$protValues <- renderTable(
      bordered = TRUE, 
      rownames = TRUE,
      digits = g_digit,
      caption = r.message,
      caption.placement = getOption("xtable.caption.placement", "bottom"), 
      caption.width = getOption("xtable.caption.width", NULL),
      {convertListToDataFrame(calc.result)})        
  })
  
})