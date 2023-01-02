%clc

r0 =0.001;
R  =  0.04;
xi = 1.1283e+05;
%  f      = @(x) xi*log(2*R/x) -2/x;
%  fprime = @(x) 2/x^2 - xi/x;
%  r = r0-f(r0)/fprime(r0) ;

g      = @(x) x*log(2*R/x)-2/xi;
gprime = @(x) log(2*R/x)-1;
r = r0 -g(r0)/gprime(r0);

% h      = @(x) x*log(2*R/x)-1/xi; 
% hprime = @(x) log(2*R/x)-1;
% r      = r0 - h(r0)/hprime(r0);
n=100
for i=1:n
     %r= r - f(r)/fprime(r); 
  r = r - g(r)/gprime(r);
   %r = r - h(r)/hprime(r);
end

r
f(r)