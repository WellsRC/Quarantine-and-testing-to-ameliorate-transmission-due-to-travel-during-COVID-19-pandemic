function S = SensitivityTimeSamp(t,ts)
%Sensitivity Returns the sensitivity of the test at time t
polyc=[3.11704516890789,-0.147065018471091,-0.0159706947117169,0.00131081512242671,-2.98643956911681e-05];

% Need to transform to days after symptom onset
t=t-ts;
S=1./(1+exp(-polyval(flip(polyc),t))); % need to flip based on how polyval is used and how beta was determined
end

