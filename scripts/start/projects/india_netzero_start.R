# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: India Net Zero scenarios (NITI Aayog pathway comparison)
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")

# One column per scenario, each combined with the shared IndiaNetZero base
# column. The NIN diet customization is merged into standard MAgPIE now, so
# no custom input revision override is needed, default.cfg's own input
# already carries it. Baseline is the reference case: every switch blank,
# falls through entirely to default.cfg.
scenarioNames <- c("Baseline", "CropProdMgmt", "Livestock", "LandNature",
                    "Diet", "EconomyWide", "NITIAayog")

for (scenarioName in scenarioNames) {

  source("config/default.cfg")

  cfg <- setScenario(cfg, c("IndiaNetZero", scenarioName),
                     scenario_config = "config/projects/scenario_config_indianetzerocompact.csv")

  cfg$title <- paste0("IndiaNetZero_", scenarioName)

  start_run(cfg = cfg, codeCheck = FALSE, lock_timeout = 6)
}
