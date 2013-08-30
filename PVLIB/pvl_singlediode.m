function [Result] = pvl_singlediode(IL, I0, Rs, Rsh, nNsVth, varargin)
% PVL_SINGLEDIODE Solve the single-diode model to obtain a photovoltaic IV curve
%
% Syntax
%   [Result] = pvl_singlediode(IL, I0, Rs, Rsh, nNsVth)
%   [Result] = pvl_singlediode(IL, I0, Rs, Rsh, nNsVth, NumPoints)
%
% Description
%   pvl_singlediode solves the single diode equation [1]:
%   I = IL - I0*[exp((V+I*Rs)/(nNsVth))-1] - (V + I*Rs)/Rsh
%   for I and V when given IL, I0, Rs, Rsh, and nNsVth (nNsVth = n*Ns*Vth) which
%   are described later. pvl_singlediode returns a struct which contains
%   the 5 points on the I-V curve specified in SAND2004-3535 [3], and can
%   optionally provide a full IV curve with a user-defined number of
%   points. If all IL, I0, Rs, Rsh, and nNsVth are scalar, a single curve
%   will be returned, if any are vectors (of the same length), multiple IV
%   curves will be calculated.
%
% Input Parameters:
%   IL - Light-generated current (photocurrent) in amperes under desired IV
%      curve conditions. May be a scalar or vector, but vectors must be of
%      same length as all other input vectors.
%   I0 - Diode saturation current in amperes under desired IV curve
%      conditions. May be a scalar or vector, but vectors must be of same
%      length as all other input vectors.
%   Rs - Series resistance in ohms under desired IV curve conditions. May
%      be a scalar or vector, but vectors must be of same length as all
%      other input vectors.
%   Rsh - Shunt resistance in ohms under desired IV curve conditions. May
%      be a scalar or vector, but vectors must be of same length as all
%      other input vectors.
%   nNsVth - the product of three components. 1) The usual diode ideal 
%      factor (n), 2) the number of cells in series (Ns), and 3) the cell 
%      thermal voltage under the desired IV curve conditions (Vth).
%      The thermal voltage of the cell (in volts) may be calculated as 
%      k*Tcell/q, where k is Boltzmann's constant (J/K), Tcell is the
%      temperature of the p-n junction in Kelvin, and q is the elementary 
%      charge of an electron (coulombs). nNsVth may be a scalar or vector, 
%      but vectors must be of same length as all other input vectors.
%   NumPoints - Number of points in the desired IV curve (optional). Must be a finite 
%      scalar value. Non-integer values will be rounded to the next highest
%      integer (ceil). If ceil(NumPoints) is < 2, no IV curves will be produced
%      (i.e. Result.V and Result.I will not be generated). The default
%      value is 0, resulting in no calculation of IV points other than
%      those specified in [3].
%
% Output:
%   Result - A structure with the following fields. All fields have the
%   same number of rows as the largest input vector.
%      Result.Isc - Column vector of short circuit current in amperes.
%      Result.Voc - Column vector of open circuit voltage in volts.
%      Result.Imp - Column vector of current at maximum power point in amperes. 
%      Result.Vmp - Column vector of voltage at maximum power point in volts.
%      Result.Pmp - Column vector of power at maximum power point in watts.
%      Result.Ix - Column vector of current, in amperes, at V = 0.5*Voc.
%      Result.Ixx - Column vector of current, in amperes, at V = 0.5*(Voc+Vmp).
%      Result.V - Array of voltages in volts. Row n corresponds to IV 
%        curve n, with V=0 in the leftmost column and V=Voc in the rightmost
%        column. Thus, Result.Voc(n) = Result.V(n,ceil(NumPoints)). 
%        Voltage points are equally spaced (in voltage) between 0 and Voc.
%      Result.I - Array of currents in amperes. Row n corresponds to IV 
%        curve n, with I=Isc in the leftmost column and I=0 in the 
%        rightmost column. Thus, Result.Isc(n) = Result.I(n,1). 
%
% Notes:
%    1) To plot IV curve r, use: plot(Result.V(r,:), Result.I(r,:)) 
%    2) To plot all IV curves on the same plot: plot(Result.V', Result.I')
%    3) Generating IV curves using NumPoints will slow down function
%       operation.
%    4) The solution employed to solve the implicit diode equation utilizes
%       the Lambert W function to obtain an explicit function of V=f(i) and
%       I=f(V) as shown in [2].
%
% Sources:
%
% [1] S.R. Wenham, M.A. Green, M.E. Watt, "Applied Photovoltaics" 
%     ISBN 0 86758 909 4
%
% [2] A. Jain, A. Kapoor, "Exact analytical solutions of the parameters of 
%     real solar cells using Lambert W-function", Solar Energy Materials 
%     and Solar Cells, 81 (2004) 269-277.
%
% [3] D. King et al, "Sandia Photovoltaic Array Performance Model",
%     SAND2004-3535, Sandia National Laboratories, Albuquerque, NM
%
% See also
%   PVL_SAPM   PVL_CALCPARAMS_DESOTO
%



