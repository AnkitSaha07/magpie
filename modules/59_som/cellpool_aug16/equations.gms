*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q59_som_target_cropland(j2) ..
              v59_som_target(j2,"cropland")
              =e=
              sum(w, vm_area(j2,kcr,w)) * sum(ct,fm_carbon_density(ct,j2,"crop","soilc")) * i59_cratio(j2,kcr)
*              + sum(kcr,vm_area(kcr,"irrigated")*vm_carbon_content(j2,"crop")*i59_irrigationbonus
              ;

*pm_climate_class(j,clcl)

q59_som_target_noncropland(j2) ..
              v59_som_target(j2,"noncropland")
              =e=
              sum((noncropland59),vm_land(j2,noncropland59)*sum(ct,fm_carbon_density(ct,j2,noncropland59,"soilc"));

q59_som_transfer_to_cropland(j2) ..
              v59_som_transfer_to_cropland(j2)
              =e=
              sum((si,ct)
              + vm_landexpansion(j2,"crop",si) * p59_carbon_density(ct,j2,"cropland")
              - vm_landreduction(j2,"crop",si) * p59_carbon_density(ct,j2,"noncropland")
              )

q59_som_pool_cropland(j2) ..
             v59_som_pool(j2,"cropland")
              =e=
              sum(ct,
                (1-i59_lossrate(ct)) *  v59_som_target(j2,"cropland") +
                 i59_lossrate(ct) * (p59_som_pool(j2,"cropland") + v59_som_transfer_to_cropland(j2))
              );

q59_som_pool_noncropland(j2) ..
               v59_som_pool(j2,"noncropland")
               =e=
               sum(ct,
                 (1-i59_lossrate(ct)) * v59_som_target(j2,"noncropland") +
                  i59_lossrate(ct) * (p59_som_pool(j2,"noncropland") - v59_som_transfer_to_cropland(j2))
               );

q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e=
           sum(ct,i59_lossrate(ct)) * (
             p59_som_pool(j2,"cropland")
             + v59_som_transfer_to_cropland(j2)
             - v59_som_target(j2,"cropland")
           )/15;
