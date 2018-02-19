uiTabBasicValues <- function(){
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
}

