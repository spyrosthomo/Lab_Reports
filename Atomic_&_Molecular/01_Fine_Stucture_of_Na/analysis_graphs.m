 clear; clc ; close all; format compact 

n       = 290.1  
a       =  60.2
delta_a = 0.2
beta_1  = [ 305.9 299.3 301.4 ]%301.2 301.6] % red green yellow yellow_left yellow_right
beta_2  = [beta_1 - n  11.26 11.34]

m       = 1 % order of diffraction 
N       = 1800*10^3 % sxismes per mm^{-1} 
d       = 1/N 

lambda  = d * (sin(a*pi/180) + sin(beta_2*pi/180)) / m 
delta_lambda = d*delta_a*sqrt(cos(a*pi/180).^2 + cos(beta_2*pi/180).^2)*pi/180


%% Energy difference 
h  = 4.1357 * 10^(-15);% eV s  
c  = 299792458; 
hc = 124000 ; % eV nm
DE = (h*c) * ( 1/lambda(4) - 1/lambda(end) )
delta_DE = h * c * delta_lambda(end) * sqrt(1/lambda(4)^4 + 1/lambda(end)^4)

lef = sind(60.2)/(1*lambda(4))

%% theoretical 
me = 9.109 * 10^(-31) % electron mass 
Z  = 1 
a  = 1 / 137 
n  = 2 
j  = 0.5 

DE_fine = -0.5*me*c^2*(Z*a)^4 * n^(-4)*( 1/(j+0.5)  -  3/(4*n) )  % joule 

DE_fine_eV = DE_fine * 6.24 * 10^(18)

%% final cou
clc; 
min = lambda(2) 
max = lambda(1) 

n    = 2
sinb = 1
sina = 1%sind(60.2)

left  = ( sina + sinb)/(n*max) 
right = ( sina + sinb)/(n*min)