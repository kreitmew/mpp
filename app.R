library(shinydashboard)
library(plotrix)
library(rlist)
library(xlsx)
library(markdown)

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
              fluidPage(
                fluidRow(
                  column(width = 5,
                         h3(),
                         numericInput("temp", g_temp_descr, Tc),
                         numericInput("press", g_press_descr, pda),
                         numericInput("humid", g_humid_descr, rh * 100),
                         tags$head(
                           tags$style(HTML('#resetButton{background-color:rgb(153, 230, 153)}'))
                         ),                           
                         actionButton("resetButton", "Ruecksetzen auf Standardwerte", 
                                      col = "green")
                         ),
                  column(width = 5,
                         fluidRow(
                           h3(),
                           tags$head(
                             tags$style(HTML('#goButton{background-color:rgb(0, 191, 255)}'))
                           ),
                           actionButton("goButton", "Abhaengige Werte berechnen / aktualisieren",
                                        col = "blue"),
                           br(), br(), br(),
                           infoBoxOutput("infoBoxVaporPressure", width = 9),
                           infoBoxOutput("infoBoxSpeedOfSound", width = 9),
                           infoBoxOutput("infoBoxViscosity", width = 9),
                           infoBoxOutput("infoBoxAirDensity", width = 9),
                           infoBoxOutput("infoBoxImpedance", width = 9)
                           )
                         )
                )
              )
              
      ),
      
      tabItem(tabName = "mpp_cavern",
              tags$head(
                tags$style(HTML('#resetMPPButton{background-color:rgb(153, 230, 153)}')),
                tags$style(type='text/css', "#resetMPPButton { width:75%; margin-top: 25px;}"),
                tags$style(HTML('#downloadMPPButton{background-color:rgb(255, 128, 128)}')),
                tags$style(type='text/css', "#downloadMPPButton { width:75%; margin-top: 25px;}"),
                tags$style(HTML('#docuMPP{background-color:rgb(255, 214, 153)}')),
                tags$style(type='text/css', "#docuMPP { width:75%; margin-top: 25px;}")                
              ),     
               
              splitLayout(h2("Mehrschichtsystem Mikrolochplatte - Luftkaverne"), 
                          downloadButton("downloadMPPButton", "Werte herunterladen (Excel)"),
                          actionButton("resetMPPButton", "Ruecksetzen auf Vorschlagswerte"),
                          cellWidths = c("50%", "20%", "30%"),
                          cellArgs = list(align="center")),
              br(),
              splitLayout(actionButton("docuMPP", "Dokumentation"),
                          numericInput("thresh", g_absorption_window_thresh_descr, g_thresh, 
                                       min = g_thresh_min, max = g_thresh_max, step = g_thresh_step),
                          numericInput("leftEdge", g_absorption_window_leftEdge_descr, g_leftEdge, 
                                       min = g_leftEdge_min, max = g_leftEdge_max, step = g_leftEdge_step),
                          numericInput("rightEdge", g_absorption_window_rightEdge_descr, g_rightEdge, 
                                       min = g_rightEdge_min, max = g_rightEdge_max, step = g_rightEdge_step),                          
                          cellWidths = c("13%", "27%", "28%", "32%"),
                          cellArgs = list(align="center")),
              
              fluidPage(
                fluidRow(
                  column(width = 3, boxPanelThickness()),
                  column(width = 3, boxPanelRadius()),
                  column(width = 3, boxPanelPorosity()),
                  column(width = 3, boxPanelCavern())      
                ),
                fluidRow(
                  column(width = 4, plotOutput('plotMPPGeometry')),
                  column(width = 4, plotOutput('plotMPPHoles')),                  
                  column(width = 4, plotOutput('plotMPPAbsorber'))
                )
              )
      )
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
        downloadValuesToExcel(list(input$temp, input$press, input$humid, 
                                   g_vpw, g_sos, g_dvi, g_aid, g_imp),
                              list(input$t1ui, input$t2ui, input$t3ui), 
                              list(input$r1ui, input$r2ui, input$r3ui),
                              list(input$phi1ui, input$phi2ui, input$phi3ui),
                              list(input$d1ui, input$d2ui, input$d3ui),
                              list(input$leftEdge, input$rightEdge, input$thresh),
                              list(input$r1ui * (pi / input$phi1ui)^0.5, 
                                   input$r2ui * (pi / input$phi2ui)^0.5, 
                                   input$r3ui * (pi / input$phi3ui)^0.5),
                              cbind(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points), 
                              calcAbsorptionMPPVec(seq(g_lb_absorption, g_ub_absorption, by = g_no_of_calc_points), 
                                                   g_environ = list(input$press, input$temp, input$humid/100), 
                                                   g_mpp = list(list(input$d1ui, input$d2ui, input$d3ui), 
                                                                list(input$t1ui, input$t2ui, input$t3ui), 
                                                                list(input$r1ui, input$r2ui, input$r3ui), 
                                                                list(input$phi1ui, input$phi2ui, input$phi3ui)),
                                                   model.fname = "calcSurfaceResistanceRuiz")),
                              file)
      }
    )
  
    
}

shinyApp(ui, server)