% Vth is the thermal voltage of the cell in VOLTS
% n is the usual diode ideality factor, assumed to be linear
% nVth is n*Vth

p = inputParser;
p.addRequired('IL',@(x) all(x>=0) & isnumeric(x) & isvector(x) );
p.addRequired('I0', @(x) all(x>=0) & isnumeric(x) & isvector(x));
p.addRequired('Rs', @(x) all(x>=0) & isnumeric(x) & isvector(x));
p.addRequired('Rsh', @(x) all(x>=0) & isnumeric(x) & isvector(x));
p.addRequired('nNsVth',@(x) all(x>=0) & isnumeric(x) & isvector(x) );
p.addOptional('NumPoints', 0, @(x) isfinite(x) & isscalar(x));
p.parse(IL, I0, Rs, Rsh, nNsVth, varargin{:});

% Make all inputs into column vectors
IL=p.Results.IL(:);
I0=p.Results.I0(:);
Rs = p.Results.Rs(:);
Rsh = p.Results.Rsh(:);
nNsVth = p.Results.nNsVth(:);
NumPoints = p.Results.NumPoints(:);

% Ensure that all input values are either 1) scalars or 2) vectors of equal
% length. The "vector" part of the check is performed by the input parser,
% this merely checks that they are of equal length.
VectorSizes = [numel(IL), numel(I0), numel(Rs), numel(Rsh), numel(nNsVth)];
MaxVectorSize = max(VectorSizes);
if not(all((VectorSizes==MaxVectorSize) | (VectorSizes==1)))
    error('Input vectors IL, I0, Rs, Rsh, and nNsVth must either be scalars or vectors of the same length.');
end

% If any input variable is not a scalar, then make any scalar input values
% into a column vector of the correct size.
if (MaxVectorSize > 1 && any(VectorSizes == 1))
    IL = IL.*ones(MaxVectorSize , 1);
    I0 = I0.*ones(MaxVectorSize , 1);
    Rs = Rs.*ones(MaxVectorSize , 1);
    Rsh = Rsh.*ones(MaxVectorSize , 1);
    nNsVth = nNsVth.*ones(MaxVectorSize , 1);
end

% Take care of any pesky non-integers by rounding up
NumPoints = ceil(NumPoints);


% Set the tolerance of the fminbnd function to be 1e-8 instead of the
% default 1e-4
defaultoptions = optimset('fminbnd');
options = optimset(defaultoptions, 'TolX', 1e-8);


% Find Isc using Lambert W
Isc = I_from_V(Rsh, Rs, nNsVth, 0, I0, IL);

% Find Voc using Lambert W
Voc=V_from_I(Rsh, Rs, nNsVth, 0, I0, IL);

