%% Stabilize with telestikos enisxyths tis taseiw v1 v2 
clear ; clc 
% open 
file = 'data1.txt';
[A, delimiterOut] = importdata(file); 
v1 = A(:,1) ; 
v2 = A(:,2) ; 

figure(1) 
h1 = plot(v1,v2,'o','LineWidth',1.5, 'DisplayName','exp. points');
[B, dB] = LEAST_SQUARES_APO_ARXI_AXES(v1,v2); 
t=min(v1):0.01:max(v1); 
hold on 
h2 = plot(v1, v1*B, 'LineWidth',1.5, 'DisplayName','Line'); 
legend([h1,h2])
xlabel('V_1(V)')
ylabel('V_2(V)') 

hold off

%% stable current 
clear;clc;close all 
%open 
file = 'data2.txt'; 
[A, delimiterOut] = importdata(file); 
v = A(:,1); 
i1= A(:,2); 
i2= A(:,3); 
i3= A(:,4); 

figure(2) 
h1 = plot(v,i1,'-o','LineWidth',1.5,'DisplayName','I_1=40mA');
hold on 
h2 = plot(v,i2,'--o','LineWidth',1.5,'DisplayName','I_1=45mA');
h3 = plot(v,i3,'-*','LineWidth',1.5,'DisplayName','I_1=50mA');

ylabel('I_i(mA)') 
xlabel('V(v)')
legend([h1,h2,h3])
hold off

%% PaRT 3 
clear;clc;close all 
% open 
file = 'data3.txt'; 
[A, delimiterOut] =importdata(file); 
eb = A(:,1);
v2 = A(:,2); 
v3 = A(:,3); 

t  = min(eb):0.01:max(eb) ; 

figure(3) 
h1 = plot(eb, v2,'o','LineWidth', 1.5, 'DisplayName', 'exp. V_2');
hold on 
[a,da,b,db] = LEAST_SQUARES(eb(1:end-1),v2(1:end-1)) ; 
h1a = plot(eb, eb*a+b,'-', 'LineWidth', 1.5, 'DisplayName','Line V_2') ;

h2 = plot(eb, v3,'s','LineWidth', 2.5, 'DisplayName', 'exp. V_3');
[a,da,b,db] = LEAST_SQUARES(eb,v3) ; 
h2a = plot(eb, eb*a+b,'--', 'LineWidth', 1.5, 'DisplayName','Line V_3') ;

xlabel('E_B(V)') 
ylabel('V_2, V_3 (V)')

legend([h1,h1a,h2,h2a])
hold off

%%PART 4 thershld
clear;clc;close all 
file = 'data4_thersh.txt'; 
[A,delimiterOut] = importdata(file); 

v1 = A(:,1); 
v  = A(:,2); 

p  = -4.8979 + 18.4843*v1;

figure(4) 
plot(v, p, 's','LineWidth',2.5) 

xlabel('V_1(mV)') 
ylabel('P(mW)')
hold on 
legend('exp. points')

writematrix([A round(p,1)],'data4_final.txt', 'Delimiter',',');

%% Part 5 - laser profile
%clear;clc;%close all
file = 'data5.txt'; 
[A, delimiterOut] =importdata(file); 

bx  = A(1:7,1) ;
v2x = A(1:7,2) ;
by  = A(:,3)   ; 
v2y = A(:,4)   ;

bya = by(1:22)   ;  v2ya = v2y(1:22); 
byb = by(22:end) ;  v2yb = v2y(22:end);
figure('Name','4')
h1  = plot(bx,v2x,'o','LineWidth',1.5,'DisplayName','exp. points x-axis');
hold on 
%FIITT  1111
    [xData, yData] = prepareCurveData(bx, v2x); 
    ft = fittype('poly2'); 
    [fitresult, gof] = fit(xData,yData, ft); 
    
    h1a = plot(fitresult);
    


h2 = plot(by,v2y,'o','LineWidth',1.5,'DisplayName','exp. points y-axis');
% FITTT 2222
    line([bya(1),bya(end)],[v2ya(1),v2ya(end)])
    [xData, yData] = prepareCurveData(byb, v2yb); 
    ft = fittype('poly2'); 
    [fitresult, gof] = fit(xData,yData, ft); 
    
   h2a = plot(fitresult);
    
xlabel('? x/ ? y')
ylabel('V_2(V)') 

legend('exp. points x-axis','fit x-axis','exp. points y-axis','fit y-axis')
