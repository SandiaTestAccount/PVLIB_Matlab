%% pvl_physicaliam 
% Determine the incidence angle modifier using refractive index, glazing thickness, and extinction coefficient
%
%% Syntax
% *   |IAM = pvl_physicaliam(K, L, n, theta)|
%
%% Description:
%%
% pvl_physicaliam calculates the incidence angle modifier as described in
% section 3 of [1]. The calculation is based upon a physical
% model of absorbtion and transmission through a cover. Required
% information includes, incident angle, cover extinction coefficient,
% cover thickness
%%
% Note: The authors of this function believe that eqn. 14 in [1] is
% incorrect. This function uses the following equation in its place:
% theta_r = arcsin(1/n * sin(theta)).
%
%% Inputs:
%%
% * *|K|* - The glazing extinction coefficient in units of 1/meters. Reference
%     [1] indicates that a value of  4 is reasonable for "water white"
%     glass. K must be a numeric scalar or vector with all values >=0. If K
%     is a vector, it must be the same size as all other input vectors.
% * *|L|* - The glazing thickness in units of meters. Reference [1] indicates
%     that 0.002 meters (2 mm) is reasonable for most glass-covered
%     PV panels. L must be a numeric scalar or vector with all values >=0. 
%     If L is a vector, it must be the same size as all other input vectors.
% * *|n|* - The index of refraction (unitless). Reference [1]
%     indicates that a value of 1.526 is acceptable for glass. n must be a 
%     numeric scalar or vector with all values >=0. If n is a vector, it 
%     must be the same size as all other input vectors.
% * *|theta|* - The angle of incidence between the module normal vector and the
%     sun-beam vector in degrees. Theta must be a numeric scalar or vector.
%     For any values of theta where abs(theta)>90, IAM is set to 0. For any
%     values of theta where -90 < theta < 0, theta is set to abs(theta) and
%     evaluated. A warning will be generated if any(theta<0 or theta>90).
% 
%% Outputs:
%%
% * *|IAM|* - The incident angle modifier as specified in eqns. 14-16 of [1].
%     IAM is a column vector with the same number of elements as the
%     largest input vector.
%
%% Example
% This example plots the IAM for glass over a range of incident angles.
K=4;             %glazing extinction coefficient in units of 1/meters
L=0.02;          %glazing thickness in units of meters
n= 1.56;         %index of refraction
theta = 0:90;    %incident angle in degrees
IAM = pvl_physicaliam(K, L, n, theta);
figure
plot(theta,IAM)
xlabel('Incident Angle (deg)')
ylabel('IAM')
title('Physical IAM Model Example')
%% References:
%
% * [1] W. De Soto et al., "Improvement and validation of a model for
%     photovoltaic array performance", Solar Energy, vol 80, pp. 78-88,
%     2006.
%
% * [2] Duffie, John A. & Beckman, William A.. ( © 2006). Solar Engineering 
%     of Thermal Processes, third edition. [Books24x7 version] Available 
%     from http://common.books24x7.com/toc.aspx?bookid=17160. 
%
%% See also 
% <pvl_getaoi_help.html |pvl_getaoi|> ,           
% <pvl_ephemeris_help.html |pvl_ephemeris|> ,
% <pvl_spa_help.html |pvl_spa|> ,
% <pvl_ashraeiam_help.html |pvl_ashraeiam|> 

%%
% Copyright 2012 Sandia National Laboratories
