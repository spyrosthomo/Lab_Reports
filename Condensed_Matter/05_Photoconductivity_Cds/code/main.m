clear ;clc; close all ; format compact 

%% Open file
file = 'data1.txt'; 
[A, delimiterOut] = importdata(file); 
v     = A(:,1);
iback = A(:,2);
i0    = A(:,3); 
i15   = A(:,4); 
i45   = A(:,5); 
% i70   = A(:,6); 
% i90   = A(:,7);

i     = A(:,3:5); 

itrue = i-iback;
%itrue(1,1) = 3.4;   itrue(1,2)=2.7; itrue(1,4) = 0.69;
it0  = i0  - iback;  %it0  = it0(2:end);
it15 = i15 - iback;  %it20 = it20(2:end);
it45 = i45 - iback;
% it70 = i70 - iback;  %it70 = it70(2:end);
% it90 = i90 - iback;

B1 = [v, iback, i];
B2 = [v, itrue];

writematrix(B1,'data1.txt','Delimiter',',')
writematrix(B2,'data1_true.txt','Delimiter',',')


%% Photo current 
%Least Squares
%theta = [0 20 50 70 90]' ;
theta = [0 15 45 ]'; 
A = [];dA=[];B=[];dB=[];

for j = 1:3
    [A(j), dA(j), B(j), dB(j)] = LEAST_SQUARES(v,itrue(:,j)); 
end
% [A(1), dA(1), B(1), dB(1)] = LEAST_SQUARES(v(2:end), it0);
% [A(2), dA(2), B(2), dB(2)] = LEAST_SQUARES(v(2:end), it20);
% [A(3), dA(3), B(3), dB(3)] = LEAST_SQUARES(v, it50);
% [A(4), dA(4), B(4), dB(4)] = LEAST_SQUARES(v(2:end), it70);
% [A(5), dA(5), B(5), dB(5)] = LEAST_SQUARES(v, it90);


t = min(v):0.01:max(v);

figure(1)
ha=[]; hb=[];
thet = ['0', '1', '4'];%, '7', '9'] ;
sym   = ['o','*','s'];%,'h','s'];
color = ['r','g','black'];%,'g','black']; 
for j = 1:3
   ha(j) = plot(v, itrue(:,j), sym(j), 'Color',color(j),'LineWidth',1.5,'DisplayName',thet(j)); 
   hold on 
   
end
for j=1:3
    
   hb(j) = plot(t, A(j)*t+ B(j),'Color',color(j), 'LineWidth',1.5,'DisplayName',thet(j)); 
end

xlabel('V(V)') 
ylabel('I_{phot.}(mA)')
a=[];
for j=1:3
    a(j)   = ha(j);
    a(j+1) = hb(j);
end
cos2 = cosd(theta).^2;

figure(2) 
plot(cos2, A', 'o', 'LineWidth', 2.5)
%plot([cos2(1) cos2(2) cos2(4) cos2(5)], [A(1) A(2) A(4) A(5)], 'o', 'LineWidth', 2.5)
[a,da,b,db] = LEAST_SQUARES(cos2, A') ; 
%[a,b,da,db] = LEAST_SQUARES([cos2(1) cos2(2) cos2(4) cos2(5)], [A(1) A(2) A(4) A(5)]) ; 
hold on 
x = min(cos2):0.01:max(cos2);
plot(x,  a*x + b, '-','LineWidth',1.5)
xlabel('cos^2\theta') 
ylabel('\sigma_\theta(10^{-4}\Omega)')

%% part 2 
file = 'data2.txt'; 
[A, delimiterOut] = importdata(file);
theta = A(:,1) ;
i0    = A(:,2) ; 
iback = A(:,3) ;

itrue   =  i0 - iback ; 

% preparatory
lambda  = @(phi) -75*phi +11200;%[nm]


% SSSSSSSSS IIIIIIIIIIIIIIIIII
% h       = 6.626 * 10^(-34); %[SI] Js
% c       = 3*10^8     ; % m//s
% k = 1.380649*10^(-23)  ; %J/K
T   = 4.13*10^3;
h = 6.626 *10^(-34) ; 
c = 3*10^8 ; 
k = 1.381*10^(-23); 

% NOT    SI 
hc      = 1240     ; %eV nm
kT      = 25*10^(-3) ; %eV
hc2     = hc*c

%
En  = @(lambda) hc ./ lambda;

% calculations 
lam   = lambda(theta) ;

E   = En(lam);

lam  = lam*10^(-9);
Fup1    = 2*pi * h *c^2 ;
Fup     = Fup1 .* lam.^(-5);
Fdownin = h*c*(k*T)^(-1) ./ lam; 
Fdown   = exp( Fdownin ) - 1     ;
F       =  Fup./Fdown;
fmax = max(F) ;
fmin = min(F) ; 
normal = F/fmax ;

Inormal = itrue .* normal ;

B =[theta itrue lam F E normal Inormal ] ;
writematrix(B,'data2_final.txt','Delimiter',',')

figure(3) 
x = min(E):0.01:max(E) ;

 %EE = E(4:8); II = Inormal(4:8);
h1 = plot(E, Inormal, 'o','LineWidth',1.5) 
fitt(E,Inormal)
hold on 
plot(E,Inormal,'o','LineWidth',1.5)

xlabel('E(eV)') 
ylabel('I_{norm}(\muA)')

