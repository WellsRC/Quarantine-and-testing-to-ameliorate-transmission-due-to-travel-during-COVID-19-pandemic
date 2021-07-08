function p = PCRSens(t,beta,tL)
 V = ViralShedding_Symptomatic(t,tL,inf);
  p= V.^beta(1)./(V.^beta(1)+beta(2));
 

 %p=C.*gampdf(beta(3).*t,beta(1),beta(2))./gampdf((beta(1)-1).*beta(2),beta(1),beta(2));
%p=1./(1+exp(-(beta(1).*(V-beta(2)).*(V-beta(3)))))-1./(1+exp(-(beta(1).*(-beta(2)).*(-beta(3)))));

%p(p<0)=0;
% S = t-C;
% I=zeros(size(S));
% I(S>0)=1;
% 
% p=1./(1+exp(-(beta(1)+beta(2).*S+beta(2).*beta(3).*S.*I)));
end

