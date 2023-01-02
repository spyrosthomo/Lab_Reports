clear;clc;format compact
data = [ 5,2028,1378,0.0004930966,2794584,1336,16914992230656;
6,2169,1299,0.0004610419,2817531,1760,22132894202721;
7,2300,1254,0.0004347826,2884200,2200,27984100000000;
8,2419,1240,0.0004133939,2999560,2688,34240766136721;
9,2530,1191,0.0003952569,3013230,3275,40971520810000 ] ;

v       = data(:,1) ; 
t       = data(:,2) ; 
lambda  = data(:,3) ; 
t1      = data(:,4) ; 
lambdat = data(:,5) ; 
Vm      = data(:,6) ; 
T4      = data(:,7) ; 

%% WIEn 
figure(1)
p1 = plot(lambda, t1, 'o','LineWidth',2.5, 'DisplayName','Exper. Data');
hold on
[ B,A, dB, dA] = LEAST_SQUARES(lambda, t1) ;

tt      = min(lambda):0.001:max(lambda) ; 
p2 = plot(tt, B*tt+A, 'black--', 'LineWidth', 1.5, 'DisplayName','Fit');
leg = [p1,p2];
legend(leg);
xlabel('\lambda_{max}(nm)');
ylabel('1/T(K^{-1})');
grid on 
hold off 

% extra calculations Wien 
N            = length(lambda);
mean_lambdat = mean(lambdat)
sq           = (lambdat-mean_lambdat).^2;
delta        = sqrt(sum(sq)/(N*(N-1))  )

covariance   = sum(( lambda-mean(lambda) ).*( (t1-mean(t1) )  )) / N
correlation  = covariance / ( std(lambda) * std(t1) ) 

%% Stefan-boltzmann
figure(2)

p1 = plot(T4,Vm,'o','LineWidth',2.5, 'DisplayName','Exper. Data')
hold on
[ B ,dB] = LEAST_SQUARES_APO_ARXI_AXES(T4,Vm) 

tt      = min(T4):10^6:max(T4) ; 
p2 = plot(tt, B*tt+A, 'black--', 'LineWidth', 1.5, 'DisplayName','Fit');
leg = [p1,p2];
legend(leg);
xlabel('T^4(10^{13}K^4)');
ylabel('I(T)(Vm)');
grid on 
hold off 

% Extra calculations 
N            = length(T4);

covariance   = sum(( Vm-mean(Vm) ).*( (T4-mean(T4) )  )) / N
correlation  = covariance / ( std(Vm) * std(T4) ) 
stdVm        = std(Vm)
stdT4        = std(T4) 


