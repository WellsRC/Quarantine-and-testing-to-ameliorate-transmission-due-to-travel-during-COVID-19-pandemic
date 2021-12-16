# Sufficient strategies for travel quarantine and testing
Chad R. Wells, Jeffrey P. Townsend*, Abhishek Pandey, Meagan C. Fitzpatrick, William S. Crystal, Alison P. Galvani
Copyright (C) <2021>, Chad R. Wells et. al. All rights reserved. Released under the GNU General Public License (GPL)

This repository contains codes and data used to simulate and analyze COVID-19 travel quarantine and testing strategies between countries.

## Interactive Excel spreadsheet
Supplemental_Quarantine_Calculation - Allows for users to input the parameters to determined the minimum sufficient quarantine such that the total number of infections by that variant within the destination country will not be greater than with border closure.

The model code is written in MATLAB and results are saved as MATLAB data files (extension .mat), with plots also being constructed in MATLAB. As MATLAB is not an open-source software/programming language, a compatible code that can be run using GNU Octave can be found in the directory named Octave in the repository.

## OS System requirements
The codes developed here are tested on Windows operating system (Windows 10 Home: 64-bit). However as Matlab is available for most operating systems, codes should run on Mac OSX and Linux as well.

## Installation guide
### MATLAB
Installation instruction for MATLAB can be found at https://www.mathworks.com/help/install/install-products.html. Typical install time for MATLAB on a "normal" desktop is around 30-40 minutes. The current codes were developed and tested on MATLAB R2018b.

## Demo
CountryMatrix_Summary generates Figure 2G in the main text; while MapPlots_Quarantine generates the panels for A-F for Figure 2. All mat files to run this script are avaialble. For example, the script TX calcualtes the post-quarantine of transmission for an RT-PCR test on exit.
## Instructions for use
To generate the Figures and output of the calculations, select a script from Figures section to run in MATLAB and enter the name in the command line. All mat file are availble to generate figures and conduct the calculations. To run analysis on a different set of parameters, adjust the parameters in the script and enter the name of the script in the command line to run.

## Scenarios
Incubation_Period_5.72_day- A folder that contains the functions and scripts for the 5.72 day incubation period
Incubation_Period_8.29_day- A folder that contains the functions and scripts for the 8.29 day incubation period
Incubation_Period_11.66_day- A folder that contains the functions and scripts for the 11.66 day incubation period
# Analysis scripts
NoTest- Calculates the post-quarantine transmission (PQT) for no testing.

TX- Calculates the post-quarantine transmission (PQT) for an RT-PCR test on exit.

TXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on exit.

TEXA- Calculates the post-quarantine transmission (PQT) for an rapid anitgen test on entry and exit.

FitPCRCurve- Runs the fitting for the RT-PCR curve

PlotRTPCRFit- Plots the RT-PCR curve and the binned data

Infectivity_Curve_Plot - Plots the infectivity curve

# Analysis functions
ViralShedding_Symptomatic - Infectivity curve for symptomatic individual

ViralShedding_Asymptomatic - Infectivity curve for asymptomatic individual

TestSensitivity- Returns the sensitivity of either RT-PCR or rapid antigen test for the specified time

PCRSens- returns the RT-PCR sensitivity

LR - Logiistic regression model used in determining the percent positve agreement of the rapid antigen test with RT-PCR

LikelihoodPCRCurve - The likelihood function used in fitting the RT-PCR curve

InfectiousnessfromInfectionTesting - Used in determining the extent of post-quarantine transmission when testing is conducted

InfectiousnessfromInfection - Used in determining the extent of post-quarantine transmission when there is NO testing

DistIncubation - Returns the pdf and cdf of the distribution for the incubation period

BaselineParameters - returns the parameters used for the analysis

## Figures and Analysis
CountryMatrix_Sensitivity_Analysis- Conducts the sensitivity analysis for the country-pair analysis

CompareQuarantines- Comapres the quarantine for the country-pair analysis and the teir-based analysis

CountryMatrix-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit

CountryMatrix_Summary-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit (Figure 2G).

CountryMatrix_No_Test-Sufficient quarantine duration for country-pair analysis for no testing

CountryMatrix_Ag_Test-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on exit

CountryMatrix_Dual_Ag_Test-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on entry and exit

CountryMatrix_RTPCR_NatComm-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit for alternative diagnostic senticity curve for the RT-PCR

CountryMatrix_Ag_Test_NatComm-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on exit for alternative diagnostic senticity curve for the RT-PCR

CountryMatrix_Dual_Ag_Test_NatComm-Sufficient quarantine duration for country-pair analysis for a rapid antigen test on entry and exit for alternative diagnostic senticity curve for the RT-PCR

CountryMatrixVOC-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit when considering variants of concern

CountryMatrixVOC_summary-Sufficient quarantine duration for country-pair analysis for an RT-PCR test on exit when considering variants of concern (Generates Figure 4).

Figure_SA_Plot - Generates the panels for the sensitivity analysis

MapPlots_Quarantine-Generates the panels of the maps for specified countries

TrafficLightAnalysis-Sufficient quarantine duration for teir-based analysis for an RT-PCR test on exit

TrafficLightAnalysis_No_Test-Sufficient quarantine duration for teir-based analysis for anot test

TrafficLightAnalysis_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on exit

TrafficLightAnalysis_Dual_Ag_Test-Sufficient quarantine duration for teir-based analysis for a rapid antigen test on entry and exit

## Functions/Scripts
ReadDatatoMAT- Reads data from files to a mat file for the country-pair analysis (reference_hospitalization_all_locs.csv will need to be downloaded from http://www.healthdata.org/covid/data-downloads as the file size was too large to be included in the repository)

CalculateInequalityVOCAll-Calcualtes the values of the ineuality to determine quarantine duration

DetermineQuarantine-Calls CalculateInequalityVOCAll and returns the minimum quanrantine duration.
