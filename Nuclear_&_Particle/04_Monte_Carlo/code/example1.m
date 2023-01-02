% this is an example meant only for illustration
% uniformly distributed random numbers between 0 and 1
%
Iseed1 = input('Enter random number seed: ');
Nrand = input('Enter number of random numbers to be generated: ');
Nbins = input('Enter number of bins for the histo: ');
%
rand('seed',Iseed1);
l1 = rand(1,Nrand);
%
if Nbins < 10
   Nbins = 10;
end
%
subplot(2,1,1),hist(l1,Nbins),title('distribution of random numbers'),... 
    xlabel('x_i '),...
subplot(2,1,2),hist((1-l1),Nbins),xlabel( '1-x_i ')
%
    mo1 = mean(l1);
    sd1 = std(l1);
    var1 = var(l1);
    s12 = 0;
    s22 = 0;
    s23 = 0;
    for j=1:Nbins
        athr1(j) = 0;
    end
    for k=1:Nrand
        s12 = s12 + (((l1(k))-mo1)^2) ;
        ibin1 = (round(l1(k) * Nbins)) ;
        ibin2 = (round((l1(k)+(0.5/Nbins)) * Nbins)) ;
        if ibin1 >= ibin2;
            ibin = ibin1;
        else
            ibin = ibin2;
        end
        athr1(ibin) = athr1(ibin) + 1;
    end
    s1 = s12/(Nrand -1) ;
subplot; 
for j=1:Nbins
    s22 = s22 + athr1(j);
end
s2 = s22/Nbins;
for j=1:Nbins
    s23 = s23 + (((athr1(j))-s2)^2) ;
end
s3 = sqrt(s23)/(Nbins -1) ;
vary = std(athr1);
sigy = s3;
sigpery = s3/s2;
fprintf('meany = %f \n', s2);
fprintf('sigy = %f \n', s3);
fprintf('percent = %f \n', sigpery);


% usefull commands:
%
%  disp('text') to display text    or
%  disp(variable) to display variable
%  fprintf('text  %f \n',variable); in order to print
%
