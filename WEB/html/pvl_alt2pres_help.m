%% pvl_alt2pres 
% Determine site pressure from altitude
%
%% Syntax
% |pressure = pvl_alt2pres(altitude)| 
%
%% Description
% Determines the atmospheric pressure (in Pascals) of a 
% site on Earth's surface given its altitude (in meters above sea level). 
% Output |Press| is given in Pascals. |Press| is of the same size 
% as |altitude|.
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
% * *|altitude|* - altitude (in meters above sea level)
%
%% Outputs
%%
% * *|pressure|* - atmospheric pressure (in Pascals) of a 
% site on Earth's surface given its altitude
%
%% Example
Press1 = pvl_alt2pres(0) %Pressure at mean sealevel
Press2 = pvl_alt2pres(1000) % Pressure at 1,000 meters obove mean sea level
%% References
%   "A Quick Derivation relating altitude to air pressure" from Portland
%   State Aerospace Society, Version 1.03, 12/22/2004.
%% See Also 
% <pvl_pres2alt_help.html |pvl_pres2alt|> , <pvl_makelocationstruct_help.html |pvl_makelocationstruct|>
%%
% Copyright 2012 Sandia National Laboratories