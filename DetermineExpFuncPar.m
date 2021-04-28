% Determines the parameters for the infecitvity function during the latent
% period
clear;
clc;
av=[6.85146800000000;3.44342380000000;2.16082760000000];
bv=[0.982316341225263;1.76955383531329;2.35323186981921];
dtv=[0.6000;0.4930;0.2280];
mv=zeros(1,3);
tl=[1.9,2.9,3.9];
lb=[-2 -2 -2];
ub=[2 2 2];
opts= optimset('MaxIter',10^4,'MaxFunEvals',10^4,'TolFun',10^(-16),'TolX',10^(-16));
for ii=1:3
    b=bv(ii);
    a=av(ii);
    dt=dtv(ii);
    dydx=(dt.^(a-2).*((exp(-dt./b))./(gamma(a).*b.^a))).*((a-1)-dt./b);
    CD=gampdf(dt,a,b);
    mv(ii)=10.^fmincon(@(z)(1-log10((CD./(exp((10.^z).*(tl(ii)+dt))-1)).*(10.^z).*exp((10.^z).*(tl(ii)+dt)))./log10(dydx)).^2,(lb(ii)+ub(ii))./2,[],[],[],[],lb(ii),ub(ii),[],opts);
end
