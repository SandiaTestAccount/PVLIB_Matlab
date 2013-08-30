function Inverterparam = pvl_snlinverterdb(uniqueID, varargin)
% PVL_SNLINVERTERDB Retrieves coefficients for the Sandia Performance Model for Grid-Connected Photovoltaic Inverters
%
% Syntax
%   Inverterparam = pvl_snlinverterdb(uniqueID)
%   Inverterparam = pvl_snlinverterdb(uniqueID, DBfile)
%
% Description
%   Retrieve a set of performance parameter coefficients for the 
%   Sandia Performance Model for Grid-Connected Photovoltaic Inverters [1]. 
%   The performance parameters are provided as an Excel workbook in the
%   same form as the <Inverters_2012.1.12.xlsx> file included with 
%   the toolbox. A description of each of the inverter parameters associated
%   with the model is given in the Output section of this help document, also,
%   the column numbers of the data within the Excel sheet is listed.
%
% Input
%   uniqueID - Each inverter in the workbook is given a unique
%     identification number. Provide the unique identification number of
%     the desired inverter.
%   DBfile - an optional argument which allows the user to select which
%     "database" file should be read. A full file path may also be necessary
%     if the desired file is not in the MATLAB working path. If the input
%     DBfile is not included, the user will be prompted to select a file
%     using a browsing window. The file should be an Excel workbook with
%     a single worksheet called "Parameters". Row 1 should be text
%     headers. Rows 2-n contain the data specified below in columns 1
%     through 22 (A through V).
%
% Output
%   Inverterparam - A struct of inverter performance parameters with
%     the following components. Note that for more detailed descriptions of
%     each component, please consult reference [1]. Unfilled values in the
%     spreadsheet will be returned as NaN.
%
%   Inverterparam.Manufacturer = Inverter manufacturer name (text) given in  
%     column 1.
%   Inverterparam.Model = Inverter model number (text), may include a
%     notation as to the output voltage level of the inverter given in
%     column 2.
%   Inverterparam.Source = Source of test data (text) given in column 3.
%     Typically test data is graciously provided by the California Energy
%     Commission (CEC) as part of their Go Solar California! campaign.
%   Inverterparam.Vac = AC output voltage, in volts RMS, given in column 4.
%   Inverterparam.Vintage = The year in which the test was conducted, given
%     in column 5.
%   Inverterparam.Pac0 = Maximum AC power "rating" for the inverter at
%     nominal operating conditions, in watts. Assumed to be an upper limit.
%     Given in column 6.
%   Inverterparam.Pdc0 = The DC power level, in watts, at which the AC
%     power rating (Pac0) is achieved under nominal operating conditons.
%     Given in column 7.
%   Inverterparam.Vdc0 = The DC voltage level, in volts, at which the AC
%     power rating is achieved at the reference operating condition. Given
%     in column 8.
%   Inverterparam.Ps0  = The DC power, in watts, required to start the
%     inversion process or self-consumption by the inverter. Given in
%     column 9.
%   Inverterparam.C0 = Parameter defining the curvature of the relationship
%     between AC power and DC power at the reference operating condition,
%     the default value of 0 gives a linear relationship. Units of 1/watts.
%     Given in column 10.
%   Inverterparam.C1 = Empirical coefficient allowing Pdc0 to vary linearly
%     with DC voltage input, default value is 0. Units of 1/volts. Given in
%     column 11.
%   Inverterparam.C2 = Empirical coefficient allowing Ps0 to vary linearly
%     with DC voltage input, default value is 0. Units of 1/volts. Given in
%     column 12.
%   Inverterparam.C3 = Empirical coefficient allowing C0 to vary linearly
%     with DC voltage input, default value is 0. Units of 1/volts. Given in
%     column 13.
%   Inverterparam.Pnt = AC power, in watts, consumed at night (tare-loss)
%     to maintain circuitry required to sense PV array voltage. Given in
%     column 14.
%   Inverterparam.Vdcmax = Maximum DC voltage which may be applied to the
%     inverter, in volts. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     15.
%   Inverterparam.Idcmax = Maximum DC current which may be applied to the
%     inverter, in amps. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     16.
%   Inverterparam.MPPTLow = Minimum DC voltage, in volts, at which the
%     maximum power point tracking (MPPT) algorithm of the inverter may
%     function. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     17.
%   Inverterparam.MPPTHi = Maximum DC voltage, in volts, at which the
%     maximum power point tracking (MPPT) algorithm of the inverter may
%     function. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     18.
%   Inverterparam.TambLow = Minimum operating temperature of the inverter
%     in degrees C. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     19.
%   Inverterparam.TambHi = Maximum operating temperature of the inverter
%     in degrees C. This data is typically found on the specification
%     sheet, but is not required for performance modeling. Given in column
%     20.
%   Inverterparam.Weight = Weight of the inverter in either pounds or
%     kilograms (generally it is unknown due to poor record keeping). 
%     This data is typically found on the specification sheet, but is not 
%     required for performance modeling. Given in column 21.
%   Inverterparam.UniqueID = The unique identification number for each
%     inverter. The manufacturer or model number may change, but the unique
%     ID will remain the same. Given in column 22.
%
% References
%   [1] King, D. et al, 2007, "Performance Model for Grid-Connected 
%     Photovoltaic Inverters", SAND2007-5036, Sandia National 
%     Laboratories, Albuquerque, NM. 
%
%
% See also PVL_SNLINVERTER    PVL_SAMLIBRARYREADER_SNLINVERTERS

