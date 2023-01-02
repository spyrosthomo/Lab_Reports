format compact 
clear; clc 

t = 0.001:0.001:2.1 ; 

h = 6.62607015*10^(-34); 
c = 3*10^8             ; 
k = 1.380649*10^(-23)  ;

c0 = h*c/k ; 

a = [ 1.1:0.1:1.5] ; 
typ =['-','--',':','.','-.'];
for j = 1:length(a)
    i = 1./(t.^5.*(exp(a(j)./t)-1 ));
    p = typ(j);
    plot(t,i,p,'LineWidth',1.1)
    
    f  = @(x) a(j)-5*x*(1-exp(-a(j)/x));
    fp = @(x) -5 * (1-exp(-a(j)/x)) + 5*a(j)*exp(-a(j)/x)/x;
    hold on 
        for k=1:100
           x0 = 1 ; 
           
           xx = x0 - f(x0)/fp(x0);
           x0 = xx;
        end
     %plot([x0,x0],[0,f(x0)])
end
%T=1600;
%i = h*c^2*t.^(-5) .* ( exp(h*c*k^(-1)*T^(-1)./t) - 1  ).^(-1) ;
%i = 2*(h*c^2./(t.^5)) .*(exp(c0./(T*t))-1).^(-1) ;
plot(t,i)
hold on 