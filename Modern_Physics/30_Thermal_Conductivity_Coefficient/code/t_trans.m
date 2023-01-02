clear; clc; format compact ;close all
data = [ 0,19.0;
30,21.4;
60,23.7;
90,25.4;
120,26.5;
150,27.3;
180,27.9;
210,28.3;
240,28.6;
270,28.7;
300,28.8;
];

t = data(:,1); 
T = data(:,2); 

%% PLOT 
[x ,y ] = prepareCurveData(t, T) ; 
ft      = fittype('poly3'); 

[fitres , gof ] = fit(x, y, ft) ; 
figure(1) 
h1      = plot(fitres,'black-');%, '-', 'LineWidth','1.5','DisplayName','Fit') ;
hold on
h2      = plot(x, y, 'o','LineWidth',1.5,'DisplayName','Exper. Data'); 

legend([h2,h1]) 
xlabel('t(s)') 
ylabel('T(^oC)')
grid on


