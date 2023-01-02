clear ; clc 
data = [1700,0.001,0.000588,3.46021e-07,-14.8768;
1750,0.003,0.000571,9.79592e-07,-13.8361;
1800,0.01,0.000556,3.08642e-06,-12.6885;
1850,0.02,0.000541,5.843682e-06,-12.0501;
1900,0.05,0.000526,1.3850416e-05,-11.1872;
1950,0.11,0.000513,2.8928337e-05,-10.4507;
2000,0.23,0.0005,5.75e-05,-9.7637;
2050,0.49,0.000488,0.000116597264,-9.0568;
2100,0.98,0.000476,0.000222222222,-8.4118
];

T      = data(:,1) ; 
ia     = data(:,2) ;
tinv   = data(:,3) ; 
iatinv = data(:,4) ;
ln     = data(:,5) ; 

m = length(T) ; 

%% Least Squares 
x = tinv ; 
y = ln   ;
[B, dB, A, dA ] = LEAST_SQUARES(x,y) 

tt = linspace(min(x),max(x), 10^5) ; 

%Data Points 
plot(x,y,'o','LineWidth',2.0)
hold on 
grid on
% LS Line
plot(tt, B*tt+A,'black--','LineWidth',2.0) 
xlabel('X=1/T')
ylabel('Y=ln(I_A/T^2)') 
legend('Exper. Data','Y Vs. X Least Squares Line') 



