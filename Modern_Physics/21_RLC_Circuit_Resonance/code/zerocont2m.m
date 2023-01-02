function zerocont2m(f,rv)
% zerocont2m(f,[x1min x1max x2min x2max])
% plot zero contours of vector valued function in rectangle 
% function f maps a vector of length 2 to a column vector of length m
% Use @f if function is given in m-file f.m
%
% Example:
% f = @(x) [x(1)^2+x(2)^2-2; x(2)-1]
% zerocont2m(f,[-2 2 -2 2])

warning('off','MATLAB:ezplotfeval:NotVectorized')

y = f([rv(1),rv(3)]); 
m = length(y);

for i=1:m
  v = zeros(m,1);
  v(i) = 1;

  ezplot( @(x1,x2) v'*f(x1*[1;0]+x2*[0;1]), rv); hold on;

end

h=get(gca,'children');
set(h,'LineWidth',2,'color','black')
axis equal; axis(rv); 
title(sprintf('zero contours of f_1,...,f_%g',m))

warning('on','MATLAB:ezplotfeval:NotVectorized')
