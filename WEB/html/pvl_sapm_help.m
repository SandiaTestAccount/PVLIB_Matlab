%% pvl_sapm 
% Sandia PV Array Performance Model 
%
%% Syntax
% |Result = pvl_sapm(Module, Ee, celltemp)|
%
%% Description
% The Sandia PV Array Performance Model (SAPM) generates 5 points on a PV
% module's I-V curve (Voc, Isc, Ix, Ixx, Vmp/Imp) according to
% SAND2004-3535. Assumes a reference cell temperature of 25 C.
%% Inputs
%%
% * |Module| - a structure defining the SAPM performance parameters (see
% below)
% * |Ee| - The effective irradiance incident upon the module (suns). Any Ee<0
% are set to 0.
% * |celltemp| - The cell temperature (degrees C)
%%
% Note - The model coefficients that are required in the
% *|Module|* struct are:
%%
% *  *|Module.c|* - 1x8 vector with the C coefficients Module.c(1) = C0
% *  *|Module.Isc0|* - Short circuit current at reference condition (amps)
% *  *|Module.Imp0|* - Maximum power current at reference condition (amps)
% *  *|Module.Voc0|* - Open circuit voltage at references conditions (V)
% *  *|Module.Vmp0|* - Maximum power voltage at references conditions (V)
% *  *|Module.Ix0|* = Current, in amperes, of the point at 0.5*Voc at
%     reference conditions. 
% *  *|Module.Ixx0|* = Current, in amperes, of the point at 0.5*(Voc0+Vmp0) at
%     reference conditions. 
% *  *|Module.AlphaIsc|* - Short circuit current temperature coefficient at
%     reference condition (1/C)
% *  *|Module.AlphaImp|* - Maximum power current temperature coefficient at
%     reference condition (1/C)
% *  *|Module.BetaVoc|* - Open circuit voltage temperature coefficient at
%     reference condition (V/C)
% *  *|Module.mBetaVoc|* - Coefficient providing the irradiance dependence for
%     the BetaVoc temperature coefficient at reference irradiance (V/C)
% *  *|Module.BetaVmp|* - Maximum power voltage temperature coefficient at
%     reference condition
% *  *|Module.mBetaVmp|* - Coefficient providing the irradiance dependence for
%     the BetaVmp temperature coefficient at reference irradiance (V/C)
% *  *|Module.n|* - Empirically determined "diode factor" (dimensionless)
%  * *|Module.Ns|* - Number of cells in series in a module's cell string(s)
%
%% Outputs
%%
% * *|Result|* - A structure with: 
% * *|Result.Isc|* - Short circuit DC current (A)
% * *|Result.Imp|* - Max power DC current (A)
% * *|Result.Ix|* 
% * *|Result.Ixx|*
% * *|Result.Voc|* - Open circuit DC voltage(V)
% * *|Result.Vmp|* - Max power DC voltage (V)
% * *|Result.Pmp|* - Max DC power (W)
%   components are vectors of the same size as Ee.
%% Example
% This example shows the use of the Sandia PV Array Performance Model with
% a Canadian Solar 220 W module at ~1,000 W/m^2 and a cell temperature of
% 70 deg C.
Module = pvl_sapmmoduledb(123,'SandiaModuleDatabase_20120925.xlsx',1)
%%
Ee = 1; %suns
celltemp = 70; % deg C
Result = pvl_sapm(Module, Ee, celltemp)
%% References
%%
% * [1] King, D. et al, 2004, "Sandia Photovoltaic Array Performance Model", SAND2004-3535,
% Sandia National Laboratories, Albuquerque, NM
% <http://energy.sandia.gov/wp/wp-content/gallery/uploads/SAND-2004_PV-Performance-Array-Model.pdf Web Link>
%
%% See Also 
% <pvl_sapmmoduledb_help.html |pvl_sapmmoduledb|>, 
% <pvl_sapmcelltemp_help.html |pvl_sapmcelltemp|> 
%%
% Copyright 2012 Sandia National Laboratories

