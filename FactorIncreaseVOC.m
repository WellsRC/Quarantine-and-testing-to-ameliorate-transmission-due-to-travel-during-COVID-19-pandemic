function [RAlpha20201201GRY,RBetaGH501YV2,RDeltaG478KV1]=FactorIncreaseVOC


% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
%https://science.sciencemag.org/content/early/2021/03/03/science.abg3055 , https://www.nature.com/articles/s41586-021-03470-x
RAlpha20201201GRY=0.82;
% https://www.nejm.org/doi/full/10.1056/NEJMc2100362
RBetaGH501YV2=0.5;
%https://www.bmj.com/content/373/bmj.n1513.full
RDeltaG478KV1=1.82*1.6-1; % 60% more transmissible than the alpha variant

end