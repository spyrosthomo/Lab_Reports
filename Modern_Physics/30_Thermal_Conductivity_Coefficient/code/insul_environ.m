clear;clc;close all ; format compact 

data = [0,75.1;
30,74.1;
60,73.1;
90,72.2;
120,71.3;
150,70.3;
180,69.7;
210,68.5;
240,67.7;
270,66.8;
300,65.9;
];
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


t1  = data(:,1)  ; 
T1  = data(:,2)  ;  
t2  = data1(:,1) ;
T2  = data1(:,2) ; 
ln  = data1(:,3) ; 

tt1 = min(t1):0.01:max(t1); 
tt2 = min(t2):0.01:max(t2);
%% plot
figure(1) 
h1 = plot(t1, T1, 'o', 'DisplayName', 'Data Q to Environment', 'LineWidth',1.5) 
hold on
h2 = plot(t2, T2, '*', 'DisplayName', 'Data Q to insulator', 'LineWidth',1.5)
[B,A,dB,dA] = LEAST_SQUARES(t1,T1);
h3 = plot(tt1, B*tt1 + A , 'LineWidth',1.5, 'DisplayName','Fit Q to Environment') 

%% FIT TO INSULATOR
[t2, T2 ] = prepareCurveData(t2, T2) ; 
ft        = fittype('poly3') ; 

[fitres, gof] = fit(t2, T2, ft); 
h4 = plot(fitres,'black--');
grid on 

legend([h1,h2,h3,h4])
xlabel('t(\pm1sec)') 
ylabel('T(\pm0.5^oC)')