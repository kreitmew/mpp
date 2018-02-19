if( input$tabs == "tabRGL" ){
  withProgress(message = "Die 3D-Grafik wird erzeugt bzw. aktualisiert...", value = 0.5, {
    output$rglplot <- renderRglwidget(
      do.call(generateRGLExample, 
              prepareInputRGL(c(input$d1ui, input$d2ui, input$d3ui), 
                              c(input$t1ui, input$t2ui, input$t3ui), 
                              c(input$r1ui, input$r2ui, input$r3ui), 
                              c(input$phi1ui, input$phi2ui, input$phi3ui))
      )
    )
    Sys.sleep(2)
    incProgress(1/2, detail = "...")
  })
  session$onSessionEnded(function() {
    rgl.close()
  })        
} else {
  if ( input$tabs == "tabOpt" ){
    
    source("fix_bounds_search.R", local = TRUE)        
    
    output$protValues <- renderTable(
      bordered = TRUE, 
      rownames = TRUE,
      digits = g_digit,
      caption = "<b> <span style='color:#000000'> Aktuelle Maskenwerte </b>",
      caption.placement = getOption("xtable.caption.placement", "bottom"), 
      caption.width = getOption("xtable.caption.width", NULL),
      {convertListToDataFrame(source("mpp_list.R", local = TRUE)$value)}) 
  } 
}