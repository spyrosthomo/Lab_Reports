data = [ 
15,89
20,88
25,85
30,84
35,81
40,73
45,66
50,62
55,55
60,45
65,38
70,28
75,24
80,15] ; 

th = data(:,1); 
psi   = data(:,2); 


%% MODEL 
X = th*pi/180 ; 
y = psi*pi/180   ;
m = length(y);

p = 3;

% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

lambda =  0.5;
[theta] = trainLinearReg(X_poly, y, lambda);

%% PLOT 

figure(1) 
plot(X*180/pi,y*180/pi,'o')
plotFit(min(X), max(X)+0.05, mu, sigma, theta, p,'Experimental');
hold on 
grid on 
xlabel('\theta_{in}(^o)','FontSize',17)
ylabel('\Psi(^o)','FontSize',17) 

% Theoretical Plot 
theta_th = 15:0.01:80; 
n = 1.732

up   = - cos(theta_th*pi/180) .* sqrt(n^2-sin(theta_th*pi/180).^2) ; 
down = sin(theta_th*pi/180).^2; 

psi_theoretical = atan( -up ./ down );

p2 = plot(theta_th, psi_theoretical*180/pi, 'black--','LineWidth',1.7);
legend

