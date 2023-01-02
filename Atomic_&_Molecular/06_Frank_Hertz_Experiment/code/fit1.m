function [fitresult, gof] = fit1(v, i)
%CREATEFIT(V,I)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : v
%      Y Output: i
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 13-Apr-2022 19:30:11


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( v, i );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.999816842300588;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult);

% Label axes
xlabel( 'V(\pm0.1V)', 'Interpreter', 'tex' );
ylabel( 'I(\pm0,1nA)', 'Interpreter', 'tex' );
hold on 
 
hh = plot(v,i,'o', 'LineWidth',1.5); 

legend([h,hh])


