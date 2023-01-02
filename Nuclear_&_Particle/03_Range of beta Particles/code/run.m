clear;clc;format compact
%  + ... 
xal   = [ 0 110 220 330 440 550];%  710 870 1030 1190];
K     = [ 8152 5630 3779 2183 1192 608];% 198 81 65 50]; 
%xal   = [ 0 110 220 330 440 550  710 870 1030 1190];
%K     = [ 8152 5630 3779 2183 1192 608 198 81 65 50]; 
Kback = 112; 
Nback = Kback/6;
%%Exclued
xexcl   = [ 710 870 1030 1190];
Kexcl   = [ 198 81 65 50]; 
Np_excl = Kexcl/3-Nback;
d_Np_excl = sqrt(abs(Np_excl))/3;

N     = K    /3;

%N-Nback 
Np    = N-Nback;
d_Np  = sqrt(abs(Np))/3;

%% Fit ln 
y     = log(abs(Np));
x     = xal         ;
error = d_Np./abs(Np);
yexcl = log(abs(Np_excl)) ;
errorexcl = d_Np_excl./abs(Np_excl);

[xData, yData]   = prepareCurveData( x, y );
ft               = fittype( 'poly1' );
[fitresult, gof] = fit( xData, yData, ft );
fitresult
figure(1) 
t  = xal(1):0.01:xexcl(end);
p1 = fitresult.p1; p2 = fitresult.p2;
h1 = plot(t, p1*t+p2,'Linewidth',1.3); 
xlim([xal(1) xexcl(end)]);
hold on
h4 = errorbar(xexcl, yexcl,errorexcl,'vertical','o','MarkerEdgeColor','r', 'Linewidth',2);
h2 = errorbar(x,y,error,'vertical','o') ;
h3 = yline(log(Nback),'Linewidth',1.3); 
legend([h1,h2,h3,h4], 'Least Squares','Exp. Data','ln(N_{back})','Excluded Points','interpreter','tex') 
xlabel('x_{Al} (mg/cm^2)'     , 'interpreter', 'tex'); 
ylabel('ln(N_\beta - N_{back})', 'interpreter', 'tex'); 
hold off

dp1 = 0.8 *10^(-3); 
dp2 = 0.3       ;
yb    = log(18.7)
Range = (yb - p2)/p1
o1  = (p2-yb)*dp1/p1^2 ; 
o2  = dp2/p1 ;
dyb =0.01
o3  = dyb/p1  ;
dRange = sqrt(o1^2 + o2^2+o3^2) 
dRR    =sqrt( ((8.1-log(18.7))*(0.0008)/(0.0049^2))^2 + ( 0.3/0.0049 )^2 + ( 0.01/0.0049 )^2 )  

%% Emax 
Emax2 = ((Range*10^(-3)/0.11+1)^2-1)/22.4
Emax  = sqrt(Emax2)
dEmax = (Range*(10^(-3))/0.11 +1)/(Emax*0.11*22.4) * dRange*10^(-3)

%% energothta

R0      = 0.1; %?Ci  
t12     = 28.8 
lambda  = log(2)/t12 % yr^(-1) 
tnow    = 19.25;
disp('?Ci') 
R       = R0*exp(-lambda*tnow)
disp('diaspaseis / min') 
Rmin    = R * 0.37*10^5 *60

mCi_sec = 0.37*10^5 % diaspaseiw ana sec 
mCi_min = mCi_sec*60 ;

d       = 5.2 ; 
rho     = 1.4 ;
omega   = 2*pi*(1-d/sqrt(d^2+rho^2))
N_omega = Rmin*omega/ (4*pi)