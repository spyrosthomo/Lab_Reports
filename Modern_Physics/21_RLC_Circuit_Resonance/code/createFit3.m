function [fitresult, gof] = createFit3(f1, i01)
%CREATEFIT3(F1,I01)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : f1
%      Y Output: i01
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 16-Nov-2021 14:14:35


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( f1, i01 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
plot( fitresult, xData, yData );
hold on 
legend('i01 vs. f1', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'f1', 'Interpreter', 'none' );
ylabel( 'i01', 'Interpreter', 'none' );
grid on
% plot(fitresult,'--b') 
% hold on 
% plot(xData,yData)
% legend('Fitted Curve', 'I_0 vs f ', 'Location', 'NorthEast')
% xlabel('f(kHz)') 
% ylabel('i_0(mA)') 
% grid on 

