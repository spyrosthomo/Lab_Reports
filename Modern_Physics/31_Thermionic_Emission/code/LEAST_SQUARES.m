%clear                                                                     %Y=Bx+A
%clc
function [B, dB, A, dA ] = LEAST_SQUARES(x,y)
% phi=[1.0472 2.1642 3.2289 4.2586 5.4280]             %%edw to x 
% F=[ 0.000196 0.000392 0.000588 0.000784 0.000980]           %% edw to y 
phi = x;
F   = y;
sx=sum(phi);
sy=sum(F);
sxy=sum(phi.*F);
sx2=sum(phi.^2);
Nx=length(phi);
A=(sy*sx2-sx*sxy)/(Nx*sx2-sx^2)
B=(Nx*sxy-sx*sy)/(Nx*sx2-sx^2)
disp('H eutheia einai y=Bx+A')
sigmapsi=sqrt(sum((F-A-B*phi).^2)/(Nx-2));
Aerror=sigmapsi*sqrt(sx2/(Nx*sx2-sx^2))
Berror=sigmapsi*sqrt(Nx/(Nx*sx2-sx^2))
dB = Berror; 
dA = Aerror;
end