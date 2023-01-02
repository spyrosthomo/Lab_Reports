format compact; clear
clc 

data = [ 0,6.2,3.3,
5,6.2,3.2,
10,6.0,2.6,
15,5.8,1.9,
20,5.5,0.9,
25,4.5,0.3,
30,2.8,-1.3,
35,2.2,-2.2,
40,1.4,-2.8,
45,0.4,-3.1,
50,-0.8,-3.0,
55,-1.8,-2.4,
60,-2.8,-1.5,
65,-4.0,-0.6,
70,-4.4,0.5,
75,-5.4,1.4,
80,-5.7,2.2,
85,-5.5,2.9];
%90, 0,  3.2 ] ;

x    = data(:,1) ;
xx   = 0:0.01:0.9;
psi1 = data(:,2) ; 
psi2 = [data(:,3); 3.2];

n = 6


%plot(x,psi1, 'o') 
%hold on 
%p = polyfit(x,psi1,n) 
%p2 = plot(x,psi1,'*')
hold on
Legend=cell(4,1) 
Legend{1}='\f_1 exp';
legend
%plot(xx,polyval(p,xx),'--') 
errorbar(x,psi1,0.2*ones(length(x),1),'b*')
[a b c d ] = regPol(n,x,psi1,'b-')
%modelfit(x,psi1)
%plot(x,psi2,'o')
grid on 

%% 
errorbar([x ;90],psi2 ,0.2*ones(length(x)+1,1),'blacks')
[a b c d ] = regPol(n,[x ;90],psi2,'black--')

%% 
%plot(xx,0,'black-','LineWidth',0.5)
plot([0,90],[0,0],'r')
