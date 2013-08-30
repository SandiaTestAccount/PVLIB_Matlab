%% PV_LIB Toolbox Release Notes
% This toolbox implements functions that enable simulation of the
% performance of photovoltaic (PV) energy systems.
%
% The PV_LIB Toolbox requires Matlab software.
% 
%% References
% Additional information and documentation is available on the PV
% Performance Modeling Collaborative website (<http://pvpmc.org>)
%
% The latest version of this fully functional toolbox is available on the
% PVPMC website. (Check back for periodic updates)
%
%% Bug Reporting
% Report bugs and problmes to Joshua Stein (jsstein@sandia.gov)
%% Credits for Non-Sandia contributions
% * *Rob Andrews, Queen's University:* Multiple bug finds and fixes in
% PV_LIB version 1.0 functions pvl_perez, pvl_haydavies1980,
% pvl_klucher1979, and pvl_reindl1990
%% Versions 
%%
% * *Version 1.0:* June-2012  Initial Release
% * *Version 1.1:* December-2012  Update with new functions and bug fixes
%%
% * pvl_clearsky_haurwitz - Clear sky global horizontal irradiance model (simple) 
% * pvl_clearsky_ineichen - Clear sky irradiance (GHI, DNI, and DHI) model
% * pvl_physicaliam - Incident angle modifer model based on Snell’s Law
% * pvl_ashraeiam - Incident angle modifier model from ASHRAE (used in PVsyst)
% * pvl_calcparams_desoto – Create module performance coefficient structure for the single diode model form described by DeSoto et al., 2006
% * pvl_singlediode – Solves the single-diode model to obtain a photovoltaic IV curve 
%
% Significant Changes in Version 1.1
%%
% * Fixed numerous text typos in documentation and help files
% * Made numerical fix to pvl_spa
% * Fixed angle of incidence calculation in pvl_perez, pvl_haydavies1980, pvl_klucher 1979, and pvl_reindl1990
% * Fixed numerical errors in final calculation of pvl_perez
% * Fixed pvl_perez to accept scalar input values with vector input values
%

%%
% Copyright 2012 Sandia National Laboratories