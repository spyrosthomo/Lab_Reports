fnx = @(x,fn) sin(2*pi*fn*x).*exp(-fn*abs(x));

ffs = 1000;
tp = 0:1/ffs:1;

pp = fnx(tp,30);

plot(tp,pp)
xlabel('Time (s)')
ylabel('Waveform')

fs =2e3;
t = 0:1/fs:1.2;

d = 0:1/3:1;
dd = [d;4.^-d]';

z = pulstran(t,dd,pp,ffs);

plot(t,z)
xlabel('Time (s)')
ylabel('Waveform')