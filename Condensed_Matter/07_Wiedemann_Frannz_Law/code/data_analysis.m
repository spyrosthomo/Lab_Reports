clear;clc;close all ; format compact 
%% Open File 
file = 'NI_CU.txt' ; 
[A, delimiterOut] = importdata(file); 
mV   = A(1:end,1);  % mv  
V    = 10^(-3) * mV ;
V2   = V.^2      ;
mV2  = mV.^2     ; 
Tni  = A(1:end,2); 
DTni = Tni - Tni(1); 
Tcu  = A(1:end,3);
DTcu = Tcu - Tcu(1) ; 

Bni   = [mV mV2 Tni DTni] ; 
Bcu   = [mV(1:8) mV2(1:8) Tcu(1:8) DTcu(1:8)] ;
writematrix(Bni,'datani.txt', 'Delimiter', ',') 
writematrix(Bcu,'datacu.txt', 'Delimiter', ',')

%% Ni 
figure(1) 
%Y = [mV2] ; X = [DTni]; % full 
Y =[mV2(1:8)] ; X = [DTni(1:8)];  % 0 - 7 
[A, dA, B, dB ] = LEAST_SQUARES(X,Y);                % Y = AX + B 
fprintf('A_{Ni} = ( %f pm %f )\n',A,dA) 
fprintf('B_{Ni} = ( %f pm %f )\n',B,dB)

title('Ni')
% xx = min(DTni):0.01:max(DTni);  %full 
xx = min(X):0.01:max(X); % 0 - 7 
p  = plot(xx, A*xx+B, 'DisplayName','Least Squares Line','Linewidth',1.5); 
hold on 
pp = plot(X, Y,'o', 'LineWidth',1.5,'DisplayName','Exper. Points') ; 
legend([p,pp])
ylabel('V^2(\mu V^2)') 
xlabel('\Delta T (\pm0.1K)') 
hold off

%Ypologismos L apo Ni 
%Tmean_ni = 290.0 ; DTmean_ni = 0.1;  % Fulll
Tmean_ni = 289.0; DTmean_ni = 0.1; % 0 - 7 
ls       = 8^(-1)*A*10^(-6) ; dls = 8^(-1)*dA*10^(-6); 
fprintf('ls = ( %f pm %f )x10^(-6)\n',ls*10^(6),dls*10^6)
L        = ls / Tmean_ni ; 
dL       = Tmean_ni^(-1) * sqrt( dls^2 + Tmean_ni^(-2)*DTmean_ni^2*ls^2 );
fprintf('L = ( %f pm %f)x10^(-8)\n\n',L*10^(8),dL*10^(8))

%% Cu 
Y = [mV2(1:8)]; X = [DTcu(1:8)]; 

figure(2) 
[A, dA, B, dB ] = LEAST_SQUARES(X,Y);
fprintf('A_{Cu} = ( %f pm %f )\n',A,dA) 
fprintf('B_{Cu} = ( %f pm %f )\n',B,dB)

title('Cu')
xx = min(X):0.01:max(X); 
p  = plot(xx, A*xx+B, 'DisplayName','Least Squares Line','Linewidth',1.5); 
hold on 
pp = plot(X, Y,'o', 'LineWidth',1.5,'DisplayName','Exper. Points') ; 
legend([p,pp])
ylabel('V^2(\mu V^2)') 
xlabel('\Delta T (\pm0.1K)') 

%Ypologismos L apo Cu
Tmean_cu = 289.6 ; DTmean_cu = 0.1; 
ls       = 8^(-1)*A*10^(-6) ; dls = 8^(-1)*dA*10^(-6); 
fprintf('ls = ( %f pm %f )x10^(-6)\n',ls*10^(6),dls*10^6)
L        = ls / Tmean_cu ; 
dL       = Tmean_cu^(-1) * sqrt( dls^2 + Tmean_cu^(-2)*DTmean_cu^2*ls^2 );
fprintf('L = ( %f pm %f)x10^(-8)\n\n',L*10^(8),dL*10^(8))
