function [fitresult, gof] = smooth_spline_fit_Ir(x, y,line) 

%
%  Create Smooth Spline Fit 
%

[xData, yData] = prepareCurvedata(x, y); 

% SEt fittype
ft = fittype('smoothingspline') ; 
 
% fit model to data 
[fitresult, gof ] = fit(xData, yData, ft ) ; 

% plot 
plot(fitresult,'--b','LineWidth',line) 
hold on 
plot(xData,yData,'o','1.5')
legend('Fitted Curve', 'I_0 vs f ', 'Location', 'NorthEast')
xlabel('f(kHz)') 
ylabel('i_0(mA)') 
grid on 
end