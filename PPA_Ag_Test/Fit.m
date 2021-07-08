function F = Fit(x,T,P,N)
T=T;
L=(LR(T,x).^P).*((1-LR(T,x)).^(N-P));
F=-sum(log(L));
end

