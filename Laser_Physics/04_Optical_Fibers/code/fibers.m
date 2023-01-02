clear;clc; format compact

%% 4.1 Coupling
% back   -   laser+back    -   fiber+back   (VOLTS) 
v  = [0.345 0.824 0.650] 
% v + laser + fiber 
vv = [v v(2)-v(1) v(3)-v(1)] 
% Metatroph se POWER 
p   = -1.898 + 18.48*vv

%% 4.2 Numerical Aperture 
x         = 0:4; 
D         = [1.5 2.1 2.7 3.2 3.6];

X = x; Y = D ; 
[B,A,dB,dA] = LEAST_SQUARES(X,Y); 
fprintf('A=(%f pm %f )\n',A,dA)
fprintf('B=(%f pm %f )\n',B,dB)
figure(1) 
title('D=tan\theta\cdot x') 
xlabel('x(cm)')
ylabel('D(cm)')
p1 = plot(x,D,'o','Linewidth',2.0, 'DisplayName','Exp. Points') ;
hold on 
xx = 0:0.01:4; 
p2 = plot(xx,A*xx+B,'Linewidth',1.5,'DisplayName','Least Sq. Line'); 
legend([p1,p2])
hold off 

theta_rad  = atan(A/2) ;
dtheta_rad = dA*2/(sqrt(4+A^2));
fprintf('theta = ( %f pm %f)[rad]\n',theta_rad,dtheta_rad)
theta      = theta_rad * 180 / pi ;
dtheta     = dtheta_rad * 180 /pi ; 
fprintf('theta = ( %f pm %f)[o]\n',theta,dtheta)

NA = sin(theta_rad)* 1; 
dNA= cos(theta_rad)* dtheta_rad; 
fprintf('NA = ( %f pm %f)\n',NA,dNA)

%% 4.4 Ejasthenish logw syzeykhs 
% ypov1 -- ypov1+1h -- 1h // ypov2 -- ypov2 + 2h -- 2h
V = [ 0.442 0.630 0.188 0.448 0.596 0.148 ];
P = -1.898+18.48*V 


%% 4.5 ??????????? ??????????? '
V1  = [708 683 645 611 574 514 479 412] ; 
Vin = 708 ; Vback = 412 ; 
V2  = V1 - Vback 

% P   = -1.898 + 18.48*V2/1000
% 
% Pin = 6.954

IL  = 10 * log10(V2/Vin) 
num = 0:7

fitt(num,IL)