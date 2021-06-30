function S = SensitivityvsViralLoad(V,ts,tL,td,testtype)
%SensitivityvsViralLoad(V,asym) - Returns the sensitivity for a given viral
%load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V - Viral load in which to determine the sensitivity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S - Probability of that it is a true positive based on the viral load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants for hill function determined by fitting to the mont after
% symotms on set
    av=[6.85146800000000;3.44342380000000;2.16082760000000];
    bv=[0.982316341225263;1.76955383531329;2.35323186981921];
    LatentPeriod=[1.9,2.9,3.9];
    a=av(tL==LatentPeriod);
    b=bv(tL==LatentPeriod);

    mm=(a-1).*b+tL; % The mode of the gamma function plus the latent period
    tt=[mm:0.1:150];
    Vx=ViralShedding_Symptomatic(tt,tL,td);
    f=find(Vx==max(Vx));
    Vx=Vx(f:end);
    Sy=SensitivityTimeSamp(tt(f:end),ts);
    if(length(testtype)==0)
        S=pchip(Vx,Sy,V);
    elseif(length(testtype)>0)
        PPA=LR(tt(f:end),testtype);
        S=pchip(Vx,PPA.*Sy,V);
    end
end

