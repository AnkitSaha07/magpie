# ------------------------------------------------
# description: sweep c56_emis_policy and c56_pollutant_prices options
# ------------------------------------------------
#
# Purpose: this is exploration, not a committed scenario design. It runs a
# curated set of c56_emis_policy presets (holding the price trajectory and
# India-only restriction fixed) and a small set of c56_pollutant_prices
# trajectories (holding the mask fixed), so the response of each option can
# be compared before deciding which preset to actually bake into FUE,
# RiceCH4, LvstGHG, EconCP, Land30, Diet, NITI (see
# india_netzero_start_switches.R / marginalEffects_t1.R).
#
# Important mechanism, confirmed from modules/56_ghg_policy/price_aug22/
# preloop.gms: policy_countries56 only splits the PRICE LEVEL regionally
# (selected countries get c56_pollutant_prices, everyone else gets
# c56_pollutant_prices_noselect, default "R34M410-SSP2-NPi2025"). The
# c56_emis_policy MASK has no such split, whatever preset is chosen applies
# to every region in the world, not just the policy_countries56 list. So
# "IND" below only ever controls how strong the price is in India vs
# elsewhere, never which emission sources get priced at all.
#
# Block 1 sweeps the mask (c56_emis_policy), price trajectory held at
# R34M410-SSP2-PkBudg650 (the ambitious trajectory used elsewhere in this
# project):
#   Base        - reference, every switch blank (falls to default.cfg:
#                 NPi2025 price, reddnatveg_nosoil mask, applied worldwide)
#   None        - mask = none, zero emission cost anywhere
#   ReddNatveg  - mask = reddnatveg_nosoil, same mask as Base's own default,
#                 isolates the effect of India's price alone being raised
#   CropEff     - mask = sdp_cropeff (crop/rice-only, current RiceCH4 choice)
#   Livestock   - mask = sdp_livestock (livestock-only, current LvstGHG choice)
#   Soil        - mask = sdp_soil (soil N2O only, not yet tested elsewhere)
#   SdpAll      - mask = sdp_all (broadest "sdp" preset, includes soil)
#   AllNosoil   - mask = all_nosoil (broad, current EconCP choice)
#   All         - mask = all (every priceable pollutant/source, incl. soil)
#
# Block 2 sweeps the price trajectory (c56_pollutant_prices), mask held at
# all_nosoil:
#   NPi2025     - current-policy-equivalent price (same as Base's own default)
#   PkBudg1000  - moderate-ambition peak-budget trajectory
# PkBudg650 (high-ambition) is deliberately not repeated here, it's the same
# price + mask combination as block 1's AllNosoil run, so that run covers
# this point on the price-sweep already.

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

codeCheck <- FALSE

## Basic settings, following DietTest_demo.R's convention
basic_settings <- function(title) {

  source("config/default.cfg")

  cfg$force_download <- TRUE
  cfg$info$flag      <- "c56"
  cfg$title          <- paste(cfg$info$flag, title, sep = "_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate    <- FALSE

  return(cfg)
}

## ---- Block 1: sweep the emission-source mask, price trajectory fixed -----

cfg <- basic_settings(title = "Base")
start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)

emis_policy_options <- c(
  None       = "none",
  ReddNatveg = "reddnatveg_nosoil",
  CropEff    = "sdp_cropeff",
  Livestock  = "sdp_livestock",
  Soil       = "sdp_soil",
  SdpAll     = "sdp_all",
  AllNosoil  = "all_nosoil",
  All        = "all"
)

for (run_name in names(emis_policy_options)) {

  cfg <- basic_settings(title = run_name)

  cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
  cfg$gms$c56_emis_policy      <- emis_policy_options[[run_name]]
  cfg$gms$policy_countries56   <- "IND"

  start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)
}

## ---- Block 2: sweep the price trajectory, emission-source mask fixed -----

price_options <- c(
  NPi2025    = "R34M410-SSP2-NPi2025",
  PkBudg1000 = "R34M410-SSP2-PkBudg1000"
)

for (run_name in names(price_options)) {

  cfg <- basic_settings(title = run_name)

  cfg$gms$c56_pollutant_prices <- price_options[[run_name]]
  cfg$gms$c56_emis_policy      <- "all_nosoil"
  cfg$gms$policy_countries56   <- "IND"

  start_run(cfg, codeCheck = codeCheck, lock_timeout = 6)
}
