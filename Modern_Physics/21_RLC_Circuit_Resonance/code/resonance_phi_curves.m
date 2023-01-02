format compact 
clc 
V0 = 5
C  = 10^(-8)
L  = 10^(-6)
z  = @(R,x) sqrt(R^2+(L*x-1./(C*x)).^2)
%I  = V0./z     

R    = [ 3 7 18 ]; 
type = ["-"   "--"   ":"];
figure(1)
f=0:10:4.5*10^(7);
for i =1:length(R) 
   Z = z(R(i),f) ; 
   plot(f,V0./Z,type(i),'LineWidth',1.5) 
   hold on 
end
legend('R_1','R_2>R_1','R_3>R_2')
grid on 
xlabel('f/f_0')
ylabel('I_0 (A)')
hold off 


figure(2) 
for i = 1:length(R) 
    phi = atan((1./(C*f)-f*L)/R(i));
    plot(f,phi*180/pi,type(i),'LineWidth',1.5) 
    hold on 
end
legend('R_1','R_2>R_1','R_3>R_2')
grid on 
xlabel('f/f_0')
ylabel('\phi')