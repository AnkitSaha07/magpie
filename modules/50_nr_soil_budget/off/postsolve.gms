*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_inorg_fert_reg(t,i,"marginal")   = vm_nr_inorg_fert_reg.m(i);
 ov_nr_inorg_fert_costs(t,i,"marginal") = vm_nr_inorg_fert_costs.m(i);
 ov_nr_inorg_fert_reg(t,i,"level")      = vm_nr_inorg_fert_reg.l(i);
 ov_nr_inorg_fert_costs(t,i,"level")    = vm_nr_inorg_fert_costs.l(i);
 ov_nr_inorg_fert_reg(t,i,"upper")      = vm_nr_inorg_fert_reg.up(i);
 ov_nr_inorg_fert_costs(t,i,"upper")    = vm_nr_inorg_fert_costs.up(i);
 ov_nr_inorg_fert_reg(t,i,"lower")      = vm_nr_inorg_fert_reg.lo(i);
 ov_nr_inorg_fert_costs(t,i,"lower")    = vm_nr_inorg_fert_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

