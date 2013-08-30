%% pvl_calcparams_desoto 
% Applies temperature and irradiance corrections to reference parameters per [1] 
%
%% Syntax
% * |[IL, I0, Rs, Rsh, nNsVth] = pvl_calcparams_desoto(S, Tcell, alpha_isc, ModuleParameters, dEgdt, EgRef)|
% * |[IL, I0, Rs, Rsh, nNsVth] = pvl_calcparams_desoto(S, Tcell, alpha_isc, ModuleParameters, dEgdt, EgRef, M)|
% * |[IL, I0, Rs, Rsh, nNsVth] = pvl_calcparams_desoto(S, Tcell, alpha_isc, ModuleParameters, dEgdt, EgRef, M, Sref)|
% * |[IL, I0, Rs, Rsh, nNsVth] = pvl_calcparams_desoto(S, Tcell, alpha_isc, ModuleParameters, dEgdt, EgRef, M, Sref, Tref)|
% * |[IL, I0, Rs, Rsh, nNsVth] = pvl_calcparams_desoto(S, Tcell, alpha_isc, ModuleParameters, dEgdt, EgRef, 'Sref', Sref, 'Tref', Tref)|
%   
%% Description
% Applies the temperature and irradiance corrections to the IL, I0, Rs, Rsh, and a parameters at reference conditions (IL_ref, I0_ref,
% etc.) according to the De Soto et. al description given in [1]. The results of this correction procedure may be used in a single diode
% model to determine IV curves at irradiance = S, cell temperature = Tcell.
%
%% Inputs:
%%
% * *|S|* - The irradiance (in W/m^2) absorbed by the module. S must be >= 0.
%      May be a vector of irradiances, but must be the same size as all
%      other input vectors. Due to a division by S in the script, any S
%      value equal to 0 will be set to 1E-10.
% * *|Tcell|* - The average cell temperature of cells within a module in C.
%      Tcell must be >= -273.15. May be a vector of cell temperatures, but 
%      must be the same size as all other input vectors.
% * *|alpha_isc|* - The short-circuit current temperature coefficient of the 
%      module in units of 1/C.
% * *|ModuleParameters|* - a struct with parameters describing PV module
%     performance at reference conditions according to DeSoto's paper. 
%     Parameters may be generated or found by lookup. For ease of use, a library 
%     of parameters may be found within the System Advisor Model (SAM) [2].
%     The SAM library has been provided as a .mat file (
%     |\Required Data\CECModuleDatabaseSAM2012.11.30.mat|), or may
%     be read and converted into a .mat file by the SAM library reader
%     function: |pvl_SAMLibraryReader_CECModules.m|. The ModuleParameters 
%     struct must contain (at least) the 
%     following 5 fields:
%%
% * *|ModuleParameters.a_ref|* - modified diode ideality factor parameter at
%          reference conditions (units of eV), a_ref can be calculated from the
%          usual diode ideality factor (n), number of cells in series (Ns),
%          and cell temperature (Tcell) per equation (2) in [1].
% * *|ModuleParameters.IL_ref|* - Light-generated current (or photocurrent) 
%          in amperes at reference conditions. This value is referred to 
%          as Iph in some literature.
% * *|ModuleParameters.I0_ref|* - diode reverse saturation current in amperes, 
%          under reference conditions.
% * *|ModuleParameters.Rsh_ref|* - shunt resistance under reference conditions (ohms)
% * *|ModuleParameters.Rs_ref|* - series resistance under reference conditions (ohms)
%%
% * *|EgRef|* - The energy bandgap at reference temperature (in eV). 1.121 eV
%      for silicon. EgRef must be >0.
% * *|dEgdT|* - The temperature dependence of the energy bandgap at SRC (in 1/C).
%      May be either a scalar value (e.g. -0.0002677 as in [1]) or a
%      vector of dEgdT values corresponding to each input condition (this
%      may be useful if dEgdT is a function of temperature).
% * *|M|* - An optional airmass modifier, if omitted, M is given a value of 1,
%      which assumes absolute (pressure corrected) airmass = 1.5. In this
%      code, M is equal to M/Mref as described in [1] (i.e. Mref is assumed
%      to be 1). Source [1] suggests that an appropriate value for M
%      as a function absolute airmass (AMa) may be:
%      |M = polyval([-0.000126, 0.002816, -0.024459, 0.086257, 0.918093],
%      AMa)|
%      M may be a vector, but must be of the same size as all other input
%      vectors. 
% * *|Sref|* - Optional reference irradiance in W/m^2. If omitted, a value of
%      1000 is used.
% * *|Tref|* - Optional reference cell temperature in C. If omitted, a value of
%      25 C is used.
%  
%% Outputs:   
%%
% * *|IL|* - Light-generated current in amperes at irradiance=S and 
%      cell temperature=Tcell. 
% * *|I0|* - Diode saturation curent in amperes at irradiance S and cell temperature Tcell. 
% * *|Rs|* - Series resistance in ohms at irradiance S and cell temperature Tcell.
% * *|Rsh|* - Shunt resistance in ohms at irradiance S and cell temperature Tcell.
% * *|nNsVth|* - modified diode ideality factor at irradiance S and cell temperature
%      Tcell. Note that in source [1] nNsVth = a (equation 2). nNsVth is the 
%      product of the usual diode ideality factor (n), the number of 
%      series-connected cells in the module (Ns), and the thermal voltage 
%      of a cell in the module (Vth) at a cell temperature of Tcell.
%
%% Notes:
% If the reference parameters in the ModuleParameters struct are read
% from a database or library of parameters (e.g. System Advisor Model),
% it is important to use the same EgRef and dEgdT values that
% were used to generate the reference parameters, regardless of the 
% actual bandgap characteristics of the semiconductor. For example, in 
% the case of the System Advisor Model library, created as described in 
% [2], EgRef and dEgdT for all modules were 1.121 and -0.0002677,
% respectively.
%
%% Example 1
% IV curves at a range of irradiance values
S = [200 400 600 800 1000 1100]; %Irradiance Levels (W/m^2) for parameter sets
Tcell = 45; %deg C 

