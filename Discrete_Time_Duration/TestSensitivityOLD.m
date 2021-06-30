function S = TestSensitivityOLD(t,ts,tL,td,testtype,asym)

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

S=zeros(size(t));


    
    load(['Vx_Sy_Latent=' num2str(tL*10) '.mat'],'tt','Vx','f','Sy','mm');
    % Constants for hill function determined by fitting to the mont after
% symotms on set
%     av=[6.85146800000000;3.44342380000000;2.16082760000000];
%     bv=[0.982316341225263;1.76955383531329;2.35323186981921];
%     LatentPeriod=[1.9,2.9,3.9];
%     a=av(tL==LatentPeriod);
%     b=bv(tL==LatentPeriod);
% 
%     mm=(a-1).*b+tL; % The mode of the gamma function plus the latent period

% 
%     tt=[mm:0.1:150];
%     Vx=ViralShedding_Symptomatic(tt,tL,td);
%     f=find(Vx==max(Vx));
%     Vx=Vx(f:end);
%     Sy=SensitivityTimeSamp(tt(f:end),ts);
    if(asym==0)
        V=ViralShedding_Symptomatic(t(t<mm),tL,td);
    else
        V=ViralShedding_Asymptomatic(t(t<mm),tL,td);
    end
    if(isempty(testtype))
        if(~isempty(V))
            S(t<mm)=pchip(Vx,Sy,V);
        end
        S(t>=mm)=SensitivityTimeSamp(t(t>=mm),ts);
    else
        PPA=LR(tt(f:end),testtype);
        if(~isempty(V))
            S(t<mm)=pchip(Vx,PPA.*Sy,V);
        end
        S(t>=mm)=SensitivityTimeSamp(t(t>=mm),ts).*LR(t(t>=mm),testtype);
    end
end

