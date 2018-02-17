g_vpw <<- round(calcVaporPressureOfWater(input$temp), digits = 0)
g_sos <<- round(calcSpeedOfSound(input$temp), digits = 0)
g_dvi <<- round(calcDynamicViscosityAir(input$temp)*10^5, digits = 3)
g_aid <<- round(calcAirDensity(input$press, input$temp, input$humid/100), digits = 3)
g_imp <<- round(calcAcousticImpedanceOfAir(input$press, input$temp, input$humid/100), digits = 1)


output$infoBoxVaporPressure <- renderInfoBox({
  validate(checkInputValueGeneric(Tcmin, Tcmax, input$temp, g_temp_descr))
  infoBox(value = g_vpw, title = g_vpw_descr, 
          icon = icon("dashboard", lib = "glyphicon"), width = 10)
})    

output$infoBoxSpeedOfSound <- renderInfoBox({
  validate(checkInputValueGeneric(Tcmin, Tcmax, input$temp, g_temp_descr))
  infoBox(value = g_sos, title = g_sos_descr, 
          icon = icon("volume-up", lib = "font-awesome"), width = 10)
})

output$infoBoxViscosity <- renderInfoBox({
  validate(checkInputValueGeneric(Tcmin, Tcmax, input$temp, g_temp_descr))
  infoBox(value = g_dvi, title = g_dvi_descr, 
          icon = icon("google-wallet", lib = "font-awesome"), width = 10)
})        

output$infoBoxAirDensity <- renderInfoBox({
  validate(checkInputValueGeneric(Tcmin, Tcmax, input$temp, g_temp_descr))
  validate(checkInputValueGeneric(rhmin*100, rhmax*100, input$humid, g_humid_descr))
  validate(checkInputValueGeneric(pdamin, pdamax, input$press, g_press_descr))
  infoBox(value = g_aid, title = g_aid_descr, 
          icon = icon("cloud", lib = "font-awesome"), width = 10)
}) 

output$infoBoxImpedance <- renderInfoBox({
  validate(checkInputValueGeneric(Tcmin, Tcmax, input$temp, g_temp_descr))
  validate(checkInputValueGeneric(rhmin*100, rhmax*100, input$humid, g_humid_descr))
  validate(checkInputValueGeneric(pdamin, pdamax, input$press, g_press_descr))  
  infoBox(value = g_imp, title = g_imp_descr, 
          icon = icon("backward", lib = "font-awesome"), width = 10)
})