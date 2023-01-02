clear;clc;format compact ;clear all
 
l2 = 1          ; 
l1 = 0.00000001      ; 
N0 = 1          ;
t  = 0:0.01:10 ; 

%% Energothtes
R0 = l1*l2/(l2-l1) * N0;
R1 = l1*N0*exp(-l1*t)  ; 
R2 = R0*(1-exp(-l2*t)) ;

%% plots
figure() 
h1 = plot(t, R1, '--','LineWidth',2,'Color','red');%, 'R_1(t)') ;
hold on
h2 = plot(t, R2, '-' ,'LineWidth',2,'Color','black');%,title,'R_2(t)');
h3 = plot(t, R1+R2,'LineWidth',2,'Color','green');
h4 = line([1,1],[0,2*10^(-8)]);
xlabel('t') 
ylabel('R_{i}(t)') 
legend([h1,h2,h3,h4],'R_1(t)','R_2(t)','R(t)','Half life of N_2') 
title('R_{i} vS t, for \lambda_1<<\lambda_2')
hold off