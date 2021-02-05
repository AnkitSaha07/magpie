*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c73_wood_scen  default
* options default, construction

scalars
  s73_timber_prod_cost      Cost for produccing a unit of timber (USD per tDM) / 500 /
  s73_timber_harvest_cost   Cost for harvesting timber (USD per ha) / 1000/
  s73_cost_multiplier       Multiplier for expensive harvest in natural vegetation (1) /1.2/
  s73_free_prod_cost        Very high cost for using non existing land for plantation establishment (USD per tDM) /1000000000/
  sm_timber_demand_switch   Logical switch to turn on or off timber demand 1=on 0=off (1)     / 0 /
  s73_foresight             Boolean switch for establishment demand assumption 1=forward looking 0=myopic (1) / 0 /
  s73_increase_ceiling      Limiter for not allowing a demand jump between time steps beyond a certain limit (1) /1.025/
  s73_residue_ratio         Proportion of overall industrial roundwood production which ends up as residue during harvest (1) / 0.15/
  sm_wood_density                Representative wood density based on IPCC in (tDM per m3) /0.6/
;

** Residue numbers from
** "Spatially explicit assessment of roundwood and logging residues availability and costs for the EU28"
** "The total potential volume of logging residues in the “Reference scenario” is estimated to be 79 Mm3, corresponding to 13.5% of the roundwood potential volume. "

table f73_prod_specific_timber(t_all,iso,total_wood_products) End use timber product demand (mio. m3 per yr)
$ondelim
$include "./modules/73_timber/input/f73_prod_specific_timber.csv"
$offdelim
;

parameter f73_income_elasticity(total_wood_products) Income elasticities of wood products (1)
/
$ondelim
$include "./modules/73_timber/input/f73_income_elasticity.csv"
$offdelim
/
;

parameter f73_volumetric_conversion(kforestry) Volumetric conversion from mio t to m3 of wood (1)
/
$ondelim
$include "./modules/73_timber/input/f73_volumetric_conversion.csv"
$offdelim
/
;

table f73_demand_modifier(t_ext,scen_73) Factor diminishing paper use  (1)
$ondelim
$include "./modules/73_timber/input/f73_demand_modifier.csv"
$offdelim
;
