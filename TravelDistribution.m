function f = TravelDistribution(X,Par)

switch Par.Dist
    case 1
        f=poisspdf(X-1,Par.A);
    case 2
        f=nbinpdf(X-1,Par.A,Par.B);
    case 3
        f=EmpericalDist(X,Par.A);
    case 4
        f=zeros(size(X));
        for ii=1:length(Par.A)
            f=f+Par.B(ii).*poisspdf(X-1,Par.A(ii));
        end
end
    
end

