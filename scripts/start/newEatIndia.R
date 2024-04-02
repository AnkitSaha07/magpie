# ------------------------------------------------
# description: test for NIN settings implementation for India
# position: 1
# ------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

codeCheck <- FALSE

cfg$title       <- "newEatIndia"

cfg$gms$s15_exo_diet <- 3               # def = 0

#Exogenous scenario applied only for India
cfg$gms$scen_countries15  <- "IND"
start_run(cfg, codeCheck=FALSE)
