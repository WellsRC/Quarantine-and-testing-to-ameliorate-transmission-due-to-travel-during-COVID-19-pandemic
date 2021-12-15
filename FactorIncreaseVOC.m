function [RDelta,ROmicron]=FactorIncreaseVOC

% 
% % https://www.nejm.org/doi/full/10.1056/NEJMc2100362
% %https://science.sciencemag.org/content/early/2021/03/03/science.abg3055 , https://www.nature.com/articles/s41586-021-03470-x
% RAlpha20201201GRY=0.82;
% % https://www.nejm.org/doi/full/10.1056/NEJMc2100362
% RBetaGH501YV2=0.5;
%https://www.bmj.com/content/373/bmj.n1513.full
RDelta=1.82*1.6-1; % 60% more transmissible than the alpha variant

% Omicron 3.2 odds more likely to spread than delta (i.e. p/(1-p)=3.2 -->
% p=3.2/(1+3.2)
% https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1040076/Technical_Briefing_31.pdf
% https://www.cidrap.umn.edu/news-perspective/2021/12/uk-notes-fast-unfolding-omicron-covid-19-impact
ROmicron=1.82*1.6.*(1+3.2/4.2)-1;

end