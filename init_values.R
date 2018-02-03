# Input parameters:

# number of layer: N
# thickness of each air cavity: d_1,...,d_N
# sound frequency: f

# panel thickness: t_1,...,t_N
# perforation radius: r_1,...,r_N
# perforation rate / porosity: phi_1,...,phi_N

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

Tc <- 20
pda <- 101325
rh <- 0.4

g_vpw <<- round(calcVaporPressureOfWater(Tc), digits = 0)
g_sos <<- round(calcSpeedOfSound(Tc), digits = 0) 
g_dvi <<- round(calcDynamicViscosityAir(Tc)*10^5, digits = 3)
g_aid <<- round(calcAirDensity(pda, Tc, rh), digits = 3) 
g_imp <<- round(calcAcousticImpedanceOfAir(pda, Tc, rh), digits = 1)


