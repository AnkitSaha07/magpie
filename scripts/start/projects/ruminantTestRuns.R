# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ------------------------------------------------
# description: Ruminant Fade out testruns
# ------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################


######Run1####Livestock#####

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "1409_rumFadeOut1"


##Input data files to be used for India-specific analysis
cfg$input <- c(regional    = "rev4.88_h12_magpie.tgz",
               cellular    = "rev4.88_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.88_h12_validation.tgz",
               additional  = "additional_data_rev4.43.tgz",
               calibration = "calibration_H12_per_ton_fao_may22_glo_08Aug23.tgz")

##Please always use the updated `calibration` and `additional` files from the main default.cfg file

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                           getOption("magpie_repos"))

#Download input data
cfg$force_download <- TRUE

#Setting pumping to 1
cfg$gms$s42_pumping <- 1
#Setting year from which pumping costs will be implemented
 cfg$gms$s42_multiplier_startyear <- 1995
##Pumping cost value to  default value for India
cfg$gms$s42_multiplier <- 1

cfg$recalibrate <- FALSE

# * Temporal development of ruminant meat share within the livestock food product
# * group (applied before food demand model is executed)
# *   options:   constant, halving2050, mixed
cfg$gms$c15_rum_share <- "mixed"             # def = mixed

# * Stronger ruminant fadeout in India
# *   options:  0 (=off), 1 (=on)
cfg$gms$s15_rum_share_fadeout_india_strong <- 1             # def = 1

start_run(cfg, codeCheck = FALSE)



######Run2####Livestock#####

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "1409_rumFadeOut0"



#Setting pumping to 1
cfg$gms$s42_pumping <- 1
#Setting year from which pumping costs will be implemented
 cfg$gms$s42_multiplier_startyear <- 1995
##Pumping cost value to  default value for India
cfg$gms$s42_multiplier <- 1

cfg$recalibrate <- FALSE

cfg$gms$s15_rum_share_fadeout_india_strong <- 0             # def = 1

start_run(cfg, codeCheck = FALSE)

