function F = Fit(x,T,P,N,ts)
T=T+ts;
L=(LR(T,x).^P).*((1-LR(T,x)).^(N-P));
F=-sum(log(L));
end

