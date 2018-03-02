# Anzahl der Schichten: N
# Dicke der einzelnen Luftkaverne: d_1,...,d_N
# Schallfrequenz: f

# Plattendicke: t_1,...,t_N
# Lochradius: r_1,...,r_N
# Porositaet: phi_1,...,phi_N
N <<- 3
tmin <<- 0.5
tmax <<- 5
tgrid <<- 150
t1 <<- 1.56
t2 <<- 1.56
t3 <<- 2.20
rmin <<- 0.1
rmax <<- 0.5
rgrid <<- 100
r1 <<- 0.125
r2 <<- 0.101
r3 <<- 0.1015
phimin <<- 0.01
phimax <<- 0.16
phigrid <<- 80
phi1 <<- 0.0902
phi2 <<- 0.0491
phi3 <<- 0.0216
dmin <<- 10
dmax <<- 50
dgrid <<- 40
d1 <<- 30.7
d2 <<- 32.2
d3 <<- 37.5

# Temperatur, Druck, relative Feuchte
Tc <<- 20
Tcmin <<- -100
Tcmax <<- 100
pda <<- 101325
pdamin <<- 0
pdamax <<- 200000
rh <<- 0.4
rhmin <<- 0
rhmax <<- 1

# Nachommastellen Wertetabelle Optimierungstab
g_digit <<- 4

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
g_thickness_descr <<- "Dicke der Lochplatten in mm"
g_thickness_panel1_descr <<- "Dicke - Platte 1"
g_thickness_panel2_descr <<- "Dicke - Platte 2"
g_thickness_panel3_descr <<- "Dicke - Platte 3"
g_radius_descr <<- "Radius der Loecher in mm"
g_radius_panel1_descr <<- "Lochradius - Platte 1"
g_radius_panel2_descr <<- "Lochradius - Platte 2"
g_radius_panel3_descr <<- "Lochradius - Platte 3"
g_porosity_descr <<- "Porositaet (1 = 100%)"
g_porosity_panel1_descr <<- "Porositaet - Platte 1"
g_porosity_panel2_descr <<- "Porositaet - Platte 2"
g_porosity_panel3_descr <<- "Porositaet - Platte 3"
g_cavern_descr <<- "Dicke der Luftkavernen in mm"
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

g_leftEdge <<- 355
g_leftEdge_min <<- 50
g_leftEdge_max <<- 1000
g_leftEdge_step <<- 5
g_absorption_window_leftEdge_descr <<- 
  paste("Linke Kante Absorptionsfenster (", g_leftEdge_min, " Hz bis ", g_leftEdge_max, " Hz)", sep = "")

g_rightEdge <<- 2470
g_rightEdge_min <<- 1100
g_rightEdge_max <<- 4000
g_rightEdge_step <<- 10
g_absorption_window_rightEdge_descr <<- 
  paste("Rechte Kante Absorptionsfenster (", g_rightEdge_min, " Hz bis ", g_rightEdge_max, " Hz)", sep = "")

# Lochabstaende
g_dist_holes_name <<- "Platte"
g_dist_holes_expl <<- "Lochabst. (Mitte - Mitte) in mm"

# Berechnung Absorptionskennlinie
g_lb_absorption <<- 100
g_ub_absorption <<- 4500
g_no_of_calc_points <<- 50

# chart
g_chart_absorption <<- NULL
g_chart_values <<- NULL
g_chart_holes <<- NULL

# Beschriftung Absorptionskennlinie
g_x_axis_descr <<- "Frequenz"
g_y_axis_descr <<- "Absorptionskoeffizient"
g_main_descr <<- "Absorptionskennlinie"





