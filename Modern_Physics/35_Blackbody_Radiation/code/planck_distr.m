clear ;clc; format compact
 
h = 2*pi * 1.055 *10^(-34) ; 
c = 3*10^8 ; 
k = 1.381*10^(-23); 

T  = [1200 1400 1600 1800 2000] ; 
t  = 0:10^(-9):6*10^(-6); 

i1 = @(x) h*c^2 ./ x.^5 ; 
leg = [] ; 

for j = 1:length(T) 
    i2 = @(x) exp(h*c./(k*T(j)*x)) -1 ; 
    i  = i1(t)./i2(t);
    a  = string(T(j));
    leg(j) = plot(t,i,'DisplayName','T='+a+'K');
    hold on 
    lambda(j) = 2.898*10^(-3)/T(j) ; 
    imax(j)   = i1(lambda(j))/i2(lambda(j))    ; 
    plot([lambda(j),lambda(j)],[0,imax(j)],'black--') 
    plot(lambda(j),imax(j),'o')
end
legend(leg)
xlabel('\lambda(\mu m)','FontSize',10)
ylabel('I(10^{10} W m^{-2} m^{-1}')
grid on 

