%PVL_FMINBND_VEC Single-variable bounded nonlinear function minimization.
%   X = PVL_FMINBND_VEC(FUN,x1,x2) attempts to find  a local minimizer X of the function 
%   FUN in the interval x1 < X < x2.  FUN is a function handle.  FUN accepts 
%   vector input X and returns a vector function value F evaluated at X. x1
%   and x2 may be vector inputs with x1(i) corresponding to x2(i)
%
%   X = PVL_FMINBND_VEC(FUN,x1,x2,OPTIONS) minimizes with the default optimization
%   parameters replaced by values in the structure OPTIONS, created with
%   the OPTIMSET function. See OPTIMSET for details. FMINBND uses these
%   options: Display, TolX, MaxFunEval, MaxIter, FunValCheck, PlotFcns, 
%   and OutputFcn. TolX may be a vector of the same size as all other input
%   vectors to accomodate different tolerances for each input.
%
%   X = PVL_FMINBND_VEC(PROBLEM) finds the minimum for PROBLEM. PROBLEM is a
%   structure with the function FUN in PROBLEM.objective, the interval
%   in PROBLEM.x1 and PROBLEM.x2, the options structure in PROBLEM.options.
%   The structure PROBLEM must have all the fields.
%
%   [X,FVAL] = PVL_FMINBND_VEC(...) also returns the value of the objective function,
%   FVAL, computed in FUN, at X.
%
%   [X,FVAL,EXITFLAG] = PVL_FMINBND_VEC(...) also returns an EXITFLAG that describes 
%   the exit condition of PVL_FMINBND_VEC. Possible values of EXITFLAG and the 
%   corresponding exit conditions are
%
%    1  PVL_FMINBND_VEC converged with a solution X based on OPTIONS.TolX for all inputs.
%    0  Maximum number of function evaluations or iterations reached for at least one input.
%   -1  Algorithm terminated by the output function.
%   -2  At least one set of bounds are inconsistent (that is, ax(i) > bx(i)).
%
%   [X,FVAL,EXITFLAG,OUTPUT] = PVL_FMINBND_VEC(...) also returns a structure
%   OUTPUT with the number of iterations taken for each index in OUTPUT.iterations, the
%   number of function evaluations in OUTPUT.funcCount, the algorithm name 
%   in OUTPUT.algorithm, and the exit message in OUTPUT.message.
%
%   Examples
%     FUN can be specified using @:
%        X = pvl_fminbnd_vec(@cos,[3 ; 6], [4 ; 10])
%      computes pi and 3*pi to a few decimal places and gives a message upon termination.
%        [X,FVAL,EXITFLAG] = pvl_fminbnd_vec(@cos,[3;8],[4;10],optimset('TolX',1e-12,'Display','off'))
%      computes pi and 3*pi to about 12 decimal places, suppresses output, returns the
%      function values at x, and returns an EXITFLAG of 1.
%
%     FUN can be an anonymous function:
%        X = pvl_fminbnd_vec(@(x) sin(x)+3,[2;10],[5;13])
%
%     FUN can be a parameterized function.  Use an anonymous function to
%     capture the problem-dependent parameters:
%        f = @(x,c) (x-c).^2;  % The parameterized function.
%        c = 1.5;              % The parameter.
%        X = pvl_fminbnd_vec(@(x) f(x,c),[0;2],[1;5])
%
%   See also OPTIMSET, FMINSEARCH, FZERO, FUNCTION_HANDLE.
%
%   References:
%   "Algorithms for Minimization Without Derivatives",
%   R. P. Brent, Prentice-Hall, 1973, Dover, 2002.
%
%   "Computer Methods for Mathematical Computations",
%   Forsythe, Malcolm, and Moler, Prentice-Hall, 1976.
%
%   Original coding by Duane Hanselman, University of Maine.
%   Copyright 1984-2010 The MathWorks, Inc.
%   $Revision: 1.18.4.18 $  $Date: 2010/11/22 02:46:04 $
%
%   Modifications to original code by Daniel Riley, Sandia National
%   Laboratories, to allow for X, x1, x2, and TolX to be vectors.
%   $Date: 2012/09/07 $
%
%   Code is protected and encrypted as a ".p" file prior to distribution in
%   order to comply with Mathworks' License Agreement, in particular the
%   Deployment Addendum. Similar functionality to PVL_FMINBND_VEC can be
%   obtained by using the MATLAB function fminbnd within a loop (although
%   much slower). The source "pvl_fminbnd_vec.m" file is held by Sandia's
%   Photovoltaics and Grid Integration Organization and may only be
%   distributed within Sandia National Laboratories.