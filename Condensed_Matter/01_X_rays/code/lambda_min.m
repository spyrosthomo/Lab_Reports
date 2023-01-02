clear; format compact; clc 

file = 'data1.txt' ; 
h    = 6.6261 * 10^(-34); 
c    = 2.9979 * 10^(8)  ;
e    = 1.6022 * 10^(-19);
dv   = 100;
%% OPen file 
%f    = fopen(file,'wt')

[A,delimiterOut] = importdata(file); 
v                = A(1:end,1); 
lambda           = A(1:end,2); 

vm1              = 1./(1000*v) * 10^5 ; 
vm1              = round(vm1,2);

dlambda          = 0.01*ones(length(v),1);%h*c*dv./(e*(v*1000).^2)*10^9;
%dlambda          = round(dlambda, 2);

B           = [ v vm1 lambda dlambda]  ;


writematrix(B,'data11.txt','Delimiter',',')

%% LEAST SQUARES
X = vm1 ; Y = lambda;
[a, da] = LEAST_SQUARES_APO_ARXI_AXES(X,Y);
fprintf(' A = ( %f pm %f)\n',a,da)
%fprintf(' B = ( %f pm %f)\n',b,db)

t  = min(X):0.01:max(X); 
y  = a*t;   %+b ; 
%fi
p1 = plot(X, Y, 'o', 'LineWidth', 2.0, 'DisplayName', 'Exper. Data') ;
hold on 
p2 = plot(t, y, 'LineWidth', 2.0, 'DisplayName', 'Least Sq. Line') ; 
legend([p1,p2]);
xlabel('1/V(10^{-5}V^{-1})') 
ylabel('\lambda_{min}(pm)')

