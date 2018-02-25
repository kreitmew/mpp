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
library(shinyjs)
library(ggplot2)
library(plotly)
library(Bessel)


options(shiny.sanitize.errors = FALSE)

source('air_parameters.R')
source('init_values.R')
source('acoustic_models.R')
source('ui_routines.R')

source("panel_thickness.R", local = TRUE)
source("panel_radius.R", local = TRUE)
source("panel_porosity.R", local = TRUE)
source("panel_cavern.R", local = TRUE)
source("borders_optim.R", local = TRUE)
source("ui_tab_basic_values.R", local = TRUE)
source("ui_tab_panel_mpp.R", local = TRUE)


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
              fluidPage( uiTabBasicValues() ) ),
      
      tabItem(tabName = "mpp_cavern",
              fluidPage( uiTabPanelMPP() ) )
            )
  )  
  
)

server <- function(input, output, session) {
  
  source("ui_mpp_validation.R", local = TRUE)
  
  observeEvent(input$sbmenu, source("update_basic_values.R", local = TRUE))
  
  observeEvent(input$goButton, source("update_basic_values.R", local = TRUE))
  
  observeEvent(input$resetSA, isolate(source("reset_search_space.R", local = TRUE)))
  
  observeEvent(input$docuMPP, 
               showModal(modalDialog(
                 title = "",
                 includeMarkdown("docu_mpp.md"),
                 easyClose = TRUE,
                 footer = NULL,
                 size = "l"
               )) 
               )
  
  observeEvent(input$docuModels, 
               showModal(modalDialog(
                 title = "",
                 includeMarkdown("docu_models.md"),
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
  
  source("plot_models.R", local = TRUE)

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
  
  observeEvent(input$tabs, { isolate( source("tab_switch.R", local = TRUE) ) })

  observeEvent(input$startSA, { source("sa_routine.R", local = TRUE) })
  
}

shinyApp(ui, server)



