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

tau = seq(0,1000) #vector of transit times

a = seq(0,1000) # vector of ages

#col 1 veg
#col 2 mineral


uP = matrix(c(0.27), ncol = 1) # external inputs (deposition, no fixation or weathering)

#xP = matrix(c(1.27, 1140), 2,2, byrow = TRUE) # steady state contents of pools (plant biomass, litter layer, soil)
xP <- matrix(c(1140), ncol = 1)


#FP = matrix(c(-6.975, 13.95,6.975,-0.27 -13.95), byrow = TRUE, 2,2)

# 3. Internal flux matrix FP (kg/ha/yr)
# Row i = to pool i, Column j = from pool j
# F[1,1] = -1.27 (loss from veg)
# F[1,2] = 13.95 (soil to veg)
# F[2,1] = 0 (no veg to soil)
# F[2,2] = -13.95 (uptake) - 0.11 (leaching)
FP <- matrix(c(
  -1.27 + 13.95,
  0.00, -13.95 - 0.11
), nrow = 2, byrow = TRUE)

BP = FP/as.numeric(xP)

BP

# System age
Pa = systemAge(BP, uP, a)

# Transit Time
Ptt = transitTime(BP, uP, tau)

Pa$meanSystemAge
Pa$meanPoolAge

Ptt$meanTransitTime

## Chat GPT

times <- seq(0, 100, by = 1)  # run for 100 years

# Define stocks (kg/ha)
initial_stocks <- c(vegetation = 1.27, soil = 1140)

# Define flux matrix (rates in 1/yr)
# Rates calculated as flux/stock
k_veg_out <- 1.27 / 1.27           # vegetation turnover (biomass removal)
k_soil_to_veg <- 13.95 / 1140      # plant uptake from soil
k_soil_leach <- 0.11 / 1140        # leaching loss from soil

# Define the transfer matrix
A <- matrix(c(-k_veg_out,           k_soil_to_veg,
              0,        -k_soil_to_veg - k_soil_leach), 
            nrow = 2, byrow = TRUE)

# Inputs: constant deposition into soil only
inputFluxes <- list(
  vegetation = ConstFc(0),
  soil = ConstFc(0.27)
)

# Initial output pools (for tracking age/transit time)
initialValF <- list(
  vegetation = ConstFc(0),
  soil = ConstFc(0)
)
# Build the model
p_model <- GeneralModel_14(
  t = times,
  A = A,
  ivList = initial_stocks,
  initialValF = initialValF,
  inputFluxes = inputFluxes,
  pass = TRUE
)


# Compute mean age of phosphorus in the system
age_results <- getMeanAge(p_model)

# Compute mean transit time
transit_results <- getTransitTime(p_model)

# Output results
cat("Mean age (years):\n")
print(age_results)
cat("\nMean transit time (years):\n")
print(transit_results)

Ptt = transitTime(BP, uP, tau)

Pa$meanSystemAge

Pa$meanPoolAge

## available and not-available ####


tau = seq(0,1000) #vector of transit times

a = seq(0,1000) # vector of ages

#col 1 veg
#col 2 mineral


uP = matrix(c(0.27, 0), ncol = 1) # external inputs (deposition, no fixation or weathering)

#xP = matrix(c(1.27, 1140), 2,2, byrow = TRUE) # steady state contents of pools (plant biomass, litter layer, soil)
xP <- matrix(c(1140, 17310), ncol = 2)


#FP = matrix(c(-6.975, 13.95,6.975,-0.27 -13.95), byrow = TRUE, 2,2)

# 3. Internal flux matrix FP (kg/ha/yr)
# Row i = to pool i, Column j = from pool j
# F[1,1] = -1.27 (loss from veg)
# F[1,2] = 13.95 (soil to veg)
# F[2,1] = 0 (no veg to soil)
# F[2,2] = -13.95 (uptake) - 0.11 (leaching)
FP <- matrix(c(
  -13.95 -0.11, 0,
 69.24, -69.24), nrow = 2, byrow = TRUE)

BP = FP/as.numeric(xP)

BP

# System age
Pa = systemAge(BP, uP, a)

# Transit Time
Ptt = transitTime(BP, uP, tau)

Pa$meanSystemAge
Pa$meanPoolAge

Ptt$meanTransitTime



