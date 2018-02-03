usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}

usePackage("shinydashboard")
usePackage("plotrix")
usePackage("rlist")

source('air_parameters.R')
source('init_values.R')
source('acoustic_models.R')
source('ui_routines.R')


ui <- dashboardPage(
  dashboardHeader(title = "Absorptionskennlinien von Mehrschichtabsorptionselementen",
                  titleWidth = 600),
  dashboardSidebar(
    sidebarMenu(
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
                         numericInput("temp", "Temperatur in Grad Celsius:", Tc),
                         numericInput("press", "Luftdruck in Pascal:", pda),
                         numericInput("humid", "Relative Luftfeuchte in Prozent:", rh * 100),
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
                tags$style(HTML('#resetMPPButton{background-color:rgb(153, 230, 153)}'))
              ),     
              tags$style(type='text/css', "#resetMPPButton { width:80%; margin-top: 25px;}"),
              splitLayout(h2("Mehrschichtsystem Mikrolochplatte - Luftkaverne"), 
                          actionButton("resetMPPButton", "Ruecksetzen auf Vorschlagswerte"),
                          cellWidths = c("70%", "30%"),
                          cellArgs = list(align="center")),
              br(),
              splitLayout(numericInput("thresh", "Oberkante Absorptionsfenster [0.1 bis 0.95]:", 0.8, 
                                       min = 0.1, max = 0.95, step = 0.01),
                          numericInput("leftEdge", "Linke Kante Absorptionsfenster [50 Hz bis 1000 Hz]:", 350, 
                                       min = 50, max = 1000, step = 5),
                          numericInput("rightEdge", "Rechte Kante Absorptionsfenster [1100 Hz bis 4000 Hz]:", 2500, 
                                       min = 1100, max = 4000, step = 10),                          
                          cellWidths = c("33%", "33%", "34%"),
                          cellArgs = list(align="center")),
              
              fluidPage(
                fluidRow(
                  column(width = 3,
                         box(
                           title = "Dicke der Lochplatten in m", 
                           status = "primary", solidHeader = TRUE, width = NULL,
                           splitLayout(h5("Dicke - Platte 1:"), 
                                       numericInput("t1ui", label = NULL, t1, 
                                                    min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
                           splitLayout(h5("Dicke - Platte 2:"), 
                                       numericInput("t2ui", label = NULL, t2,
                                                    min = tmin, max = tmax, step = (tmax - tmin)/tgrid)),
                           splitLayout(h5("Dicke - Platte 3:"), 
                                       numericInput("t3ui", label = NULL, t3,
                                                    min = tmin, max = tmax, step = (tmax - tmin)/tgrid))
                         )
                         ),
                  column(width = 3,
                         box(
                           title = "Radius der Loecher in m", 
                           status = "primary", solidHeader = TRUE, width = NULL,
                           splitLayout(h5("Lochradius - Platte 1:"), 
                                       numericInput("r1ui", label = NULL, r1,
                                                    min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
                           splitLayout(h5("Lochradius - Platte 2:"), 
                                       numericInput("r2ui", label = NULL, r2,
                                                    min = rmin, max = rmax, step = (rmax - rmin)/rgrid)),
                           splitLayout(h5("Lochradius - Platte 3:"), 
                                       numericInput("r3ui", label = NULL, r3,
                                                    min = rmin, max = rmax, step = (rmax - rmin)/rgrid))
                         )                                                  
                         ),
                  column(width = 3,
                         box(
                           title = "Porositaet [1 = 100%]", 
                           status = "primary", solidHeader = TRUE, width = NULL,
                           splitLayout(h5("Porositaet - Platte 1:"), 
                                       numericInput("phi1ui", label = NULL, phi1,
                                                    min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
                           splitLayout(h5("Porositaet - Platte 2:"), 
                                       numericInput("phi2ui", label = NULL, phi2,
                                                    min = phimin, max = phimax, step = (phimax - phimin)/phigrid)),
                           splitLayout(h5("Porositaet - Platte 3:"), 
                                       numericInput("phi3ui", label = NULL, phi3,
                                                    min = phimin, max = phimax, step = (phimax - phimin)/phigrid))
                         )               
                         ),
                  column(width = 3,
                        box(
                          title = "Dicke der Luftkavernen in m", 
                          status = "primary", solidHeader = TRUE, width = NULL,
                          splitLayout(h5("Dicke - Kaverne 1:"), 
                                      numericInput("d1ui", label = NULL, d1,
                                                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
                          splitLayout(h5("Dicke - Kaverne 2:"), 
                                      numericInput("d2ui", label = NULL, d2,
                                                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid)),
                          splitLayout(h5("Dicke - Kaverne 3:"), 
                                      numericInput("d3ui", label = NULL, d3,
                                                   min = dmin, max = dmax, step = (dmax - dmin)/dgrid))
                        ))      
                  
                ),
                fluidRow(
                  column(width = 4,
                         plotOutput('plotMPPGeometry')
                         ),
                  column(width = 4,
                         plotOutput('plotMPPHoles')
                  ),                  
                  column(width = 4,
                         plotOutput('plotMPPAbsorber')
                  )
                    
                )
              )
      )
    )
  )  
  
  
  
  
)

server <- function(input, output, session) {

  observeEvent(input$goButton, {
    
    g_vpw <<- round(calcVaporPressureOfWater(input$temp), digits = 0)
    g_sos <<- round(calcSpeedOfSound(input$temp), digits = 0)
    g_dvi <<- round(calcDynamicViscosityAir(input$temp)*10^5, digits = 3)
    g_aid <<- round(calcAirDensity(input$press, input$temp, input$humid/100), digits = 3)
    g_imp <<- round(calcAcousticImpedanceOfAir(input$press, input$temp, input$humid/100), digits = 1)
      
    output$infoBoxVaporPressure <- renderInfoBox({
      infoBox(value = g_vpw, title = "Saettigungsdampfdruck in Pascal", 
              icon = icon("dashboard", lib = "glyphicon"), width = 10)
    })    

    output$infoBoxSpeedOfSound <- renderInfoBox({
      infoBox(value = g_sos, title = "Schallgeschwindigkeit in m/s", 
              icon = icon("volume-up", lib = "font-awesome"), width = 10)
    })

    output$infoBoxViscosity <- renderInfoBox({
      infoBox(value = g_dvi, title = "Viskositaet in 10hoch5 kg/(m s)", 
              icon = icon("google-wallet", lib = "font-awesome"), width = 10)
    })        

    output$infoBoxAirDensity <- renderInfoBox({
      infoBox(value = g_aid, title = "Luftdichte in kg / mhoch3", 
              icon = icon("cloud", lib = "font-awesome"), width = 10)
    }) 
    
    output$infoBoxImpedance <- renderInfoBox({
      infoBox(value = g_imp, title = "Impedanz der Luft in kg / s mhoch2", 
              icon = icon("backward", lib = "font-awesome"), width = 10)
    }) 
    
  })


  observeEvent(input$resetButton, {

    updateNumericInput(session, "temp", value = Tc)
    updateNumericInput(session, "press", value = pda)
    updateNumericInput(session, "humid", value = rh * 100)
    
  })  
  
    
  observeEvent(input$resetMPPButton, {
    
    updateNumericInput(session, "t1ui", label = NULL, t1, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
    updateNumericInput(session, "t2ui", label = NULL, t2, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
    updateNumericInput(session, "t3ui", label = NULL, t3, min = tmin, max = tmax, step = (tmax - tmin)/tgrid)
    
    updateNumericInput(session, "r1ui", label = NULL, r1, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
    updateNumericInput(session, "r2ui", label = NULL, r2, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)
    updateNumericInput(session, "r3ui", label = NULL, r3, min = rmin, max = rmax, step = (rmax - rmin)/rgrid)

    updateNumericInput(session, "phi1ui", label = NULL, phi1, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
    updateNumericInput(session, "phi2ui", label = NULL, phi2, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
    updateNumericInput(session, "phi3ui", label = NULL, phi3, min = phimin, max = phimax, step = (phimax - phimin)/phigrid)
    
    updateNumericInput(session, "d1ui", label = NULL, d1, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
    updateNumericInput(session, "d2ui", label = NULL, d2, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
    updateNumericInput(session, "d3ui", label = NULL, d3, min = dmin, max = dmax, step = (dmax - dmin)/dgrid)
    
    updateNumericInput(session, "thresh", "Oberkante Absorptionsfenster [0.1 bis 0.95]:", 0.8, 
                 min = 0.1, max = 0.95, step = 0.01)
    
    updateNumericInput(session, "leftEdge", "Linke Kante Absorptionsfenster [50 Hz bis 1000 Hz]:", 350, 
                 min = 50, max = 1000, step = 5)
    
    updateNumericInput(session, "rightEdge", "Rechte Kante Absorptionsfenster [1100 Hz bis 4000 Hz]:", 2500, 
                 min = 1100, max = 4000, step = 10)
    
    
  })    
 

  output$plotMPPGeometry <- renderPlot({

    plot.new()
    
    plot.window( xlim=c(0,(input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui)), 
                 ylim=c(0,10))
    
    segments(0, 0, 0, 10, col = "black", lty = 2)
    segments(input$t1ui, 0, input$t1ui, 10, col = "black", lty = 2)
    segments(0, 0, input$t1ui, 0, col = "black", lty = 1)
    segments(0, 10, input$t1ui, 10, col = "black", lty = 1)
    
    segments(input$d1ui + input$t1ui, 0, input$d1ui + input$t1ui, 10, col = "black", lty = 2)
    segments(input$d1ui + input$t1ui + input$t2ui, 0, input$d1ui + input$t1ui + input$t2ui, 10, col = "black", lty = 2)
    segments(input$d1ui + input$t1ui, 0, input$d1ui + input$t1ui + input$t2ui, 0, col = "black", lty = 1)
    segments(input$d1ui + input$t1ui, 10, input$d1ui + input$t1ui + input$t2ui, 10, col = "black", lty = 1)
    
    segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 0, 
             input$d1ui + input$t1ui + input$d2ui + input$t2ui, 10, col = "black", lty = 2)
    segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 0, 
             input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 10, col = "black", lty = 2)    
    segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 0, 
             input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 0, col = "black", lty = 2)    
    segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 10, 
             input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 10, col = "black", lty = 2)        
    
    segments(input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui, 0, 
             input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui, 10, lty = 1, lwd = 2)
        
    axis( side=1 )
    title("Systemaufbau - Querschnitt - massstabsgetreu")
    

    
    
  })
  
  
  output$plotMPPHoles <- renderPlot({
    
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
    text(7,1.8, "Platte 1 - Lochabstand in m: ")
    text(7,1.3,input$r1ui * (pi / input$phi1ui)^0.5)
    
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(2,3,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(4,5,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(6,7,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi2ui, input$r2ui), placeCellPanel(9, 9)[[2]]))[c(8,9,1)])
    text(7,4.8, "Platte 2 - Lochabstand in m: ")
    text(7,4.3,input$r2ui * (pi / input$phi2ui)^0.5)    
    
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(2,3,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(4,5,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(6,7,1)])
    do.call(draw.circle, do.call(placeCircles , c(list(input$phi3ui, input$r3ui), placeCellPanel(9, 9)[[3]]))[c(8,9,1)])
    text(7,7.8, "Platte 3 - Lochabstand in m: ")
    text(7,7.3,input$r3ui * (pi / input$phi3ui)^0.5)
    
    

  })  
  
  
  
  
    output$plotMPPAbsorber <- renderPlot({
      plot(seq(100, 4500, by = 50), calcAbsorptionMPPVec(seq(100, 4500, by = 50), 
           g_environ = list(input$press, input$temp, input$humid/100), 
           g_mpp = list(list(input$d1ui, input$d2ui, input$d3ui), 
                        list(input$t1ui, input$t2ui, input$t3ui), 
                        list(input$r1ui, input$r2ui, input$r3ui), 
                        list(input$phi1ui, input$phi2ui, input$phi3ui)),
           model.fname = "calcSurfaceResistanceRuiz"),
           type = "l", xaxt="n", xlab = "Frequenz", ylab = "Absorptionskoeffizient", main = "Absorptionskennlinie")
      
      # lines(seq(100, 4500, by = 50), 
      #       calcAbsorptionMPPVec(seq(100, 4500, by = 50), 
      #             g_environ = list(input$press, input$temp, input$humid/100), 
      #             g_mpp = list(list(input$d1ui, input$d2ui, input$d3ui), 
      #                          list(input$t1ui, input$t2ui, input$t3ui), 
      #                          list(input$r1ui, input$r2ui, input$r3ui), 
      #                          list(input$phi1ui, input$phi2ui, input$phi3ui)),
      #         model.fname = "calcSurfaceResistanceRuiz"))
      
      axis(1, xaxp = c(100, 4500, 10), las =2)
      segments(input$leftEdge, 0, input$leftEdge, input$thresh, col = "red")
      segments(input$rightEdge, 0, input$rightEdge, input$thresh, col = "red")
      segments(input$leftEdge, input$thresh, input$rightEdge, input$thresh, col = "red")
    })
    
    
    
  
  
}

shinyApp(ui, server)



