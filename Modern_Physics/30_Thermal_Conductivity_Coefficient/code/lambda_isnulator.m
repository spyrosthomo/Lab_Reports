clear;clc;
%close all
format compact 
data1= [0,64.0,3.759;
30,59.4,3.645;
60,55.3,3.532;
90,51.7,3.421;
120,48.5,3.311;
150,45.7,3.203;
180,43.2,3.096;
210,41.0,2.991;
240,39.0,2.885;
270,37.2,2.779;
300,35.5,2.667;
330,34.2,2.573;
360,32.9,2.468];

t   = data1(:,1) ;
T   = data1(:,2) ; 
ln  = data1(:,3) ; 

[A,B,dA,dB] = LEAST_SQUARES(t, ln) ; 
tt   = min(t):0.1:max(t) ; 
%% PLOT
h1 = plot(tt, A*tt + B,'black--', 'LineWidth', 1.5, 'DisplayName','fitted curve') ;
hold on 
grid on 
h2 = plot(t, ln, 'o', 'LineWidth',2.0, 'DisplayName','Exper. Data') ; 


legend([h1,h2]) 
xlabel('t(\pm1sec)') 
ylabel('ln(T_i-T_\pi)')

%% UP 
% line([0, 360], [3.77, 2.48],'LineStyle','-')
% line([0, 360], [3.73, 2.44],'LineStyle','-')

%% CROSS
line([0, 360], [3.79, 2.42],'LineStyle','-')
line([0, 360], [3.71, 2.50],'LineStyle','-')

