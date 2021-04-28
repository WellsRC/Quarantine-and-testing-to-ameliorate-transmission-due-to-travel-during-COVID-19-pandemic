function P = Probability_Onward(R,dist)
%PROBABILITY_ONWARD reuturns the probability of onward transmission for a
%given distribution

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R- secondary infections
% dist- Distribtuion to use
% dist = 0 - Poisson
% dist = 1 - Negative binomial 20/80
% dist = 2 - Negative binomial 10/90
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(dist==0)
    P=1-poisspdf(0,R);
elseif(dist==1)
    r=0.25;
    p=r./(r+R);
    P=1-nbinpdf(0,r,p);
end

end

