%% cost_ALV_KesterenModel
%
% Syntax:
% ======
% [output]=cost_ALV_KesterenModel(totalYears, operationalYears, 
%      StagesMass, PropMass, EngineMass, payloadMass, TVCstages, hybrid, N, 
%      launchRateYear, fairingLength, fairingVolume,ALV, PEGASUS,PEGASUSXL)
% 
% [output]=cost_ALV_KesterenModel(23,20,[1100 240 30],[900 150 25],[100 50 5],30,
%       [false true true],true,[1 1 1],10,0.7,0.36, true,false,false)
%
%
% Input arguments:
% ===============
%  totalYears        = total project years duration                        [Yr]
%  operationalYears  = operational years duration of the project           [Yr]
%  StagesMass        = vector mass for each stage                          [kg]
%  PropMass          = vector for propellant mass each stage               [kg]
%  EngineMass        = vector for engine masses                            [kg]
%  payloadMass       = total mass for the payload                          [kg]
%  TVCstages         = vector for TVC is present in each one of the stages  [-]
%  hybrid            = true if hybrid engine in upper stage                 [-]
%  N                 = vector for engine qualification firings              [-]
%  launchRateYear    = number of launches by year                           [-]
%  fairingLength     = fairing length                                       [m]
%  fairingVolume     = fairing volume                                     [m^3]
%  ALV               = true if ALV is evaluated                           [-]
%  PEGASUS           = true if PEGASUS is evaluated                         [-]
%  PEGASUSXL         = true if PEGASUSXL is evaluated                       [-]

% Output arguments:
% ================ 
% output = structure.
%   output.development   = development cost in Man Years    [MYr]
%   output.production    = production cost in Man Years     [MYr]
%   output.operations    = operations cost in Man Years     [MYr]
%   output.lifeCycleCost = total LifeCycleCost in Man Years [MYr]
  
%   output.developmentEuros   = development cost in Euros [€]
%   output.productionEuros    = production cost in Euros  [€]
%   output.operationsEuros    = operations cost in Euros  [€]
%   output.lifeCycleCostEuros = total LCC in Euros        [€]

%   output.costPerLaunch      = cost per launch in Euros  [€]
%   output.costPerKg          = cost per kg launched   [€/kg]
%   

%{
--------------------------------------------------------------------------------
Description:
===========
% Determines cost estimation for a launcher system, given several 
% initial characteristics. This preliminary version doesn't account for
% carrier aircraft costs and is not tunned for ALV specifics


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
function [output]=cost_ALV_KesterenModel(totalYears, operationalYears,...
       StagesMass, PropMass, EngineMass, payloadMass, TVCstages, HYBRID, N, ...
       launchYearRate, fairingLength, fairingVolume,ALV, PEGASUS,PEGASUSXL)

 %% DESIGN DECISIONS
 [desDec]  = CostDesignDecisionsKesteren(ALV,PEGASUS, PEGASUSXL);
 
 %% DEVELOPMENT COSTS
 [outDev]  = KesterenDevelopment(desDec,operationalYears, StagesMass,PropMass,TVCstages,...
                      fairingLength,launchYearRate,N,HYBRID);
                  
 %% PRODUCTION COSTS
 [outProd] = KesterenProduction(desDec,operationalYears, ...
                    StagesMass,PropMass,EngineMass,HYBRID,launchYearRate,fairingVolume,ALV);
                
 %% OPERATION COSTS
 [outOps]  = KesterenOperations(desDec,totalYears,operationalYears,StagesMass,...
                    launchYearRate,HYBRID);
                
%%
%% Final calculations

 developmentYears = totalYears - operationalYears;

 countryCorrectionFactor = desDec.o_f8; 

 developmentCostEuros  = (outDev.developmentCost)*1E6*countryCorrectionFactor;
 productionCostEuros   = (outProd.productionCost)*1E6*countryCorrectionFactor;
 operationsCostEuros   = (outOps.operationsCost)*1E6*countryCorrectionFactor;



 developmentCostEurosAmort = developmentCostEuros/ (launchYearRate*operationalYears);
 productionCostEurosAmort = productionCostEuros;
 operationsCostEurosAmort = operationsCostEuros;
 totalAmortEuros = developmentCostEurosAmort + ...
     productionCostEurosAmort + operationsCostEurosAmort;

%Need to take the total amount into account
 productionCostEuros = productionCostEuros * operationalYears * launchYearRate;
 operationsCostEuros = operationsCostEuros * operationalYears * launchYearRate;

%total life cost in M¤ FY 2012
 lifeCycleCostEuros    = developmentCostEuros + ...
    productionCostEuros +  operationsCostEuros;

 costPerLaunchEuros   = lifeCycleCostEuros / (launchYearRate*operationalYears);
 costPerKgEuros       = costPerLaunchEuros / payloadMass;

 costPerKgAmort       = totalAmortEuros/payloadMass;
 %% Output.
 output =... % costs breakdown.
  struct('developmentEuros', developmentCostEuros, 'productionEuros',...
         productionCostEuros,'operationsEuros', operationsCostEuros,...
         'lifeCycleCostEuros', lifeCycleCostEuros,'costPerLaunch', ...
         costPerLaunchEuros,'costPerKg', costPerKgEuros,...
         'developmentEurosAmort', developmentCostEurosAmort, ...
         'productionEurosAmort', productionCostEurosAmort,...
         'operationsEurosAmort', operationsCostEurosAmort,...
         'totalAmort', totalAmortEuros,'costPerKgAmort',costPerKgAmort);

end
