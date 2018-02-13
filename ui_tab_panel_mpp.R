fluidRow(column(width = 12,
                mainPanel(width = 12,
                          tabsetPanel(id = "tabs", 
                                      tabPanel("Akustiksystem - Simulation", value = "tabSimu",
                                               tags$head(
                                                 tags$style(HTML('#resetMPPButton{background-color:rgb(153, 230, 153)}')),
                                                 tags$style(type='text/css', "#resetMPPButton { width:75%; margin-top: 25px;}"),
                                                 tags$style(HTML('#downloadMPPButton{background-color:rgb(255, 128, 128)}')),
                                                 tags$style(type='text/css', "#downloadMPPButton { width:75%; margin-top: 25px;}"),
                                                 tags$style(HTML('#downloadMPPcharts{background-color:rgb(255, 128, 128)}')),
                                                 tags$style(type='text/css', "#downloadMPPcharts { width:75%; margin-top: 25px;}"),
                                                 tags$style(HTML('#docuMPP{background-color:rgb(255, 214, 153)}')),
                                                 tags$style(type='text/css', "#docuMPP { width:75%; margin-top: 25px;}"),
                                                 tags$style(HTML('#startSA{background-color:rgb(232,232,232)}')),
                                                 tags$style(type='text/css', "#startSA { width:20%; margin-top: 25px; margin-bottom: 25px;}")
                                               ),
                                               fluidPage(fluidRow(
                                                 column(width = 12, align = "center", h2("Mehrschichtsystem Mikrolochplatte - Luftkaverne"))
                                               )),
                                               splitLayout(actionButton("docuMPP", "Dokumentation"),
                                                           downloadButton("downloadMPPButton", "Werte herunterladen (Excel)"),
                                                           downloadButton("downloadMPPcharts", "Grafiken herunterladen (pdf)"),
                                                           actionButton("resetMPPButton", "Ruecksetzen auf Vorschlagswerte"),
                                                           cellWidths = c("25%", "25%", "25%", "25%"),
                                                           cellArgs = list(align="center")),
                                               br(),
                                               splitLayout(numericInput("thresh", g_absorption_window_thresh_descr, g_thresh,
                                                                        min = g_thresh_min, max = g_thresh_max, step = g_thresh_step),
                                                           numericInput("leftEdge", g_absorption_window_leftEdge_descr, g_leftEdge,
                                                                        min = g_leftEdge_min, max = g_leftEdge_max, step = g_leftEdge_step),
                                                           numericInput("rightEdge", g_absorption_window_rightEdge_descr, g_rightEdge,
                                                                        min = g_rightEdge_min, max = g_rightEdge_max, step = g_rightEdge_step),
                                                           cellWidths = c("33%", "33%", "34%"),
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
                                      ),
                                      tabPanel("Akustiksystem - 3D Ansicht", value = "tabRGL",
                                               fluidRow(
                                                 column(width = 12, align = "center", h2("3D-Ansicht der Lochplattenanordnung"))
                                               ),
                                               fluidRow(
                                                 column(width = 12, align = "center", 
                                                        h5("Mit gedrueckter linker Maustaste kann die Grafik rotiert werden.
                                                           Mit dem Rollrad der Maus kann die Grafik verkleinert bzw. 
                                                           vergroessert werden."))
                                                        ),
                                               fluidRow(
                                                 column(width = 12, align = "center",
                                                        box(width = 12, 
                                                            rglwidgetOutput("rglplot", width = "900px", height = "600px"))
                                                 )
                                               )
                                                        ),
                                      tabPanel("Akustiksystem - Optimierung", value = "tabOpt",
                                               fluidRow(
                                                 column(width = 12, align = "center", h2("Optimierung der Absorptionseigenschaften"))
                                               ),
                                               fluidRow(
                                                 column(width = 12, align = "center", 
                                                        h5("Ausgehend von dem in der Simulation definierten Absorptionsfenster wird
                                                           mit Hilfe eines stochastischen Suchalgorithmus (Simulated Annealing)
                                                           versucht, eine Konfiguration der Bauparameter (Plattendicke, Lochradius,
                                                           Porositaet, Kavernendicke) zu bestimmen, dessen Absorptionskennlinie
                                                           die Vorgaben des Absorptionsfensters moeglichst einhaelt."))
                                                        ),
                                               fluidRow(
                                                 column(width = 12, align = "center",
                                                        actionButton("startSA", "Start der Suchroutine")
                                                 )
                                               ),
                                               fluidRow(
                                                 column(width = 12, align = "center",
                                                        box(width = 12, 
                                                            tableOutput("protValues"),
                                                            background = "olive"
                                                            )
                                                 )
                                               )
                                                        )                                    
                                      
                                      )
                          ) 
                )
         
         )