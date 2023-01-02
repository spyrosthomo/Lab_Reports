clear;clc;close all ; format compact 

data = [0.5,27.1;
2.0,38.0;
3.5,47.8;
5.0,61.3;
6.5,73.3 ] ; 

x = data(:,1) ;
T = data(:,2) ; 

%% plot 
[B, A,dB,  dA] = LEAST_SQUARES(x, T) ; 
t = min(x):0.001:max(x) ; 
h1 = plot(t, B*t+A,'black--','LineWidth',1.5, 'DisplayName','Fitted Curve') 
hold on 
grid on 
h2 = plot(x, T, 'redo','LineWidth',2.0,'DisplayName','Exper. Data')

legend([h1,h2])
xlabel('')
ylabel('')