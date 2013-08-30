%% pvl_kingdiffuse 
% Determine diffuse irradiance from the sky on a tilted surface using the King model
%
%% Syntax
% |SkyDiffuse = pvl_kingdiffuse(SurfTilt, DHI, GHI, SunZen)|
%
%% Description
% This model (developed by David L. King at Sandia National Laboratories )
% determines the diffuse irradiance from the sky
% (ground reflected irradiance is not included in this algorithm) on a
% tilted surface using the surface tilt angle, diffuse horizontal
% irradiance, global horizontal irradiance, and sun zenith angle. Note
% that this model is not well documented and has not been published in
% any fashion (as of January 2012).
%
%% Inputs
%%
% * *|SurfTilt|* - a scalar or vector of surface tilt angles in decimal degrees. 
%     If SurfTilt is a vector it must be of the same size as all other vector
%     inputs. SurfTilt must be >=0 and <=180. The tilt angle is defined as
%     degrees from horizontal (e.g. surface facing up = 0, surface facing
%     horizon = 90)
% * *|DHI|* - a scalar or vector of diffuse horizontal irradiance in W/m^2. If DHI
%     is a vector it must be of the same size as all other vector inputs. 
%     DHI must be >=0.
% * *|GHI|* - a scalar or vector of global horizontal irradiance in W/m^2. If GHI
%     is a vector it must be of the same size as all other vector inputs. 
%     GHI must be >=0.
% * *|SunZen|* - a scalar or vector of apparent (refraction-corrected) zenith
%     angles in decimal degrees. If SunZen is a vector it must be of the
%     same size as all other vector inputs. SunZen must be >=0 and <=180.
%
%% Outputs
%%
% * *|SkyDiffuse|* - the diffuse component of the solar radiation  on an
%     arbitrarily tilted surface as given by a model developed by David L.
%     King at Sandia National Laboratories (retired). 
%
%% Example
%
SurfTilt = 30;
SurfAz = 180;
DHI = 47;
GHI = 473;
SunZen = 60;
SkyDiffuse = pvl_kingdiffuse(SurfTilt, DHI, GHI, SunZen)
%% References
%   None
%
%% See Also 
% <pvl_perez_help.html |pvl_perez|>,
% <pvl_reindl1990_help.html |pvl_reindl1990|>, 
% <pvl_klucher1979_help.html |pvl_klucher1979|>, 
% <pvl_haydavies1980_help.html |pvl_haydavies1980|>, 
% <pvl_grounddiffuse_help.html |pvl_grounddiffuse|>, 
% <pvl_ephemeris_help.html |pvl_ephemeris|>   
%
%%
% Copyright 2012 Sandia National Laboratories
