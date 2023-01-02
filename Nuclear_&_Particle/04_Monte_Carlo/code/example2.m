% gaussian distributed random numbers between 0 and 1
%
Iseed = input('Enter random number seed: ');
Nrand = input('Enter number of random numbers to be generated: ');
Nbins = input('Enter number of bins for the histo: ');
%
randn('seed',Iseed);
l1 = randn(1,Nrand);
%
if Nbins < 10
    Nbins = 10;
end
%
hist(l1,Nbins),title('distribution of gaussian distributed random numbers')
%
mo1 = mean(l1);
sd1 = std(l1);
fprintf('mean = %f \n',mo1);
fprintf('standard deviation = %f \n',sd1);