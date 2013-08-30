%% pvl_relativeairmass    
% Gives the relative (not pressure-corrected) airmass
%
%% Syntax
% |AM = pvl_relativeairmass(z)| 
%
%% Description
% Gives the airmass at sea-level when given a 
% sun zenith angle, z (in degrees).
% |AM = pvl_relativeairmass(z, model)| The |model| variable allows selection 
% of different airmass models
% (described below). |model| must be a valid string. If |model| is not 
% included or is not valid, the default model is |'kastenyoung1989'|.
% AM will return |NaN| values for all zenith angles greater than 90 degrees.
%
%% Inputs
%%
% * *|z|* - Zenith angle of the sun.  Note that some models use the apparent (refraction corrected)
%     zenith angle, and some models use the true (not refraction-corrected)
%     zenith angle. See model descriptions to determine which type of zenith
%     angle is required.
% * *|model|* - String variable indicating the airmass model to be used.  Available models 
%     are listed below.  If |model| is not included or is not valid, 
%     the default model is 'kastenyoung1989'.  
%% Available Air Mass Models
%%
% * |'simple'| - secant(apparent zenith angle) - Note that this gives -inf at zenith=90
% * |'kasten1966'| - See reference [1] - requires apparent sun zenith
% * |'youngirvine1967'| - See reference [2] - requires true sun zenith
% * |'kastenyoung1989'| - See reference [3] - Default model.  requires apparent sun zenith
% * |'gueymard1993'| - See reference [4] - requires apparent sun zenith
% * |'young1994'| - See reference [5] - requries true sun zenith
% * |'pickering2002'| - See reference [6] - requires apparent sun zenith
%
%% Outputs
%%
% * *|AM|* - Relative airmass at sea level.  Will return |NaN| values for all zenith 
%     angles greater than 90 degrees.  

%%   
% Note that some models use the apparent (refraction corrected)
%   zenith angle, and some models use the true (not refraction-corrected)
%   zenith angle. See model descriptions to determine which type of zenith
%   angle is required.
% If "model" is not included or is not valid, the default model is 'kastenyoung1989'.
%
%% Example 1
% Use default model near AM 1.5
%
AM = pvl_relativeairmass(45)
%% Example 2
% Compare models at low sun angles
AM = zeros(100,7);
z = zeros(100,1);
z = z+ (80:0.1:89.9)';
models = {'simple' 'kasten1966' 'youngirvine1967' 'kastenyoung1989' 'gueymard1993' ...
    'young1994' 'pickering2002'};
for i=1:7
    AM(:,i) = pvl_relativeairmass(z,models{i});
end
figure
plot(z,AM(:,1))
hold all
for i=2:7
    plot(z,AM(:,i))
end
ylim([0 40])
legend(models,'Location','NW')
xlabel('Solar Zenith Angle (deg)')
ylabel('Relative Air Mass')
title('Relative Air Mass Model Comparisons','FontSize',14)


%% References
%%
% * [1] Fritz Kasten. "A New Table and Approximation Formula for the
% Relative Optical Air Mass". Technical Report 136, Hanover, N.H.: U.S.
% Army Material Command, CRREL.
% * [2] A. T. Young and W. M. Irvine, "Multicolor Photoelectric Photometry
% of the Brighter Planets," The Astronomical Journal, vol. 72, 
% pp. 945-950, 1967.
% * [3] Fritz Kasten and Andrew Young. "Revised optical air mass tables and
% approximation formula". Applied Optics 28:4735–4738
% * [4] C. Gueymard, "Critical analysis and performance assessment of 
% clear sky solar irradiance models using theoretical and measured data,"
% Solar Energy, vol. 51, pp. 121-138, 1993.
% * [5] A. T. Young, "AIR-MASS AND REFRACTION," Applied Optics, vol. 33, 
% pp. 1108-1110, Feb 1994.
% * [6] Keith A. Pickering. "The Ancient Star Catalog". DIO 12:1, 20,
%
%% See Also
% <pvl_absoluteairmass_help.html |pvl_absoluteairmass|>, 
% <pvl_ephemeris_help.html |pvl_ephemeris|> 
%%
% Copyright 2012 Sandia National Laboratories

