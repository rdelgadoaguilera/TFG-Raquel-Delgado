%% KesterenDevelopment
%
% Syntax:
% ======
% [output]=KesterenDevelopment(desDec,operationalYears, StagesMass,...
%           PropMass,TVCstages,fairingLength,launchRateYear,N,HYBRID)
%
%
% Input arguments:
% ===============
%  desDec        = struct with correction factors (design decisions)    [-]
%  StagesMass    = vector mass for each stage                          [kg]
%  PropMass      = vector for propellant mass each stage               [kg]
%  TVCstages     = vector for TVC is present in each one of the stages  [-]
%  fairingLength = fairing length                                       [m]
%  HYBRID        = true if hybrid engine in upper stage                 [-]
%  N             = vector for engine qualification firings              [-]

% Output arguments:
% ================ 
% output = structure.
%   output.development   = development cost in Man Years    [MYr]
%   output.production    = production cost in Man Years     [MYr]
%   output.operations    = operations cost in Man Years     [MYr]
%   output.lifeCycleCost = total LifeCycleCost in Man Years [MYr]
  
%   output.developmentEuros   = development cost in Euros []
%   output.productionEuros    = production cost in Euros  []
%   output.operationsEuros    = operations cost in Euros  []
%   output.lifeCycleCostEuros = total LCC in Euros        []

%   output.costPerLaunch      = cost per launch in Euros  []
%   output.costPerKg          = cost per kg launched   [/kg]
%   

%{
--------------------------------------------------------------------------------
Description:
===========
% This function calculates development cost for different launchers.


Acronyms:
========


References:
==========
[1] M. W. VAN KESTEREN. 
    "Air Launch versus Ground Launch: a Multidisciplinary Design Optimization 
    Study of Expendable Launch Vehicles on Cost and Performance". 2013

[2] MARTINO, PAOLO. 
    "Costs and risks analysis tool for conceptual launch vehicle MDO". 2010

--------------------------------------------------------------------------------
Main author:
===========
Raquel Delgado-Aguilera Jurado.

National Institute of Aerospace Technology (INTA)
Madrid, Spain

E-Mail: r.delgadoaguilera@alumnos.urjc.es
--------------------------------------------------------------------------------

%}
%%
function [output] = KesterenDevelopment(desDec,operationalYears, StagesMass,PropMass,TVCstages,...
                      fairingLength,launchRateYear,N,HYBRID)
                  
%% DEVELOPMENT COSTS

 numStages = size(StagesMass,2);

% ****
% CERs
% ****

% Fairing development cost (also contain the DC of the VEB).
 fairingDev = (0.83*fairingLength + 33);
 
% Development cost for small (less than 40.000 kg) solid propellant.
% Kesteren calculates in M€ 2012. So, correlations must be adapted to
% price.

 SolidPropellantDev = 16.8*(PropMass./1000).^0.32;

% If TVC control is present, there is a 15% aumentation in cost.
 for i=1:numStages
     if TVCstages(i)
         SolidPropellantDev(i) = SolidPropellantDev(i)*1.15;
     end
 end

%************
% New CERs for hibrid in third stage. From Martino model.
%************

% I assume pressure fed engine with no turbopumps.
 dryMassThirdStage = StagesMass(3) - PropMass(3);

% Dry mass in liquid/hybrid is not engine mass.
 pressureFedEngineDev = 167*dryMassThirdStage^0.35;
 upperStageSystemDev = 14.2*dryMassThirdStage^0.577;
 
% ****
% Development correction factors
% ****

% Development system engineering correction factor for air launch and 3 stages.
 f0 = desDec.d_f0;

% Development standard factor for winged air launched vehicle.
 f1 = desDec.d_f1;

% Technical quality factor for engines (each one)
 F2Eng = 0.026*log(N).^2;

% Development cost for the carrier aircraft in FY
% Value taken from "Cost Model Validation Data, Appendix H"

 aircraftDev = desDec.aircraftDev;   %These are M� 


 flightDev= (f0*f1*(sum(SolidPropellantDev)+fairingDev)...
                   + aircraftDev)/(launchRateYear*operationalYears);

% Stages development cost.
 stagesDevCost = sum(SolidPropellantDev);

% f10 is 1.05 if hybrid in upper stage.
 f10_3 = desDec.d_f10_3;

 if(HYBRID)
     stagesDevCost=sum(SolidPropellantDev(1:2).*F2Eng(1:2));
     solidUpperDevCost = SolidPropellantDev(3)*F2Eng(3);
     hybridUpperDevCost = pressureFedEngineDev*F2Eng(3) + ...
         upperStageSystemDev*f10_3; 
     stagesDevCost = stagesDevCost + ...
         (solidUpperDevCost + hybridUpperDevCost)/2; %Average for hybrid    
 end

% Total development cost.
 developmentCost = fairingDev + stagesDevCost;
 developmentCost = f0*f1*developmentCost + aircraftDev;
%%

 output = struct('developmentCost',developmentCost,'flightDevCost',flightDev);

end
