%% pvl_pres2alt 
% Determine altitude from site pressure
%
%% Syntax
% |altitude = pvl_pres2alt(pressure)| 
%
%% Description
% |altitide = pvl_pres2alt(pressure)|
% determines the |altitude| (in meters above sea level) of a 
%   site on Earth's surface given its atmospheric pressure (in Pascals). 
%   Output |altitude| is given in meters above sea level. |altitude| is of the same size 
%   as |pressure|.
%
%% Assumptions
%%
%
% * Pressure at mean sea level = 101325 Pa
% * Temperature at zero altitude = 288.15 K
% * Gravitational acceleration = 9.80665 m/s^2
% * Lapse rate = -6.5E-3 K/m
% * Gas constant for air = 287.053 J/(kg*K)
% * Relative Humidity = 0%
%
%% Inputs
%%
% * *|pressure|* - atmospheric pressure (in Pascals) of a 
% site on Earth's surface given its altitude
%
%% Outputs
%%
% * *|altitude|* - altitude (in meters above sea level)
%
%% Example
Alt1 = pvl_pres2alt(101325) % Sea level, result should be near zero 
Alt2 = pvl_pres2alt(80000) % Approximate pressure near 2,000 meters abobe sea level
%% References
%   "A Quick Derivation relating altitude to air pressure" from Portland
%   State Aerospace Society, Version 1.03, 12/22/2004.
%
%% See Also
% <pvl_alt2pres_help.html |pvl_alt2pres|>,    
% <pvl_makelocationstruct_help.html |pvl_makelocationstruct|>
%%
% Copyright 2012 Sandia National Laboratories
