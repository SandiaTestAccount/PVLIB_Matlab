% Real values of the Lambert W function
%
%-----------------------------------------------------------------------
% Modified 8/22/2012 by C. W. Hansen (Sandia National Laboratories
% From wapr.m originally written by D. A. Barry, 23 June 2003 (d.a.barry@ed.ac.uk)
% 
% Syntax:
% [w] = wapr(x);
%
% The W function has two real branches, Wp, the upper branch, and
% Wm, the lower branch.  This code calculates only values for the upper
% branch and only for x>=0.
%
%
% w is the value (scalar or vector) of W calculated
%
%
% x - argument (assumed real) of W(x); vector or scalar.
% For a vector of arguments, wapr_vecreturns a vector w of results.
% Note that for a vector of arguments, each argument is assumed to
% refer to the same branch of the W function.
%
% Note: wapr_vecwill terminate if any element of input x is not within range. 
%
%
% Users of wapr_vecwill usually want to calculate W(x) for specified
% values of x.  This version wapr_vec.m of the original wapr.m code does not
% calculate values for x<0, so it does not include much of the original
% code designed to handle x near x = -exp(-1).
%
% Note: Matlab installations with the Symbolic Math Toolbox have direct
% access to Maple's LambertW function (lambertw).
%
function [w] = wapr_vec(x,varargin)
%
% Approximating the W function
% ____________________________
%
% wapr.m is the Matlab version of Algorithm 743 (written in
% FORTRAN), Collected Algorithms from ACM.
% Web reference: http://www.netlib.org/toms/743
%
% wapr.m written by D. A. Barry, 23 June 2003 (d.a.barry@ed.ac.uk)
%
% wapr_vec.m modifies wapr.m to improve performance (using vector
% operations rather than a loop) but also restricts inputs to positive
% real numbers.
%
% wapr_vec.m by C. W. Hansen, 27 Sept. 2012 (cwhanse@sandia.gov)
%
% Archival journal references:
%
% Barry, D. A., P. J. Culligan-Hensley, and S. J. Barry. 1995.
% Real values of the W-function. Association of Computing
% Machinery Transactions on Mathematical Software. 21(2): 161-171.
%
% Barry, D. A., S. J. Barry, and P. J. Culligan-Hensley. 1995.
% Algorithm 743: WAPR: A FORTRAN routine for calculating real
% values of the W-function. Association of Computing Machinery
% Transactions on Mathematical Software. 21(2): 172-181.
% __________________________________________________________________
%
%
%
% Only consider real non-negative arguments
%
if any(any(imag(x) ~= 0)) || any(any(x<0))
   fprintf(1,'\r%s\r','Complex and non-negative arguments not supported');
   return      
end

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
% nbits is the number of bits (less 1) in the mantissa of the
% floating point number number representation of your machine.
% It is used to determine the level of accuracy to which the W
% function should be calculated.
%
% Most machines use a 24-bit matissa for single precision and
% 53-56 bits for double precision. The IEEE standard is 53
% bits. The Fujitsu VP2200 uses 56 bits. Long word length
% machines vary, e.g., the Cray X/MP has a 48-bit mantissa for
% single precision.
%
% Matlab uses the IEEE standard mantissa of 53 bits, thus nbits
% is set to 52. Uses can check this result by running the following
% section of code, although this is only necessary if Matlab departs
% from the IEEE standard.
%v=10;
%i=0;
%while v > 1
%   i=i+1;
%   b=2^(-i);
%   v=1+b;
%end
%nbits=i-1;
%j=-log10(b);
%if m == 1
%   fprintf(1,'\r%s%3.0f%s\r%s%3.0f%s\r',' nbits is',nbits,'.',' Expect',j,' significant digits from wapr.')
%end
%
nbits=52;
%
% nbits should not need to change while Matlab uses
% the IEEE standard described above.
%
% Various constants
%
em=-exp(-1);
em9=-exp(-9);
c13=1/3;
c23=2*c13;
em2=2/em;
e12=-em2;
tb=.5^nbits;
tb2=sqrt(tb);
x0=tb^(1/6)/2;
x1=(1-17*tb^(2/7))*em;
an3=8/3;
an4=135/83;
an5=166/39;
an6=3167/3549;
s2=sqrt(2);
s21=2*s2-3;
s22=4-3*s2;
s23=s2-2;
%
% Calculate W for each element in the argument vector x
%

% initialize flags and output

w=NaN(size(x));
itflag=0*x;

% calculate W using different methods for different ranges of the argument x

u1 = abs(x)<=x0;
w(u1)=x(u1)./(1+x(u1)./(1+x(u1)./(2+x(u1)./(0.6+0.34*x(u1)))));
itflag(u1)=1;

            
u2=~u1 & x<=x1;
delx = x - em;
reta=sqrt(e12*delx);
w(u2)=reta(u2)./(1+reta(u2)./(3+reta(u2)./(reta(u2)./(an4+reta(u2)./(reta(u2)*an6+an5))+an3)))-1;
itflag(u2)=1;


u3=~u2 & x <= 20;
reta=s2*sqrt(1-x/em);
an2=4.612634277343749*sqrt(sqrt(reta+1.09556884765625));
w(u3)=reta(u3)./(1+reta(u3)./(3+(s21*an2(u3)+s22).*reta(u3)./(s23*(an2(u3)+reta(u3)))))-1;


u4=~u3;
zl=log(x);
w(u4)=log(x(u4)./log(x(u4)./zl(u4).^exp(-1.124491989777808 ./(.4225028202459761+zl(u4)))));

u5 = itflag==0;
zn=log(x./w)-w;
temp=1+w;
temp2=temp+c23*zn;
temp2=2.*temp.*temp2;
w(u5)=w(u5).*(1+(zn(u5)./temp(u5)).*(temp2(u5)-zn(u5))./(temp2(u5)-2.*zn(u5)));
%
% End of wapr_vec
% __________________________________________________________________