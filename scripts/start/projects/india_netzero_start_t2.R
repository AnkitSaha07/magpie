# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: India Net Zero, one-lever-at-a-time, trial 2 (setScenario version)
# ----------------------------------------------------------
#
# Same 17 runs as marginalEffects_t2.R, but the switches live in
# config/projects/scenario_config_indianetzero_t2.csv instead of in this
# script. Copy that CSV into config/projects/ on the cluster before running.
# Use either this script or marginalEffects_t2.R, not both: they create the
# same output folders (t2_<name>).
#
#   Base       default.cfg untouched
#   BaseDet    croparea = detail_apr24 only (reference for CropDiv)
#   FUE        nitrogen use efficiency, India
#   RiceCH4    India rice CH4 price (sdp_cropeff mask, applied worldwide)
#   LvstGHG    India livestock price (sdp_livestock mask, applied worldwide)
#   EconCP     India broad price (all_nosoil mask, applied worldwide)
#   Land30     30by30 protected areas, India
#   Diet       NIN diet (exodiet 3), India
#   CropDiv    rotation rule good_20div, global
#   SYI        c13_tccost = low, global
#   RiceMax    rice CH4 forced to MACC step 201, global
#   LvstMax    enteric CH4, manure CH4 and N2O forced to step 201, global
#   Aff        c32_aff_policy = affexp, global
#   AvoidLUC   c35_ad_policy and c35_aolc_policy = ndc, global
#   BurnConst  c18_burn_scen = constant, global (reverse case)
#   NITI       FUE + Land30 + Diet + India price (c56_emis_policy left unset)
#   NITIglob   NITI + CropDiv + SYI + RiceMax + LvstMax + Aff + AvoidLUC
#
# No yield recalibration anywhere (cfg$recalibrate stays FALSE). default.cfg
# says yield calibration is only meant for the penalty_apr22 crop realization.
# BaseDet, CropDiv and NITIglob therefore run detail_apr24 with the default
# calibration files, which were fitted under simple_apr24. Compare CropDiv
# against BaseDet to separate that from the rotation-rule effect.

library(gms)
source("scripts/start_functions.R")

scenarioNames <- c("Base", "BaseDet",
                   "FUE", "RiceCH4", "LvstGHG", "EconCP", "Land30", "Diet",
                   "CropDiv", "SYI", "RiceMax", "LvstMax", "Aff", "AvoidLUC",
                   "BurnConst",
                   "NITI", "NITIglob")

for (scenarioName in scenarioNames) {

  source("config/default.cfg")

  cfg <- setScenario(cfg, scenarioName,
                     scenario_config = "config/projects/scenario_config_indianetzero_t2.csv")

  cfg$title <- paste0("t2_", scenarioName)

  start_run(cfg = cfg, codeCheck = FALSE, lock_timeout = 6)
}
