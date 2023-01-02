format compact 
clear
clc
data=[5.2,0.0007 ,5.2,0.0007;       % ??? ????? 2 ??? ???????? ????????? ?? ????? ???? ?? ?? ??????? ??? ?? ??????? ? ??
5.4,0.0014,5.4,0.0017;
5.6,0.0031,5.6,0.0034;
5.8,0.0065,5.8,0.0072;
6.0,0.0130,6.0,0.0130;
6.2,0.0283,6.2,0.0223;
6.4,0.0467,6.4,0.0450;
6.6,0.0740,6.6,0.0747;
6.7,0.0879,6.7,0.0879 ]            % ??? ??????? ????? 2 ??? ???????? ????????? ?? ????? ???? ?? ?? ??????? ??? ?? ??????? ? ??

u1=data(2:end,1); 
u2=data(2:end,3);
i1=10^4*data(2:end,2);
i2=10^4*data(2:end,4);

imean=(i1+i2)/2

icold = imean-5

%% fit I_cold - V curve
n=3
figure(1)
[a,b,c,d]=regPol(n,[5.2;u1],[6;icold],'black--','{V(kV)}','I_{cold}(nA)')
hold on 
grid on
plot([5.2;u1],[6;icold],'o','LineWidth',2)
legend('Fit Curve','Exper. Data')
hold off
%% least square
X = 1./u1 ;
Y = log(icold./(u1.^2));
mat = [ icold u1 X Y ]


%Compute coefficients Y=A+BX
%[A B Aerror Berror] = least_squares(X,Y)
m = length(X) ; 
D = m*sum(X.^2)-(sum(X))^2
A = (sum(X.^2)*sum(Y)-sum(X)*sum(X.*Y))/D;
B = ( m*sum(X.*Y)- sum(X)*sum(Y) )/D;
A
B
sy          = sqrt((sum((Y-A-B*X ).^2) )/(m-2));
deltaA_stat = sy*sqrt(sum(X.^2)/D);
deltaB_stat = sy*sqrt(m/D);

% error of B 
tnp      = 3.833;
dB_instr = 0.03*B 
dB_stat  = sy*sqrt(1/D)*tnp 
dB       = abs(dB_instr) + abs(dB_stat )

%discr x 
xx = min(X):0.000001:max(X); 
yy = A+B*xx;
%[a,b,c,d] = regPol(1,X,Y,'black--','X','Y') 
figure(2)
plot(X,Y,'o','LineWidth',2)
hold on 
plot(xx,yy,'--black','LineWidth',1.5) 
grid on
xlabel('X=1/V(kV^{-1})')
ylabel('Y=ln(I_{cold}/V^2)')
legend('(X,Y) points from exper. data','Line from Least Squares')