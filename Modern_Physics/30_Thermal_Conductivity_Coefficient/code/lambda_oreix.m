clear;clc;format compact ; close all 

data = [ 3.0,28.8,20.1;
6.0,41.1,22.4;
9.0,51.4,23.4;
12.0,64.8,25.5;
15.0,73.0,27.1 ];

P   = data(:,1) ; 
T5  = data(:,2) ; 
T1  = data(:,3) ; 

L15 = 0.06;  

thermo    = (T5-T1)/L15 ;
data(:,4) = thermo; 

%% plot
[x, y] = prepareCurveData(P, thermo) ; 
ft     = fittype('poly1')            ; 

[fitres, gof]  = fit(x,y,ft); 

figure(1) 
h1 = plot(fitres,'black-'); 
hold on 
h2 = plot(P, thermo, 'o', 'LineWidth', 1.5, 'DisplayName','Exper. Data'); 

legend([h2,h1]) 
ylabel('(T_5-T_1)/L_{1-5} (^oC/m)','interpreter','tex')
xlabel('P(W)','interpreter','tex') 
grid on 

%line([min(P), max(P)], [185, 755],'LineStyle','--')
%line([min(P), max(P)], [105, 845])
line([3,15],[140,750],'LineStyle','--')
line([3,15],[160,845])
%% 
% [B,dB ]= LEAST_SQUARES_APO_ARXI_AXES(P, thermo) ; 
% tt = min(P):0.01:max(P); 
% plot(tt, B*tt) 