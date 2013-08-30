%% pvl_matlabtime2excel 
% Convert a MATLAB serial datenum to a time recognizable by Microsoft Excel
% 
%% Syntax
% |ExcTime = pvl_matlabtime2excel(MatTime)|
%
%% Description
%    Converts a MATLAB serial datenum to a serial time
%    number recognizable by Microsoft Excel versions. Specifically, this
%    converts MATLAB's date system (days from Jan-1-0000 00:00:00) to the
%    1900 date system (days from Jan-1-1900 00:00:00). 
%
%% Inputs
%%
% * *|MatTime|* - an array of dates in MATLAB's serial datenum format.
%
%% Outputs    
%%
% * *|ExcTime|* - an array of dates in Microsoft Excel's serial 1900 date
%    system. |ExcTime| is of the same size as |MatTime|.
%
%% Example
%
MatTime = datenum('24-Oct-2003 12:45:07');
pvl_matlabtime2excel(MatTime)
%% See Also 
% <pvl_exceltime2matlab_help.html |pvl_exceltime2matlab|>  

%%
% Copyright 2012 Sandia National Laboratories

