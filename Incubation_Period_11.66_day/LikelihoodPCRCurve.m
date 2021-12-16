function L = LikelihoodPCRCurve(x,PtID,dstart,dlast,TPtID,TDate,TResult)
beta=10.^x(end-1:end);

% Shorter incubation period
betat=log(11.375787181924398)+beta(1)^2;
beta=[betat beta];
TI=x(1:end-2);
[~,Lstart] = DistIncubation(dstart-TI);
[~,Llast] = DistIncubation(dlast-TI);
L1=log(Lstart-Llast);

[~,b]=ismember(TPtID,PtID);

p=PCRSens(TDate'-TI(b(b>0)),beta);
L2=log((p.^TResult).*((1-p).^(1-TResult)));

L= -sum(L1)-sum(L2);
end

