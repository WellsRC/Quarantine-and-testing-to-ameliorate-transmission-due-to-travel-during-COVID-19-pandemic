med=11.6;

opts= optimset('MaxIter',10^6,'MaxFunEvals',10^6,'TolFun',10^(-16),'TolX',10^(-16));
p=fmincon(@(x)sum((logninv([0.025 0.975],log(med),x)-[9.49 14.20]).^2),1,[],[],[],[],0,10,[],opts);

[mm,vv]=lognstat(log(med),p)

logninv([0.025 0.975],log(med),p)