% Invert the Power-Current curve. Find the current where the inverted power
% is minimized. This is Imax.
[Imax negPmp ~] = pvl_fminbnd_vec(@(x) V_from_I(Rsh, Rs, nNsVth, x, I0, IL).*x.*-1, 0, Isc, options);
Vmax = -1*negPmp./Imax;

% Find Ix and Ixx using Lambert W
Ix = I_from_V(Rsh, Rs, nNsVth, 0.5*Voc, I0, IL);
Ixx = I_from_V(Rsh, Rs, nNsVth, 0.5*(Voc+Vmax), I0, IL);


% If the user says they want a curve of with number of points equal to
% NumPoints (must be >=2), then create a voltage array where voltage is
% zero in the first column, and Voc in the last column. Number of columns
% must equal NumPoints. Each row represents the voltage for one IV curve.
% Then create a current array where current is Isc in the first column, and
% zero in the last column, and each row represents the current in one IV
% curve. Thus the nth (V,I) point of curve m would be found as follows:
% (Result.V(m,n),Result.I(m,n)).
if NumPoints >= 2
   s = ones(1,NumPoints); % shaping vector to shape the column vector parameters into 2-D matrices
   Result.V = (Voc)*(0:1/(NumPoints-1):1);
   Result.I = I_from_V(Rsh*s, Rs*s, nNsVth*s, Result.V, I0*s, IL*s);
end

% Wrap up the results into the Result struct
Result.Voc = Voc;
Result.Vmp = Vmax;
Result.Imp = Imax;
Result.Ix = Ix;
Result.Ixx = Ixx;
Result.Pmp = -negPmp;
Result.Isc = Isc;

end





function [V]=V_from_I(Rsh, Rs, nNsVth, I, Io, Iphi)

% calculates V from I per Eq 3 Jain and Kapoor 2004
% uses Lambert W implemented in wapr_vec.m
% Rsh, nVth, I, Io, Iphi can all be vectors
% Rs can be a vector, but should be a scalar

% Generate the argument of the LambertW function
argW = (Io.*Rsh./nNsVth) .* ...
    exp(Rsh.*(-I+Iphi+Io)./(nNsVth));
inputterm = wapr_vec(argW); % Get the LambertW output
f = isnan(inputterm); % If argW is too big, the LambertW result will be NaN and we have to go to logspace

% If it is necessary to go to logspace
if any(f)
    % Calculate the log(argW) if argW is really big
    logargW = log(Io) + log(Rsh) + Rsh.*(Iphi+Io-I)./(nNsVth)...
        - (log(nNsVth));
    
    % Three iterations of Newton-Raphson method to solve w+log(w)=logargW.
    % The initial guess is w=logargW. Where direct evaluation (above) results
    % in NaN from overflow, 3 iterations of Newton's method gives 
    % approximately 8 digits of precision.
    w = logargW;  
    for i=1:3
        w = w.*((1-log(w)+logargW)./(1+w));
    end;
    inputterm(f) = w(f);
end

% Eqn. 3 in Jain and Kapoor, 2004
V = -I.*(Rs + Rsh) + Iphi .* Rsh - nNsVth .* ...
    inputterm + Io .* Rsh;

end

function [I]=I_from_V(Rsh, Rs, nNsVth, V, Io, Iphi)

% calculates I from V per Eq 2 Jain and Kapoor 2004
% uses Lambert W implemented in wapr_vec.m
% Rsh, nVth, V, Io, Iphi can all be vectors
% Rs can be a vector, but should be a scalar

argW = Rs.*Io.*Rsh.*...
    exp(Rsh.*(Rs.*(Iphi+Io)+V)./(nNsVth.*(Rs+Rsh)))./...
    (nNsVth.*(Rs + Rsh));
inputterm = wapr_vec(argW);

% Eqn. 4 in Jain and Kapoor, 2004
I = -V./(Rs + Rsh) - (nNsVth./Rs) .* inputterm + ...
    Rsh.*(Iphi + Io)./(Rs + Rsh);
end