%% pvl_readtmy3
% Read a Typical Meteological Year 3 (TMY3) file in to a MATLAB struct
%
%% Syntax
%%
% * |TMYData = pvl_readtmy3()|
% * |TMYData = pvl_readtmy3(FileName)|
%
%% Description
% Read a TMY3 file and make a struct of the data. Note that values
% contained in the struct are unchanged from the TMY3 file (i.e. units 
% are retained). In the case of any discrepencies between this
% documentation and the TMY3 User's Manual ([1]), the TMY3 User's Manual
% takes precedence.
%%
% If |FileName| is not provided, the user will be prompted to browse to
%   an appropriate TMY3 file.
%
%% Inputs
%%
% * *|FileName|* - an optional argument which allows the user to select which
%     TMY3 format file should be read. A file path may also be necessary if
%     the desired TMY3 file is not in the MATLAB working path.
%
%% Outputs
%%
% *  *|TMYData|* - a struct with the following components listed below. Note
%     that for more detailed descriptions of each component, please consult
%     the TMY3 User's Manual ([1]), especially tables 1-1 through 1-6. If
%     the output size is not specified, it is a 8760x1 vector of type double.
%%
% * *|TMYData.SiteID|* - Site identifier code (USAF number), scalar double
% * *|TMYData.StationName|* - Station name, 1x1 cell string
% * *|TMYData.StationState|* - Station state 2 letter designator, 1x1 cell string
% * *|TMYData.SiteTimeZone|* - Hours from Greenwich, scalar double
% * *|TMYData.SiteLatitude|* - Latitude in decimal degrees, scalar double
% * *|TMYData.SiteLongitude|* - Longitude in decimal degrees, scalar double
% * *|TMYData.SiteElevation|* - Site elevation in meters, scalar double
% * *|TMYData.DateString|* - Date string in mm/dd/yy format, 8760x1 cell string
% * *|TMYData.TimeString|* - Time string in HH:MM format, local standard time, 8760x1 cell string
% * *|TMYData.DateNumber|* - Combination of date/time in MATLAB serial date (datenum) format, 8760x1 double
% * *|TMYData.ETR|* - Extraterrestrial horizontal radiation recv'd during 60 minutes prior to timestamp, Wh/m^2
% * *|TMYData.ETRN|* - Extraterrestrial normal radiation recv'd during 60 minutes prior to timestamp, Wh/m^2
% * *|TMYData.GHI|* - Direct and diffuse horizontal radiation recv'd during 60 minutes prior to timestamp, Wh/m^2
% * *|TMYData.GHISource|* - See [1], Table 1-4
% * *|TMYData.GHIUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.DNI|* - Amount of direct normal radiation (modeled) recv'd during 60 mintues prior to timestamp, Wh/m^2
% * *|TMYData.DNISource|* - See [1], Table 1-4
% * *|TMYData.DNIUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.DHI|* - Amount of diffuse horizontal radiation recv'd during 60 minutes prior to timestamp, Wh/m^2
% * *|TMYData.DHISource|* - See [1], Table 1-4
% * *|TMYData.DHIUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.GHillum|* - Avg. total horizontal illuminance recv'd during the 60 minutes prior to timestamp, lx
% * *|TMYData.GHillumSource|* - See [1], Table 1-4
% * *|TMYData.GHillumUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.DNillum|* - Avg. direct normal illuminance recv'd during the 60 minutes prior to timestamp, lx
% * *|TMYData.DNillumSource|* - See [1], Table 1-4
% * *|TMYData.DNillumUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.DHillum|* - Avg. horizontal diffuse illuminance recv'd during the 60 minutes prior to timestamp, lx
% * *|TMYData.DHillumSource|* - See [1], Table 1-4
% * *|TMYData.DHillumUncertainty|* - Uncertainty based on random and bias error estimates - see [2]
% * *|TMYData.Zenithlum|* - Avg. luminance at the sky's zenith during the 60 minutes prior to timestamp, cd/m^2
% * *|TMYData.ZenithlumSource|* - See [1], Table 1-4
% * *|TMYData.ZenithlumUncertainty|* - Uncertainty based on random and bias error estimates - see [1] section 2.10
% * *|TMYData.TotCld|* - Amount of sky dome covered by clouds or obscuring phenonema at time stamp, tenths of sky
% * *|TMYData.TotCldSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.TotCldUnertainty|* - See [1], Table 1-6
% * *|TMYData.OpqCld|* - Amount of sky dome covered by clouds or obscuring phenonema that prevent observing the 
% * *|  sky at time stamp, tenths of sky
% * *|TMYData.OpqCldSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.OpqCldUncertainty|* - See [1], Table 1-6
% * *|TMYData.DryBulb|* - Dry bulb temperature at the time indicated, deg C
% * *|TMYData.DryBulbSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.DryBulbUncertainty|* - See [1], Table 1-6
% * *|TMYData.DewPoint|* - Dew-point temperature at the time indicated, deg C
% * *|TMYData.DewPointSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.DewPointUncertainty|* - See [1], Table 1-6
% * *|TMYData.RHum|* - Relative humidity at the time indicated, percent
% * *|TMYData.RHumSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.RHumUncertainty|* - See [1], Table 1-6
% * *|TMYData.Pressure|* - Station pressure at the time indicated, 1 mbar
% * *|TMYData.PressureSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.PressureUncertainty|* - See [1], Table 1-6
% * *|TMYData.Wdir|* - Wind direction at time indicated, degrees from north (360 = north; 0 = undefined,calm) 
% * *|TMYData.WdirSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.WdirUncertainty|* - See [1], Table 1-6
% * *|TMYData.Wspd|* - Wind speed at the time indicated, meter/second
% * *|TMYData.WspdSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.WspdUncertainty|* - See [1], Table 1-6
% * *|TMYData.Hvis|* - Distance to discernable remote objects at time indicated (7777=unlimited), meter
% * *|TMYData.HvisSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.HvisUncertainty|* - See [1], Table 1-6
% * *|TMYData.CeilHgt|* - Height of cloud base above local terrain (7777=unlimited), meter
% * *|TMYData.CeilHgtSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.CeilHgtUncertainty|* - See [1], Table 1-6
% * *|TMYData.Pwat|* - Total precipitable water contained in a column of unit cross section from 
%    earth to top of atmosphere, cm
% * *|TMYData.PwatSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.PwatUncertainty|* - See [1], Table 1-6
% * *|TMYData.AOD|* - The broadband aerosol optical depth per unit of air mass due to extinction by
%    aerosol component of atmosphere, unitless
% * *|TMYData.AODSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.AODUncertainty|* - See [1], Table 1-6
% * *|TMYData.Alb|* - The ratio of reflected solar irradiance to global horizontal irradiance, unitless
% * *|TMYData.AlbSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.AlbUncertainty|* - See [1], Table 1-6
% * *|TMYData.Lprecipdepth|* - The amount of liquid precipitation observed at indicated time for the period indicated 
%    in the liquid precipitation quantity field, millimeter
% * *|TMYData.Lprecipquantity|* - The period of accumulation for the liquid precipitation depth field, hour
% * *|TMYData.LprecipSource|* - See [1], Table 1-5, 8760x1 cell array of strings
% * *|TMYData.LprecipUncertainty|* - See [1], Table 1-6
%
%% Example
%
pvl_readtmy3('723650TY.csv')
%% References
%%
% * [1] Wilcox, S and Marion, W. "Users Manual for TMY3 Data Sets".
%   NREL/TP-581-43156, Revised May 2008.
%   <http://www.google.com/url?sa=t&rct=j&q=users%20manual%20for%20tmy3%20data%20sets&source=web&cd=1&ved=0CCwQFjAA&url=http%3A%2F%2Fwww.nrel.gov%2Fdocs%2Ffy08osti%2F43156.pdf&ei=4MUqT8nRFcWQiALj1OXhCg&usg=AFQjCNHRkrzVnyvX8KlW1oQcLYedayl-Gw&cad=rja
%   Web Link>
%
% * [2] Wilcox, S. (2007). National Solar Radiation Database 1991–2005 
%   Update: User’s Manual. 472 pp.; NREL Report No. TP-581-41364.
% <http://www.google.com/url?sa=t&rct=j&q=national%20solar%20radiation%20database%201991%E2%80%932005%20%20update%3A%20user%E2%80%99s%20manual&source=web&cd=1&sqi=2&ved=0CDMQFjAA&url=http%3A%2F%2Fwww.nrel.gov%2Fdocs%2Ffy07osti%2F41364.pdf&ei=O8YqT6S-MsKqiQKuiIzGCg&usg=AFQjCNGQSzL6v1blbJZZrcIdlCd4QTDZ7Q
% Web Link>
%
%% See Also
% <pvl_makelocationstruct_help.html |pvl_makelocationstruct|> ,
% <pvl_maketimestruct_help.html.html |pvl_maketimestruct|> 
%%
% Copyright 2012 Sandia National Laboratories

