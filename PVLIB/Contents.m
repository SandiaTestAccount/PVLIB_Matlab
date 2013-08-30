% Toolbox SNL_PVLib provides a set of functions useful for modeling solar
% photovoltaic systems
% Version 001 Jan-2012


%% Time and Location Utilities
%   pvl_date2doy           - Determine day of year from year, month of year, and day of month
%   pvl_doy2date           - Determines the Year, Month of year, and Day of month given the year and day of year
%   pvl_leapyear           - Determine if a given year is a leap year using 400 year cycles
%   pvl_exceltime2matlab   - Convert a Microsoft Excel time to a MATLAB datenum
%   pvl_matlabtime2excel   - Convert a MATLAB serial datenum to a time recognizable by Microsoft Excel
%   pvl_rmbtime2matlab     - Creates a MATLAB datenum from the time convention used in Rocky Mountain Basic
%   pvl_maketimestruct     - Generate a time structure from MATLAB datenum and UTC offset code
%   pvl_makelocationstruct - Create a struct to define a site location

%% Irradiance and Atmospheric Functions
%   pvl_readtmy3           - Read a TMY3 file in to a MATLAB struct
%   pvl_readtmy2           - Read a TMY2 file in to a MATLAB struct
%   pvl_ephemeris          - Calculates the position of the sun given time, location, and optionally pressure and temperature
%   pvl_spa                - Calculates the position of the sun given time, location, and optionally pressure and temperature
%   pvl_extraradiation     - Determine extraterrestrial radiation from day of year
%   pvl_alt2pres           - Determine site pressure from altitude
%   pvl_pres2alt           - Determine altitude from site pressure
%   pvl_relativeairmass    - Gives the relative (not pressure-corrected) airmass
%   pvl_absoluteairmass    - Determine absolute (pressure corrected) airmass from relative airmass and pressure
%   pvl_disc               - Estimate Direct Normal Irradiance from Global Horizontal Irradiance using the DISC model
%   pvl_dirint             - Determine DNI from GHI using the DIRINT modification of the DISC model

%% Irradiance Translation Functions
%   pvl_grounddiffuse      - Estimate diffuse irradiance from ground reflections given irradiance, albedo, and surface tilt 
%   pvl_isotropicsky       - Determine diffuse irradiance from the sky on a tilted surface using isotropic sky model
%   pvl_reindl1990         - Determine diffuse irradiance from the sky on a tilted surface using Reindl's 1990 model
%   pvl_perez              - Determine diffuse irradiance from the sky on a tilted surface using one of the Perez models
%   pvl_kingdiffuse        - Determine diffuse irradiance from the sky on a tilted surface using the King model
%   pvl_klucher1979        - Determine diffuse irradiance from the sky on a tilted surface using Klucher's 1979 model
%   pvl_haydavies1980      - Determine diffuse irradiance from the sky on a tilted surface using Hay & Davies' 1980 model
%   pvl_getaoi             - Determine angle of incidence from surface tilt/azimuth and apparent sun zenith/azimuth
%   pvl_stdirrad2poa       - Estimate plane-of-array irradiance on a tilted plane 

%% Photovoltaic System Functions
%   pvl_sapmmoduledb       - Retrieves Sandia PV Array Performance Model coefficients
%   pvl_snlinverterdb      - Retrieves coefficients for the Sandia Performance Model for Grid-Connected Photovoltaic Inverters
%   pvl_sapmcelltemp       - Estimate cell temperature from irradiance, windspeed, ambient temperature, and module parameters (SAPM)
%   pvl_sapm               - Performs Sandia PV Array Performance Model to get 5 points on IV curve given SAPM module parameters, Ee, and cell temperature
%   pvl_snlinverter        - Converts DC power and voltage to AC power using Sandia's Grid-Connected PV Inverter model
%   pvl_singleaxis         - Determine the rotation angle of a 1 axis tracker, and sun incident angle to tracked surface 
