function [f,F] = DistIncubation(Inc)
%DISTINCUBATION Summary of this function goes here

 p=[9.35067035405592,1.96922912932549];
 
 f=wblpdf(Inc,p(1),p(2));
 F=wblcdf(Inc,p(1),p(2));

end

