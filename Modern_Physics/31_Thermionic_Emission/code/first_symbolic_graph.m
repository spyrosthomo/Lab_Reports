clear; clc 

i0  = 0.3;
va1 = -2:0.01:0; 
va2 = 0:0.01:2; 
va3 = 1.9:0.01:6;
kT  = 0.5 ; 
T = 0.2;

a   = 3  ;
b   = 1  ;
c   = 0.3;
phi = 0.18 ;

i1 = i0 * exp(va1/kT);
i2 = i0 + b  * va2.^(3/2)   ;
i3 = a+ c * T^2 * exp(phi*va3/kT) ; 

plot(va1, i1,'black','LineWidth',1.5)
hold on 
plot(va2, i2,'b','LineWidth',1.5)
hold on 
plot(va3,i3,'r','LineWidth',1.5)
hold on 
% plot(plot:Arrow2d([0,0],[0,6]))
grid 
xlabel('V_A','FontSize',12) 
ylabel('I_A(V_A)','FontSize',12)

line([0,8],[3,3])