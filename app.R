library(shiny)
library(shinydashboard)
library(plotrix)
library(rlist)
library(xlsx)
library(markdown)
library(rmarkdown)
library(grDevices)
library(rgl)
library(htmlwidgets)
library(GenSA)

options(shiny.sanitize.errors = FALSE)

source('air_parameters.R')
source('init_values.R')
source('acoustic_models.R')
source('ui_routines.R')

source("panel_thickness.R", local = TRUE)
source("panel_radius.R", local = TRUE)
source("panel_porosity.R", local = TRUE)
source("panel_cavern.R", local = TRUE)


ui <- dashboardPage(
  dashboardHeader(title = "Absorptionskennlinien von Mehrschichtabsorptionselementen",
                  titleWidth = 600),
  dashboardSidebar(
    sidebarMenu(id = "sbmenu",
      menuItem("Umgebungsparameter", tabName = "env_param", icon = icon("thermometer-half")),
      menuItem("Lochplatte - Luft - 3 Schichten", tabName = "mpp_cavern", 
               icon = icon("volume-up"))
    )
  ),
  
  body <- dashboardBody(
    tabItems(
      tabItem(tabName = "env_param",
              h2("Definition von Umgebungsparametern"),
              fluidPage( source("ui_tab_basic_values.R", local = TRUE)$value ) ),
      
      tabItem(tabName = "mpp_cavern",
              fluidPage( source( "ui_tab_panel_mpp.R", local = TRUE)$value ) )
            )
  )  
  
)

server <- function(input, output, session) {
  

  observeEvent(input$sbmenu, source("update_basic_values.R", local = TRUE))
  
  observeEvent(input$goButton, source("update_basic_values.R", local = TRUE))
  
  observeEvent(input$docuMPP, 
               showModal(modalDialog(
                 title = "",
                 includeMarkdown("docu_mpp.md"),
                 easyClose = TRUE,
                 footer = NULL,
                 size = "l"
               )) 
               )
  
  observeEvent(input$resetButton, {
    updateNumericInput(session, "temp", value = Tc)
    updateNumericInput(session, "press", value = pda)
    updateNumericInput(session, "humid", value = rh * 100)
  })  
    
  observeEvent(input$resetMPPButton, source("reset_mpp_values.R", local = TRUE))    
 
  output$plotMPPGeometry <- renderPlot(source("plot_mpp_values.R", local = TRUE))
  
  output$plotMPPHoles <- renderPlot( source("plot_mpp_holes.R", local = TRUE))  
  
  output$plotMPPAbsorber <- renderPlot(source("plot_absorption.R", local = TRUE))
  
  output$downloadMPPButton <- downloadHandler(
      filename = function() {
        paste("mpp_data", ".xlsx", sep = "")
      },
      content = function(file) {
        source("download_excel.R", local = TRUE)
      }
    )
  
  output$downloadMPPcharts <- downloadHandler(
    filename = function() {
      paste("mpp_charts", ".pdf", sep = "")
    },
    content = function(file) {

      tempReport <- file.path(tempdir(), "mpp_charts.Rmd")
      file.copy("mpp_charts.Rmd", tempReport, overwrite = TRUE)
      
      params <- list(date = paste(" ", Sys.time(), sep=""), 
                     absorption = list(g_chart_values, g_chart_holes, g_chart_absorption))
      
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv()))      
      
    }
  )
  
  observeEvent(input$tabs, {
    isolate(
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
      }      
    )
  })
  

  resultText <- eventReactive(input$startSA, {

    withProgress(message = "Optimierungsberechnung laeuft.....das kann bis zu einer Minute dauern", value = 0.5, {
      calc.result <- calcSA(input$leftEdge, 
                    input$rightEdge, 
                    input$thresh, 
                    list(input$press, input$temp, input$humid/100), 
                    g_mpp = list(list(input$d1ui, input$d2ui, input$d3ui),
                                 list(input$t1ui, input$t2ui, input$t3ui),
                                 list(input$r1ui, input$r2ui, input$r3ui),
                                 list(input$phi1ui, input$phi2ui, input$phi3ui)),
                    model.fname = "calcSurfaceResistanceRuiz")
      
      isolate({ source("update_mpp_values.R", local = TRUE) })
      
      paste(toString(unlist(calc.result))," -> berechnete Werte sind in die Simulationsmaske uebernommen worden")
    })
  })
  
  output$protText <- renderText({
    resultText()
  })
  
  
}

shinyApp(ui, server)



