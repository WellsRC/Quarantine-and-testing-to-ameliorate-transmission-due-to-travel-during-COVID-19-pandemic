% Determines the parameters for the infecitvity function during the latent
% period
clear;
clc;
av=[10.024035];
bv=[0.939245823173824];
dtv=[0.791600000000000];
mv=zeros(1,1);
tl=[2.9];
lb=[-2];
ub=[2];
opts= optimset('MaxIter',10^4,'MaxFunEvals',10^4,'TolFun',10^(-16),'TolX',10^(-16));
for ii=1:1
    b=bv(ii);
    a=av(ii);
    dt=dtv(ii);
    dydx=(dt.^(a-2).*((exp(-dt./b))./(gamma(a).*b.^a))).*((a-1)-dt./b);
    CD=gampdf(dt,a,b);
    mv(ii)=10.^fmincon(@(z)(1-log10((CD./(exp((10.^z).*(tl(ii)+dt))-1)).*(10.^z).*exp((10.^z).*(tl(ii)+dt)))./log10(dydx)).^2,(lb(ii)+ub(ii))./2,[],[],[],[],lb(ii),ub(ii),[],opts);
end
