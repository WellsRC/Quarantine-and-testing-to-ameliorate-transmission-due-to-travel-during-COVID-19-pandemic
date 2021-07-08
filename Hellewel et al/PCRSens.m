function p = PCRSens(t,beta)
%  V = ViralShedding_Symptomatic(t,tL,inf);
%   p= V.^beta(1)./(V.^beta(1)+beta(2));

mmm=exp(beta(1)-beta(2)^2);
% mmm=(beta(1)-1).*beta(2);
p=beta(3).*lognpdf(t,beta(1),beta(2))./lognpdf(mmm,beta(1),beta(2));
end

