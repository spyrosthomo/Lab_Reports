data = [ 0,0.00,0.00,0.00;
10,0.07,0.05,0.04;
20,0.19,0.15,0.11;
30,0.32,0.25,0.15;
40,0.45,0.32,0.17;
50,0.55,0.36,0.18;
60,0.65,0.39,0.19;
70,0.73,0.40,0.19;
80,0.79,0.41,0.20;
90,0.83,0.42,0.20;
100,0.85,0.42,0.20;
110,0.86,0.43,0.20;
120,0.88,0.44,0.21;
130,0.89,0.44,0.21;
140,0.90,0.45,0.21;
150,0.91,0.45,0.21;
160,0.91,0.45,0.22;
170,0.92,0.46,0.22;
180,0.93,0.46,0.22;
190,0.93,0.47,0.22;
200,0.94,0.47,0.22;
210,0.95,0.47,0.22;
220,0.95,0.47,0.23;
230,0.96,0.48,0.23;
240,0.96,0.48,0.23;
250,0.97,0.48,0.23;
260,0.97,0.48,0.23;
270,0.97,0.49,0.23;
280,0.98,0.49,0.23;
290,0.98,0.49,0.23;
300,0,0.49,0.24   ]; 

v  = data(:,1) ;
v1 = v(1:end-1);
i1 = data(1:end-1,2) ; % for 2100K 
i2 = data(:,3) ;       % for 2050K 
i3 = data(:,4) ;       % for 2000K 

% number of measurements  for each temperature 
m  = length(v) ; 

%%  plot data 

figure(1) 
plot(v1,i1,'-*')
hold on
plot(v ,i2,'-s')
hold on
plot(v ,i3,'-h')

%% Fit data
figure(2)
createFit(v1,i1,'I_{A1} Vs. V_A Fitted Curve','black--','o'); 
hold on 
createFit(v,i2,'I_{A2} Vs. V_A Fitted Curve','red--','s');
hold on 
createFit(v,i3,'I_{A3} Vs. V_A Fitted Curve','b--','*');

% LEGEND
%legend('I_{A1} Vs. V_A Fitted Curve', 'I_{A1} Data', 'Location', 'NorthEast', 'Interpreter', 'tex' );
legend('I_{A1} Data','I_{A1} Vs. V_A Fit','I_{A2} Data','I_{A2} Vs. V_A Fit','I_{A3} Data','I_{A3} Vs. V_A Fit') 

