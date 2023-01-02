% neutron decay part2
%
N0=input('Number of neutrons at t=0: ');
Iseed = input('Random number seed: ');
end_time = input('Enter time t: ');
Nrand = input('Number of random numbers to be generated: ');
%
%Nrand = N0;
rand('seed',Iseed);
Irand = rand(1,Nrand);
%
Nund = 0;
Nd = 0;
tend = end_time;
Probt = 1 - exp(-(tend/886.7));
for k = 1:Nrand
  if Probt <= Irand(k)
     Nund = Nund + 1;
  else
    Nd = Nd + 1;
  end

end
Nundec = round(Nund*N0/Nrand);
fprintf('Number of undecayed neutrons after %i seconds: %i \n',end_time,Nundec);
%disp('Nundec: ');
%disp(Nundec);

