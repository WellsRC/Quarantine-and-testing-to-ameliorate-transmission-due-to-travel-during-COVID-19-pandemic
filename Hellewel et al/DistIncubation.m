function [f,F] = DistIncubation(Inc)
%DISTINCUBATION Summary of this function goes here


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Shorter Incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  p=[1.64,0.363];
%  
%  f=lognpdf(Inc,p(1),p(2));
%  F=logncdf(Inc,p(1),p(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Longer Incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 p=[9.35067035405592,1.96922912932549];
 
 f=wblpdf(Inc,p(1),p(2));
 F=wblcdf(Inc,p(1),p(2));

end

