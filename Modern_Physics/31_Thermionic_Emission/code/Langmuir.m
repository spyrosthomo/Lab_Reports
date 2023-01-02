clear;
data = [ 6,0.03,3.125,1.1394,-3.5066;
8,0.05,5.125,1.6341,-2.9957;
10,0.07,7.125,1.9636,-2.6593;
12,0.09,9.125,2.211,-2.4079;
14,0.11,11.125,2.4092,-2.2073;
16,0.13,13.125,2.5745,-2.0402;
18,0.16,15.125,2.7163,-1.8326;
20,0.18,17.125,2.8405,-1.7148
]; 

Va   = data(:,1) ; 
Ia   = data(:,2)*10^(3) ; % in Amperes 
Vf   = data(:,3) ;
lnVf = data(:,4) ; 
lnIa = data(:,5)+3*log(10) ; 


%plot(lnIa, lnVf,'-o')

%% Least Squares
[B, dB, A, dA ] = LEAST_SQUARES(lnVf, lnIa)
t = min(lnVf):0.01:max(lnVf); 
plot(lnVf,lnIa,'o','LineWidth',1.5) 
hold on 
grid on 
plot(t, B*t+A,'black--','LineWidth',1.5)

legend('Experimental Data','Least Squares Curve') 
xlabel('X=ln(V_A)')%,'FontSize',10) 
ylabel('Y=ln(I_A)')%,10)

disp('-------------------------------------------------------')