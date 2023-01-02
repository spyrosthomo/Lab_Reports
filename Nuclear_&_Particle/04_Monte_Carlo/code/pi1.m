% find value of pi
%
Iseed1 = input('Enter random number seed: ');
Iseed2 = input('Enter random number seed for second series: ');
Nrand = input('Enter number of random numbers to be generated: ');
%
rand('seed',Iseed1);
l1 = rand(1,Nrand);
rand('seed',Iseed2);
l2 = rand(1,Nrand);
rand('seed',Iseed1);
%
coun1 = 0;
for k = 1:Nrand
   athr = ((l1(k))^2 + (l2(k))^2);
   if athr <= 1 
     coun1 = coun1 + 1;
   end
end
pi4 = coun1/Nrand;
erpi4 = (1/Nrand)*(sqrt((coun1*(Nrand-coun1)/Nrand) - 1));
fprintf('<pi/4> = %f \n',pi4);
fprintf('delata<pi/4> = %f \n', erpi4);
