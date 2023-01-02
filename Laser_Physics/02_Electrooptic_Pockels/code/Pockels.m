clear; clc;close all

%% theta - dV
file1 = 'data1.txt'; 
[A,delimeterout] = importdata(file1); 

theta = A.data(1:end, 1) ; 
Vmin  = A.data(1:end, 2) ; 
Vmax  = A.data(1:end, 3) ; 

diff  = Vmax - Vmin ; 
%     = plot(theta, diff, 'o');
createFit(theta, diff)

%% V - dV 
clear ; clc 
file2 = 'data2.txt' ; 
[A, delimeterout] = importdata(file2); 

vin  = A.data(1:end, 1) ; 
vmin = A.data(1:end, 2) ; 
vmax = A.data(1:end, 3) ; 
figure(2)
diff = vmax - vmin ; 
plot(vin, diff,'d','Linewidth', 3.0)
hold on 
grid on 
xlabel('V_{in}(kV)','interpreter','tex') 
ylabel('\Delta V (V)','interpreter','tex')
legend('Exper. Points')
