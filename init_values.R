# Anzahl der Schichten: N
# Dicke der einzelnen Luftkaverne: d_1,...,d_N
# Schallfrequenz: f

# Plattendicke: t_1,...,t_N
# Lochradius: r_1,...,r_N
# Porositaet: phi_1,...,phi_N
N <- 3
tmin <- 0.001
tmax <- 0.005
tgrid <- 100
t1 <- 0.00156
t2 <- 0.00156
t3 <- 0.00220
rmin <- 0.0001
rmax <- 0.0005
rgrid <- 100
r1 <- 0.00025
r2 <- 0.000202
r3 <- 0.000203
phimin <- 0.01
phimax <- 0.20
phigrid <- 80
phi1 <- 0.0902
phi2 <- 0.0491
phi3 <- 0.0216
dmin <- 0.01
dmax <- 0.05
dgrid <- 40
d1 <- 0.0307
d2 <- 0.0322
d3 <- 0.0375

# Temperatur, Druck, relative Feuchte
Tc <- 20
pda <- 101325
rh <- 0.4

# Basiswerte
g_vpw <<- round(calcVaporPressureOfWater(Tc), digits = 0)
g_vpw_descr <<- "Saettigungsdampfdruck in Pascal"
g_sos <<- round(calcSpeedOfSound(Tc), digits = 0)
g_sos_descr <<- "Schallgeschwindigkeit in m/s"
g_dvi <<- round(calcDynamicViscosityAir(Tc)*10^5, digits = 3)
g_dvi_descr <<- "Viskositaet in 10hoch5 kg/(m s)"
g_aid <<- round(calcAirDensity(pda, Tc, rh), digits = 3) 
g_aid_descr <<- "Luftdichte in kg / mhoch3"
g_imp <<- round(calcAcousticImpedanceOfAir(pda, Tc, rh), digits = 1)
g_imp_descr <<- "Impedanz der Luft in kg / s mhoch2"
g_temp_descr <<- "Temperatur in Grad Celsius"
g_press_descr <<- "Luftdruck in Pascal"
g_humid_descr <<- "Relative Luftfeuchte in Prozent"

# Konstruktionsparameter
g_thickness_descr <<- "Dicke der Lochplatten in m"
g_thickness_panel1_descr <<- "Dicke - Platte 1"
g_thickness_panel2_descr <<- "Dicke - Platte 2"
g_thickness_panel3_descr <<- "Dicke - Platte 3"
g_radius_descr <<- "Radius der Loecher in m"
g_radius_panel1_descr <<- "Lochradius - Platte 1"
g_radius_panel2_descr <<- "Lochradius - Platte 2"
g_radius_panel3_descr <<- "Lochradius - Platte 3"
g_porosity_descr <<- "Porositaet (1 = 100%)"
g_porosity_panel1_descr <<- "Porositaet - Platte 1"
g_porosity_panel2_descr <<- "Porositaet - Platte 2"
g_porosity_panel3_descr <<- "Porositaet - Platte 3"
g_cavern_descr <<- "Dicke der Luftkavernen in m"
g_cavern_panel1_descr <<- "Dicke - Kaverne 1"
g_cavern_panel2_descr <<- "Dicke - Kaverne 2"
g_cavern_panel3_descr <<- "Dicke - Kaverne 3"

# Absorptionsfenster
g_thresh <<- 0.8
g_thresh_min <<- 0.1
g_thresh_max  <<- 0.95
g_thresh_step <<- 0.01
g_absorption_window_thresh_descr <<- 
  paste("Oberkante Absorptionsfenster (", g_thresh_min, " bis ", g_thresh_max, ")", sep = "")

g_leftEdge <<- 350
g_leftEdge_min <<- 50
g_leftEdge_max <<- 1000
g_leftEdge_step <<- 5
g_absorption_window_leftEdge_descr <<- 
  paste("Linke Kante Absorptionsfenster (", g_leftEdge_min, " Hz bis ", g_leftEdge_max, " Hz)", sep = "")

g_rightEdge <<- 2500
g_rightEdge_min <<- 1100
g_rightEdge_max <<- 4000
g_rightEdge_step <<- 10
g_absorption_window_rightEdge_descr <<- 
  paste("Rechte Kante Absorptionsfenster (", g_rightEdge_min, " Hz bis ", g_rightEdge_max, " Hz)", sep = "")

# Lochabstaende
g_dist_holes_panel1_descr <<- "Platte 1 - Lochabstand in m"
g_dist_holes_panel2_descr <<- "Platte 2 - Lochabstand in m"
g_dist_holes_panel3_descr <<- "Platte 3 - Lochabstand in m"

# Berechnung Absorptionskennlinie
g_lb_absorption <<- 100
g_ub_absorption <<- 4500
g_no_of_calc_points <<- 50



