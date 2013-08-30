%% pvl_klucher1979 
% Determine diffuse irradiance from the sky on a tilted surface using Klucher's 1979 model
%
%% Syntax
% |SkyDiffuse =  pvl_klucher1979(SurfTilt, SurfAz, DHI, GHI, SunZen,
% SunAz)|
%
%% Description
% Klucher's 1979 model determines the diffuse irradiance from the sky
% (ground reflected irradiance is not included in this algorithm) on a
% tilted surface using the surface tilt angle, surface azimuth angle,
% diffuse horizontal irradiance, direct normal irradiance, global
% horizontal irradiance, extraterrestrial irradiance, sun zenith angle,
% and sun azimuth angle.
%
%% Inputs
%%
% * *|SurfTilt|* - a scalar or vector of surface tilt angles in decimal degrees. 
%     If SurfTilt is a vector it must be of the same size as all other vector
%     inputs. SurfTilt must be >=0 and <=180. The tilt angle is defined as
%     degrees from horizontal (e.g. surface facing up = 0, surface facing
%     horizon = 90)
% * *|SurfAz|* - a scalar or vector of surface azimuth angles in decimal degrees. 
%     If SurfAz is a vector it must be of the same size as all other vector
%     inputs. SurfAz must be >=0 and <=360. The Azimuth convention is defined
%     as degrees east of north (e.g. North = 0, East = 90, West = 270).
% * *|DHI|* - a scalar or vector of diffuse horizontal irradiance in W/m^2. If DHI
%     is a vector it must be of the same size as all other vector inputs. 
%     DHI must be >=0. Values of DHI which are < GHI will be set to GHI.
% * *|GHI|* - a scalar or vector of global horizontal irradiance in W/m^2. If GHI
%     is a vector it must be of the same size as all other vector inputs. 
%     GHI must be >=0.
% * *|SunZen|* - a scalar or vector of apparent (refraction-corrected) zenith
%     angles in decimal degrees. If SunZen is a vector it must be of the
%     same size as all other vector inputs. SunZen must be >=0 and <=180.
% * *|SunAz|* - a scalar or vector of sun azimuth angles in decimal degrees. 
%     If SunAz is a vector it must be of the same size as all other vector
%     inputs. SunAz must be >=0 and <=360. The Azimuth convention is defined
%     as degrees east of north (e.g. North = 0, East = 90, West = 270).
%
%% Outputs
%%
% * *|SkyDiffuse|* - the diffuse component of the solar radiation  on an
%     arbitrarily tilted surface defined by the Klucher model as given in
%     Loutzenhiser et. al (2007) equation 4.
%     SkyDiffuse is the diffuse component ONLY and does not include the ground
%     reflected irradiance or the irradiance due to the beam.
%     SkyDiffuse is a column vector vector with a number of elements equal to
%     the input vector(s).
%
%% Example
%
SurfTilt = 30;
SurfAz = 180;
DHI = 47;
%DNI = 969;
GHI = 473;
%HExtra = pvl_extraradiation(60);
SunZen = 60;
SunAz = 161;
pvl_klucher1979(SurfTilt, SurfAz, DHI, GHI, SunZen, SunAz)
%% References
%%
% * [1] Loutzenhiser P.G. et. al. "Empirical validation of models to compute
%   solar irradiance on inclined surfaces for building energy simulation"
%   2007, Solar Energy vol. 81. pp. 254-267
% * [2] Klucher, T.M., 1979. Evaluation of models to predict insolation on tilted
%   surfaces. Solar Energy 23 (2), 111–114.
%
%% See Also 
% <pvl_perez_help.html |pvl_perez|>,
% <pvl_reindl1990_help.html |pvl_reindl1990|>, 
% <pvl_kingdiffuse_help.html |pvl_kingdiffuse|>, 
% <pvl_haydavies1980_help.html |pvl_haydavies1980|>, 
% <pvl_grounddiffuse_help.html |pvl_grounddiffuse|>, 
% <pvl_ephemeris_help.html |pvl_ephemeris|>   
%
%%
% Copyright 2012 Sandia National Laboratories
