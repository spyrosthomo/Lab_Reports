%
%elaxista tetragwna gia typo y=Bx 
%
function [B, dB] = LEAST_SQUARES_APO_ARXI_AXES(x,y)
    SU=x; %edw to x 
    I=y ;  %edw to y 
    sxy=sum(SU.*I) ;
    sx2=sum(SU.^2) ;
    B=sxy/sx2 ;
    N=length(SU);
    s=sum((I-B*SU).^2); 
    sigmay=sqrt(s/(N-1));
    disp('B error') 
    sigmaB=sqrt( sigmay^2 /sx2  );
    disp('H eutheia einai y=Bx') 
    B  = B; 
    dB = sigmaB;
end