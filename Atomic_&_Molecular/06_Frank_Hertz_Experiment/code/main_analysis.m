clear; clc ; close all; format compact 

%% PART 1 - Dynamiko epafhs

% Open data file 1 
file = 'exp1.txt'; 
[A, delimiterOut] = importdata(file); 
v    = A(:,1) ; %V 
i    = -A(:,2) ; % nA
i(end) = 2.5;

[fitresult, gof] = fit1(v,i); 


%% PART 2 - reuma tash
close all ;
% Open dat file 1 
file = 'exp2.txt'; 
[A, delimiterOut] = importdata(file); 
v2   = A(:,1) ; 
i3   = A(:,2) ; 

vv2 = [v2(1:24,1) v2(25:48,1) [v2(49:71,1);0] [v2(72:94,1);0]];
ii3 = [i3(1:24,1) i3(25:48,1) [i3(49:71,1);0] [i3(72:94,1);0]]; 

B = zeros(max(size(vv2)) ,8);
for i = 2:2:8
    B(:,i-1)   =  vv2(:,i*0.5);
    B(:,i)     =  ii3(:,i*0.5);
end 

writematrix(B,'exp2_f.txt','Delimiter', ',');

i3 = abs(i3);

[fitresult, gof] = fit1(v2,i3);