% Unique ID is the unique identifier given to each inverter in the Sandia
% Inverter database. It is NOT the row number.

% Warn that this function will soon be removed
warning(['The function pvl_snlinverterdb will be removed in a future '...
    'version of PV_LIB. For a more up-to-date list of Sandia Inverter '...
    'Model coefficients, see included .mat file which captureS the '...
    'latest coefficients from the System Advisor Model libraries, '...
    'or use the SAM library reader function to generate a new .mat file.']);

if (size(varargin) == 0)
    [FileNameAndExt, FilePath]=uigetfile({ '*.xls;*.xlsx' , 'Excel Files (*.xls, *.xlsx)';'*.*', 'All Files (*.*)'}, 'Select a file containing SNL inverter coefficients');
    FilePathAndNameAndExt = [FilePath filesep FileNameAndExt];
else 
    FilePathAndNameAndExt = varargin{1};
end

p = inputParser;
p.addRequired('uniqueID', @(x) (x>0 && isscalar(x) && isnumeric(x)))
p.addRequired('FilePathAndNameAndExt',@(x) ischar(x))
p.parse(uniqueID, FilePathAndNameAndExt);

Filename = p.Results.FilePathAndNameAndExt;
uniqueID = p.Results.uniqueID;

% Filename = 'S:\Databases\Inverters\Inverters_10_10_11.xlsx';
% uniqueID = 715;

NumberHeaderRows = 1;

[~, ~, raw] = xlsread(Filename);
% Thise section unnecessary since I'm not parsing the raw data
% numericvals = raw(2:end,4:end);
% numericvals(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),numericvals)) = {''}; %replace nonnumeric and empty values with []

rownumber = find(cell2mat(raw(NumberHeaderRows+1:end,22))==uniqueID)+NumberHeaderRows;
%rownumber = find(cell2mat(numericvals(:,end))==uniqueID);
if numel(rownumber) == 0
    error(['Error, could not find inverter with unique ID number ' num2str(uniqueID) ...
        ' in file ' FilePathAndNameAndExt '. Please check file to '...
        'ensure that the unique ID provided is associated with the desired inverter.'])
end

Inverterparam.Manufacturer = raw{rownumber,1};
Inverterparam.Model   = raw{rownumber,2};
Inverterparam.Source = raw{rownumber,3};
Inverterparam.Vac = raw{rownumber,4};
Inverterparam.Vintage = raw{rownumber,5};
Inverterparam.Pac0 = raw{rownumber,6};
Inverterparam.Pdc0 = raw{rownumber,7};
Inverterparam.Vdc0 = raw{rownumber,8};
Inverterparam.Ps0  = raw{rownumber,9};
Inverterparam.C0   = raw{rownumber,10};
Inverterparam.C1   = raw{rownumber,11};
Inverterparam.C2   = raw{rownumber,12};
Inverterparam.C3   = raw{rownumber,13};
Inverterparam.Pnt  =  raw{rownumber,14};
Inverterparam.Vdcmax = raw{rownumber,15};
Inverterparam.Idcmax = raw{rownumber,16};
Inverterparam.MPPTLow = raw{rownumber,17};
Inverterparam.MPPTHi = raw{rownumber,18};
Inverterparam.TambLow = raw{rownumber,19};
Inverterparam.TambHi = raw{rownumber,20};
Inverterparam.Weight = raw{rownumber,21};
Inverterparam.UniqueID = raw{rownumber,22};