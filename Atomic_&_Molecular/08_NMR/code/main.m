clear;clc;close all; format compact

%%OPen file 
file              = 'data.txt';
[A, delimiterOut] = importdata(file);

I  = A(:,1);
B  = A(:,2);
f  = A(:,3);

BB = [ B(1:2)' B(4:end)']';
ff = [ A(1:2,3)' A(4:end,3)']';
[A,dA] = LEAST_SQUARES_APO_ARXI_AXES(BB,ff); 

figure(1) 
h1 = plot(B,f,'o', 'LineWidth',2.5,'DisplayName','Exp. Data');
hold on 
t  = min(B):0.01:max(B); 
h2 = plot(t, A*t, 'LineWidth',1.5,'DisplayName','Least Squares');
ylabel('f(MHz)')
xlabel('B(mT)')
legend([h1,h2])

A
%% g factor 
b = 5.051*10^(-27) ;
A = A*10^(9) ; 
h = 6.626*10^(-34)


g = A*h/b