
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% BD Veritor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear;
ts=8.29;

Dt=[ 1 2 3 4 5 6 7 ];
S=[7	8; 10	12; 1	2;5	5;3	4;2	3;1	4]';
opts= optimset('MaxIter',10^4,'MaxFunEvals',10^4,'TolFun',10^(-12),'TolX',10^(-12),'UseParallel',false,'Display','off');
[beta,MLE]=fmincon(@(z)Fit(z,Dt,S(1,:),S(2,:),ts),[1 -0.01],[],[],[],[],[0 -100],[100 0],[],opts);
MLE=-MLE;


beta0=linspace(-1,10,551).*beta(1);
beta1=linspace(0,11,551).*beta(2);

[b0,b1]=meshgrid(beta0,beta1);

b0=b0(b1<0);
b1=b1(b1<0);

b0t=b0(b0>=b1.*7.22376995658577);
b1t=b1(b0>=b1.*7.22376995658577);

b0=b0t;
b1=b1t;

L=zeros(size(b0));

for ii=1:length(b0)
    L(ii)=-Fit([b0(ii) b1(ii)],Dt,S(1,:),S(2,:),ts);
end


wc=cumsum(exp(L))./sum(exp(L));

save('BDVeritor_Parameter.mat','L','b0','b1','beta','MLE','wc','Dt','S');

