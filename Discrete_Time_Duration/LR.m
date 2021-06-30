function y = LR(t,beta)
X=[];
for ii=1:length(beta)
    X=[X;t.^(ii-1)];
end
y=(1./(1+exp(-beta*X)));
end

