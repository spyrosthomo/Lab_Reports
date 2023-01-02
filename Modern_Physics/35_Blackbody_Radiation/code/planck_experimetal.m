clear;clc

files = [ 'dsf_1.txt'; 'dsf_2.txt'; 'dsf_3.txt'; 'dsf_4.txt'; 'dsf_5.txt' ] ; 
m     = length(files(:,1)); 
lambda = zeros(10^5,5) ; 
inten  = zeros(10^5,5) ;
T      = ["5V","6V","7V","8V","9V"];
for i=1:m
    filename         = files(i,:);
    [A,delimiterOut] = importdata(filename)
    lambda = A.data(3:end, 1);
    inten  = A.data(3:end, 2);
    
    a = T(i);
    leg(i) = plot(lambda, inten,'.','DisplayName','V='+a+'olts', 'MarkerSize',8);
    hold on 
    
end

grid on 
legend(leg)
xlabel('\lambda(nm)','FontSize',13)
ylabel('Intensity(Volts)','FontSize',13)
