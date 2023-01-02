%data = importdata('data1.txt') 
%data1 = cell2mat(data)
clear;clc

data = [ 15.0, 2.5 , 3.0
20.0, 2.3 , 3.0 
25.0, 2.2 , 3.0
30.0, 2.1 , 3.0
35.0, 1.7 , 3.0
40.0, 1.2 , 3.0
45.0, 0.8 , 3.0
50.0, 0.5 , 3.0
55.0, 0.2 , 1.0
60.0, 0.1 , 1.0
65.0, 0.7 , 1.0
70.0, 1.1 , 1.0
75.0, 3.2 , 10.0
80.0, 9.1 , 10.0 ] ;


theta = data(:,1); 
I     = data(:,2) ;
scale = data(:,3);
theta'
I'
scale'

%% theta trans
n       = 1.664 
theta_t = asin(sin(theta*pi/180) /n) * 180 / ( pi ); 
theta_t'

%% r , R theoretical
r = (n*cos(theta*pi/180) - cos(theta_t*pi/180))./ ( n*cos(theta*pi/180) + cos(theta_t*pi/180) ) ;
R = r.^2;
%% I_{theoretical}
Iin = 30; 
I_r_the = R * Iin;

%plot(theta,I,'o')
%m = length(I) ; 

%theta = [ ones(m,1), theta];
t     = zeros(2,1) ;
iter = 1500;  alpha = 0.01;

%modelfit(theta,I)