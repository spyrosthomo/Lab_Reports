clear;clc
red  = [641.7, 647.4, 648.5, 645.9, 646.8, 648.4 ];
blue = [475.4, 469.7, 481.7, 476.1, 474.8, 483.6 ];
purp = [425.2, 425.2, 428.6, 431.4, 423.6, 428.9 ];

mean_red = sum(red)/length(red) 
mean_blue = sum(blue)/length(blue) 
mean_purp = sum(purp)/length(purp)

% dred = ( sum((red-mean_red).^2)   /(length(red)*(length(red)-1))   ) ^(0.5)
% dblue = ( sum((blue-mean_blue).^2)/(length(blue)*(length(blue)-1)) ) ^(0.5)
% dpurp = ( sum((purp-mean_purp).^2)/(length(purp)*(length(purp)-1)) ) ^(0.5)

dred  = ( sum((red-mean_red).^2  ) /length(red)  ) ^(0.5)
dblue = ( sum((blue-mean_blue).^2) /length(blue) ) ^(0.5)
dpurp = ( sum((purp-mean_purp).^2) /length(purp) ) ^(0.5)

f=@(li, m) 1/(li * ( 0.25-1/m^2 ) ) ;
ryd   = 100*[ f(mean_red,3), f(mean_blue, 4), f(mean_purp, 5)]

mean_ryd = sum(ryd)/3
delt_ryd = sqrt( sum((ryd-mean_ryd).^2)  / 3)