function [f,F] = DistIncubation(Inc)
%DISTINCUBATION Summary of this function goes here


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Shorter Incubation period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 p=[1.570 0.650;1.621 0.418; 1.434 0.661; 1.611 0.472; 1.857 0.547; 1.540 0.470; 1.530 0.464];
 
 ft=zeros(7,length(Inc));
 Ft=zeros(7,length(Inc));
 for ii=1:7
    ft(ii,:)=lognpdf(Inc,p(ii,1),p(ii,2));
    Ft(ii,:)=logncdf(Inc,p(ii,1),p(ii,2));
 end
f=mean(ft,1);
F=mean(Ft,1);
end

