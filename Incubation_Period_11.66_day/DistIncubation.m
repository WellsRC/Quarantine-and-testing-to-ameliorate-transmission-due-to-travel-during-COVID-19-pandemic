function [f,F] = DistIncubation(Inc)
%DISTINCUBATION Summary of this function goes here


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% longer Incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 p=[log(11.6) 0.102952484199086];
 
    f=lognpdf(Inc,p(1),p(2));
    F=logncdf(Inc,p(1),p(2));
end

