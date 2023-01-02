clear; clc; format compact 

energy  = [ 122 88.03 26.30 ] %keV --- Co Cd Am
channel = [ 567 421 148 ]

[A, dA, B, dB] = LEAST_SQUARES(channel, energy) ;
A
dA
B
dB
[A, dA] = LEAST_SQUARES_APO_ARXI_AXES(channel, energy) ;
A
dA


chan = 0:1024; 


figure(1) 
h1 = plot(channel, energy,'o','LineWidth',1.5,'DisplayName','Exper.');
hold on
h2 = plot(chan   , A * chan,'-','LineWidth',1.5,'DisplayName','Linear Fit');

legend([h1,h2]) 
xlabel('Channel')
ylabel('Energy(keV)') 


%% CONFIRM MOSELEY 
clear ;clc ; close all 

% Order of elements: 
% Np Ag Ba Pb Cs
% 93 47 56 82 55
%
% C = 0.0102 keV expected theoretical value :'(
%

z = [ 93 47 56 82 55 ] ;
eexp = [ 100.75 18.11 28.08 73.12 26.52 ] ;    % keV
eth  = [ 101.1 22.2 32.2 75.0 31.0 ] ;   % Ka1   keV
%eth  = [97.1 22.0 31.8 72.8 30.6]; % Ka2

x    = (z-1).^2 ; 
yexp = eexp ; 
err  = [3 1 2 2 2 ];
yth  = eth  ;
[Aexp, dAexp,Bexp,dBexp] = LEAST_SQUARES(x,yexp);
[Ath,  dAth ,Bth,dBth] = LEAST_SQUARES(x,yth);

t    = min(x):0.01:max(x); 
fexp = Aexp*t + Bexp      ;
fth  = Ath *t    +Bth        ;

figure(1) 
h1 = errorbar(x,yexp,err,'o', 'LineWidth',1.5,'DisplayName','Experimental'); 
hold on 
h2 = plot(x,yth,'s','LineWidth',1.5,'DisplayName','Expected');
h3 = plot(t,fexp,'LineWidth',1.5,'DisplayName','Exper, fit, C_{exp.} = 0.0130 keV'); 
h4 = plot(t,fth,'--', 'LineWidth',1.5,'DisplayName','Expected fit, C_{expec}=0.0124keV') ;

xlabel('(Z-1)^2') 
ylabel('E(keV)')
legend([h1,h3,h2,h4]) 

Aexp 
Ath