load('CECModuleDatabaseSAM2012.11.30.mat')
% Yingli Energy (China) YL295P-35b  # 9764
Module = CECModuleDB(9764);
% Bandgap and Bandgap temperature dependence from [2]
EgRef = 1.121; %Reference band gap. 
C = -0.0002677;  %Band gap dependence on temperature. 

[IL, I0, Rs, Rsh, a] = pvl_calcparams_desoto(S, Tcell, Module.alpha_sc, Module, EgRef, C);
NumPoints = 1000;
[IVResult] = pvl_singlediode(IL, I0, Rs, Rsh, a, NumPoints);

figure
for i=1:6
plot(IVResult.V(i,:),IVResult.I(i,:))
hold on
scatter(IVResult.Vmp(i),IVResult.Imp(i),'filled')
text(2,IVResult.Isc(i)+0.3,[num2str(S(i)) ' W/m^2'])
end
xlabel('Voltage (V)')
ylabel('Current (A)')
title('Example IV Curve from Single Diode Model','FontSize',14)
ylim([0 11])
%% Example 2
% IV curves at a range of cell temperature values and at AM = 3
S = 1000; %Irradiance Levels for parameter sets
Tcell = [30 40 50 60 70 80]; %deg C 
AMa = 3; % Absolute (pressure corrected) airmass

% Bandgap and Bandgap temperature dependence from [2]
EgRef = 1.121; %Reference band gap. 
C = -0.0002677;  %Band gap dependence on temperature. 

% Representative coefficients for estimating M/Mref for Poly-crystalline Si 
% From Table A.1 in [1].
M = polyval([-0.000126 0.002816 -0.024459 0.086257 0.918093], AMa);

[IL, I0, Rs, Rsh, a] = pvl_calcparams_desoto(S, Tcell, Module.alpha_sc, Module, EgRef, C, M);
NumPoints = 1000;
[IVResult] = pvl_singlediode(IL, I0, Rs, Rsh, a, NumPoints);

figure
for i=1:6
plot(IVResult.V(i,:),IVResult.I(i,:))
hold on
scatter(IVResult.Vmp(i),IVResult.Imp(i),'filled')

end
xlabel('Voltage (V)')
ylabel('Current (A)')
title('IV Curves (Cell Temp from 30-80 deg C','FontSize',14)
ylim([0 11])
%% References:
%
% * [1] W. De Soto et al., "Improvement and validation of a model for
%     photovoltaic array performance", Solar Energy, vol 80, pp. 78-88,
%     2006.
%
% * [2] A. Dobos, "An Improved Coefficient Calculator for the California
%     Energy Commission 6 Parameter Photovoltaic Module Model", Journal of
%     Solar Energy Engineering, vol 134, 2012.
%
% * [3] D. King et al, "Sandia Photovoltaic Array Performance Model",
%     SAND2004-3535, Sandia National Laboratories, Albuquerque, NM
%
% * [4] O. Madelung, "Semiconductors: Data Handbook, 3rd ed." ISBN
%     3-540-40488-0
%
%% See also 
% <pvl_sapm_help.html |pvl_sapm|>,  
% <pvl_sapmcelltemp_help.html |pvl_sapmcelltemp|>,  
% <pvl_singlediode_help.html |pvl_singlediode|>  
%%
% Copyright 2012 Sandia National Laboratories



