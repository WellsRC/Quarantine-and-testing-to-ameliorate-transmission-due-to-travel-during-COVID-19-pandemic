function L = LikelihoodPCRCurve(x,PtID,dstart,dlast,TPtID,TDate,TResult,tL)
beta=10.^x(end-1:end);
TI=x(1:end-2);
[~,Lstart] = DistIncubation(dstart-TI);
[~,Llast] = DistIncubation(dlast-TI);
L1=log(Lstart-Llast);

[~,b]=ismember(TPtID,PtID);

p=PCRSens(TDate'-TI(b(b>0)),beta,tL);
L2=log((p.^TResult).*((1-p).^(1-TResult)));


L= -sum(L1)-sum(L2);
end

