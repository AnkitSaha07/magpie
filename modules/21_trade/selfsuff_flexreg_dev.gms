*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_flexreg_dev/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_flexreg_dev/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_flexreg_dev/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_flexreg_dev/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_flexreg_dev/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_flexreg_dev/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
