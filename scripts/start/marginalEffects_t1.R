# ------------------------------------------------
# description: India Net Zero, one-switch-at-a-time, trial 1 (t1)
# ------------------------------------------------
#
# Same design as india_netzero_start_switches.R (each run changes exactly
# one policy lever relative to Base), restructured to follow the
# basic_settings()/title-flag convention from DietTest_demo.R.
#
# Diet note: DietTest_demo.R's own exploration shows that s15_exo_diet = 2
# (what the earlier script used, via c15_EAT_scen = "FLX_hmilk") is the OLD,
# DEPRECATED exogenous-diet realization. default.cfg explicitly says
# "Please use (3) for new runs" instead, where the diet target is chosen via
# c15_exodiet_scen (EL2 = second EAT-Lancet Commission diet, NIN = India's
# own National Institute of Nutrition guideline) rather than c15_EAT_scen,
# which is only read when s15_exo_diet is 1 or 2. DietTest_demo.R itself
# only pairs the India-only restriction (scen_countries15 = "IND") with NIN,
# not EL2, so NIN is used here as the India-specific diet target. If EL2 is
# what you actually want tested, change c15_exodiet_scen below.
#
# The s15_exo_* sub-switches (monogastric, ruminant, fish, fruitvegnut,
# roots, pulses, sugar, oils, brans, scp) are left untouched everywhere,
# they already sit at default.cfg's own defaults (1,1,1,1,1,1,1,1,0,1), so
# setting them again would be a no-op.
#
# Use india_netzero_marginal_effects.R afterwards to quantify each switch's
# marginal effect vs Base (that script currently expects the
# IndiaNetZero_<name> naming from india_netzero_start_switches.R, update its
# run_prefix/scenario names to "t1_<name>" if you want it to read this
# batch's output instead).

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

codeCheck <- FALSE

## Basic settings, following DietTest_demo.R's convention
basic_settings <- function(title) {

  source("config/default.cfg")

  cfg$force_download <- TRUE
  cfg$info$flag      <- "t1"
  cfg$title          <- paste(cfg$info$flag, title, sep = "_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate    <- FALSE

  return(cfg)
}

### Base: reference, no India-specific intervention

cfg <- basic_settings(title = "Base")

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### FUE: nitrogen use efficiency only

cfg <- basic_settings(title = "FUE")

cfg$gms$c50_scen_neff      <- "maxeff_add3_glo75_glo85"
cfg$gms$cropneff_countries <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### RiceCH4: rice CH4 price only (drives AWD via the price channel)

cfg <- basic_settings(title = "RiceCH4")

cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
cfg$gms$c56_emis_policy      <- "sdp_cropeff"
cfg$gms$policy_countries56   <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### LvstGHG: livestock CH4+N2O price only

cfg <- basic_settings(title = "LvstGHG")

cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
cfg$gms$c56_emis_policy      <- "sdp_livestock"
cfg$gms$policy_countries56   <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### Land30: 30by30 protected-area expansion only

cfg <- basic_settings(title = "Land30")

cfg$gms$c22_protect_scenario <- "30by30"
cfg$gms$policy_countries22   <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### Diet: India-specific shift to the NIN dietary guideline
### (s15_exo_diet = 3, the current, non-deprecated realization)

cfg <- basic_settings(title = "Diet")

cfg$gms$s15_exo_diet     <- 3
cfg$gms$c15_exodiet_scen <- "NIN"
cfg$gms$scen_countries15 <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### EconCP: broad, non-source-restricted carbon price

cfg <- basic_settings(title = "EconCP")

cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
cfg$gms$c56_emis_policy      <- "all_nosoil"
cfg$gms$policy_countries56   <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### NITI: all six levers above stacked (combined India Policy scenario)
### c56_emis_policy is intentionally left unset here, falls back to
### default.cfg's own "reddnatveg_nosoil", the combined-scenario pricing
### scope is still an open decision.

cfg <- basic_settings(title = "NITI")

cfg$gms$c50_scen_neff        <- "maxeff_add3_glo75_glo85"
cfg$gms$cropneff_countries   <- "IND"
cfg$gms$c22_protect_scenario <- "30by30"
cfg$gms$policy_countries22   <- "IND"
cfg$gms$s15_exo_diet         <- 3
cfg$gms$c15_exodiet_scen     <- "NIN"
cfg$gms$scen_countries15     <- "IND"
cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
cfg$gms$policy_countries56   <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

### DietFLX: India-specific shift to the FLX_hmilk EAT-Lancet diet
### (s15_exo_diet = 2, the OLD, DEPRECATED realization, kept here for
### comparison against the Diet run above, which uses the current NIN path)

cfg <- basic_settings(title = "DietFLX")

cfg$gms$s15_exo_diet     <- 2
cfg$gms$c15_EAT_scen     <- "FLX_hmilk"
cfg$gms$scen_countries15 <- "IND"

start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)
