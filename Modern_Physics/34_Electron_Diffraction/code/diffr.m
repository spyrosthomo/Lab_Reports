clear;clc
format long
format compact
data = [1500,4.1,7.0;
2000,3.2,6.3;
2500,2.9,5.2;
3000,2.8,4.9;
3500,2.7,4.7;
3500,2.7,4.7;
3000,2.8,5.0;
2500,3.1,5.4;
2000,3.5,6.1;
1500,3.8,7.0 ];

v  = data(1:5,1);
s1 = data(:,2); 
s2 = data(:,3); 

rv = v.^(1/2) ;   % square root of v 
li = 12.25./(rv); % de Broglie wavelength measured in Armstrongs

A1 = [v(1:5) rv(1:5) li(1:5) s1(1:5) s1(end:-1:6) s2(1:5) s2(end:-1:6) ]

s1_up = s1(1:5)  ; 
s1_dn = s1(end:-1:6);
s2_up = s2(1:5)  ;
s2_dn = s2(end:-1:6);

s1_mean = (s1_up + s1_dn) / 2; 
s2_mean = (s2_up + s2_dn) / 2;

theta_1 = [0.073; 0.062; 0.056; 0.052; 0.050 ]; 
theta_2 = [0.130; 0.114; 0.098; 0.092; 0.087];
%% Least squares
x        = rv      ; 
y1       = 6.125./sin(theta_1);
y2       = 6.125./sin(theta_2);
[B1,dB1] = LEAST_SQUARES_APO_ARXI_AXES(x,y1) ; 
[B2,dB2]  = LEAST_SQUARES_APO_ARXI_AXES(x,y2) ; 
    
minn     = min(x);
maxx     = max(x);

tt       = minn:0.001:maxx ; 

%% PLOTS
plot(x,y1,'o','LineWidth',2.0)
hold on 
plot(x,y2,'*','LineWidth',2.0)
plot(tt,B2*tt,'b-'    ,'LineWidth',1.5)
plot(tt,B1*tt,'black--','LineWidth',1.5)
grid on 
xlabel('X=V^{1/2}','interpreter','tex')
ylabel('Y=6.125/sin\theta','interpreter','tex') 
legend({'Exper. Data 1','Exper. Data 2','Least Squares 1-Large Circle','Least Squares 2-Small Circle'},'FontSize',10,'interpreter','tex')



