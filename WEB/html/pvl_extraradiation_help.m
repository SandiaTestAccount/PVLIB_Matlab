%% pvl_extraradiation 
% Determine extraterrestrial radiation from day of year
%
%% Syntax
%   Ea = pvl_extraradiation(doy)
%
%% Description
% Determine the amount of extraterrestrial solar radiation.
%
%%  Inputs 
%%
% * *|doy|* - an array specifying the day of year. Valid values are >=1 and <367.
%
%%  Outputs 
%%
% * *|Ea|* - extraterrestrial radiation present in W/m^2
%  on a surface which is normal to the sun. |Ea| is of the same size as the
%  input |doy|.
%
%% Example
% Calculate extraterrestrial radiation for doy = 60;
Ea = pvl_extraradiation(60)
%% References
%%
% * http://solardat.uoregon.edu/SolarRadiationBasics.html, Eqs. SR1 and SR2
% * SR1 	   	Partridge, G. W. and Platt, C. M. R. 1976. Radiative Processes in Meteorology and Climatology.
% * SR2 	   	Duffie, J. A. and Beckman, W. A. 1991. Solar Engineering of Thermal Processes, 2nd edn. J. Wiley and Sons, New York.
%
%% See Also 
% <pvl_date2doy_help |pvl_date2doy|>, 
% <pvl_reindel1990_help.html |pvl_reindel1990|>
%%
% Copyright 2012 Sandia National Laboratories
