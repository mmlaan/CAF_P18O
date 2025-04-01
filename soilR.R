#install.packages("SoilR")

library(SoilR)
library(knitr)


## Example from Spohn and Sierra 2018
tau = seq(0,1000) #vector of transit times

a = seq(0,1000) # vector of ages

uP = matrix(c(0,0.1,0.1), 3,1) # external inputs (N fixation, depostion, weathering)

xP = matrix(c(50,10,10*3), 3,3,byrow = TRUE) # steady state contents of pools (plant biomass, litter layer, soil)

FP = matrix(c(-2.1, 1.1, 1.0, 2.1, -1.1-1.1,0,0,1.1,-1.0-0.2), byrow = TRUE,3,3) # internal fluxes? uptake I + uptake II, leaching II,  

BP = FP/xP

BP

Pa=systemAge(BP, uP, a) # system age
Ptt = transitTime(BP,uP,tau) #transit time

Pa$meanSystemAge
Pa$meanPoolAge

Ptt$meanTransitTime

## CAF No-Till ####

#col 1 veg
#col 2 mineral

uP = matrix(c(0,0.27), 2, 1) # external inputs (deposition, no fixation or weathering)

xP = matrix(c(1.27, 1140), 2,2, byrow = TRUE) # steady state contents of pools (plant biomass, litter layer, soil)

FP = matrix(c(-6.975, 13.95,6.975,-0.27 -13.95), byrow = TRUE, 2,2)

BP = FP/xP

BP

Pa = systemAge(BP, uP, a)

Ptt = transitTime(BP, uP, tau)

Pa$meanSystemAge

Pa$meanPoolAge
