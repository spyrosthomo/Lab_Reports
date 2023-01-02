% find value of pi
%
Iseed1 = input('Enter random number seed: ');

Nrand = input('Enter number of random numbers to be generated: ');
%
rand('seed',Iseed1);
l1 = rand(1,Nrand);



 
n1 = 0
n2 = 0
f1 = 0 
f2 = 0 
for k = 1:Nrand
   f1 = 1/((l1(k)+1).^2);
   f2 = f1*f1;
   n1 = n1 + f1;
   n2 = n2 + f2 ;
end
pi4   = n1/Nrand;
pi4_2 = n2/Nrand ;
erpi4 = sqrt((pi4_2-pi4.^2)/Nrand) ;

%erpi4 = (1/Nrand)*(sqrt((coun1*(Nrand-coun1)/Nrand)));
fprintf('<pi/4> = %f \n',pi4);
fprintf('delta<pi/4> = %f \n', erpi4);

%fprintf('|pi/4 - pi/4_estimated |= %f\n', abs(pi/4-pi4))
