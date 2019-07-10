clear all;close all;clc

porc_varc = 1;

totalYears=23; 
operationalYears=20; 
StagesMass=[1100, 240, 30]; 
PropMass=[900, 150, 25]; 
EngineMass=[100, 50, 5]; 
payloadMass=30; 
TVCstages=[0, 1, 1];
hybrid=false;
N=[1, 1, 1];
launchRateYear=10; 
fairingLength=0.7;
fairingVolume=0.36; 
ALV=true; 
PEGASUS=false;
PEGASUSXL=false;

val_max = 10;
val_min = -10;
val = val_min : porc_varc : val_max; val = val + 100;


for ii=1:1:length(val)
    
    
    C = cost_ALV_KesterenModel(totalYears, operationalYears, StagesMass, PropMass, EngineMass, payloadMass, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    
    C1(ii) = cost_ALV_KesterenModel(totalYears*val(ii)/100, operationalYears, StagesMass, PropMass, EngineMass, payloadMass, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    C2(ii) = cost_ALV_KesterenModel(totalYears, operationalYears*val(ii)/100, StagesMass, PropMass, EngineMass, payloadMass, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    C3(ii) = cost_ALV_KesterenModel(totalYears, operationalYears, StagesMass, PropMass*val(ii)/100, EngineMass, payloadMass, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    C4(ii) = cost_ALV_KesterenModel(totalYears, operationalYears, StagesMass, PropMass, EngineMass*val(ii)/100, payloadMass, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    C5(ii) = cost_ALV_KesterenModel(totalYears, operationalYears, StagesMass, PropMass, EngineMass, payloadMass*val(ii)/100, TVCstages, hybrid, N, launchRateYear, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    C6(ii) = cost_ALV_KesterenModel(totalYears, operationalYears, StagesMass, PropMass, EngineMass, payloadMass, TVCstages, hybrid, N, launchRateYear*val(ii)/100, fairingLength, fairingVolume, ALV, PEGASUS, PEGASUSXL);
    
end

%%

 subplot(1,2,1)

for ii = 1:1:length(val)
    Y1(ii) = C1(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C2(ii).costPerKg       * 100 /  C.costPerKg;
    Y3(ii) = C3(ii).costPerKg       * 100 /  C.costPerKg;
    Y4(ii) = C4(ii).costPerKg       * 100 /  C.costPerKg;
    Y5(ii) = C5(ii).costPerKg       * 100 /  C.costPerKg;
    Y6(ii) = C6(ii).costPerKg       * 100 /  C.costPerKg;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );
      
    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste por Kg')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
    
    
    subplot(1,2,2)

for ii = 1:1:length(val)
    Y1(ii) = C1(ii).costPerLaunch       * 100 /  C.costPerLaunch;
    Y2(ii) = C2(ii).costPerLaunch       * 100 /  C.costPerLaunch;
    Y3(ii) = C3(ii).costPerLaunch       * 100 /  C.costPerLaunch;
    Y4(ii) = C4(ii).costPerLaunch       * 100 /  C.costPerLaunch;
    Y5(ii) = C5(ii).costPerLaunch       * 100 /  C.costPerLaunch;
    Y6(ii) = C6(ii).costPerLaunch       * 100 /  C.costPerLaunch;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );

    set(gca, 'fontsize', 20) 
      
    ylabel('Variación % de Coste por Lanzamiento')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
    figure;
    

    subplot(1,2,1)

for ii = 1:1:length(val)
    Y1(ii) = C1(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
    Y2(ii) = C2(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
    Y3(ii) = C3(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
    Y4(ii) = C4(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
    Y5(ii) = C5(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
    Y6(ii) = C6(ii).lifeCycleCostEuros       * 100 /  C.lifeCycleCostEuros;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-' ,'linewidth',2);
 
    set(gca, 'fontsize', 20) 
      
    ylabel('Variación % de Coste de Ciclo de Vida')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')
    
    hold off 
  
    
    subplot(1,2,2)

for ii = 1:1:length(val)
    Y1(ii) = C1(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y2(ii) = C2(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y3(ii) = C3(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y4(ii) = C4(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C5(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y6(ii) = C6(ii).developmentEuros       * 100 /  C.developmentEuros;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );

    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste de Desarrollo')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off
    figure;
    
    subplot(1,2,1)
    
    for ii = 1:1:length(val)
    Y1(ii) = C1(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
    Y2(ii) = C2(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
    Y3(ii) = C3(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
    Y4(ii) = C4(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
    Y5(ii) = C5(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
    Y6(ii) = C6(ii).developmentEurosAmort       * 100 /  C.developmentEurosAmort;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-' ,'linewidth',2);

    set(gca, 'fontsize', 20) 
      
    ylabel('Variación % de Coste de Desarrollo Amortizado')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
    
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')
  
    
    
    subplot(1,2,2)

for ii = 1:1:length(val)
    Y1(ii) = C1(ii).operationsEuros       * 100 /  C.operationsEuros;
    Y2(ii) = C2(ii).operationsEuros       * 100 /  C.operationsEuros;
    Y3(ii) = C3(ii).operationsEuros       * 100 /  C.operationsEuros;
    Y4(ii) = C4(ii).operationsEuros       * 100 /  C.operationsEuros;
    Y5(ii) = C5(ii).operationsEuros       * 100 /  C.operationsEuros;
    Y6(ii) = C6(ii).operationsEuros       * 100 /  C.operationsEuros;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-' ,'linewidth',2);

    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste Operacional')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
    figure;
    
    
    subplot(1,2,1)
    
    for ii = 1:1:length(val)
    Y1(ii) = C1(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
    Y2(ii) = C2(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
    Y3(ii) = C3(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
    Y4(ii) = C4(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
    Y5(ii) = C5(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
    Y6(ii) = C6(ii).operationsEurosAmort       * 100 /  C.operationsEurosAmort;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );

    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste de Operación Amortizado')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 

    
    subplot(1,2,2)
    
    for ii = 1:1:length(val)
    Y1(ii) = C1(ii).productionEuros       * 100 /  C.productionEuros;
    Y2(ii) = C2(ii).productionEuros       * 100 /  C.productionEuros;
    Y3(ii) = C3(ii).productionEuros       * 100 /  C.productionEuros;
    Y4(ii) = C4(ii).productionEuros       * 100 /  C.productionEuros;
    Y5(ii) = C5(ii).productionEuros       * 100 /  C.productionEuros;
    Y6(ii) = C6(ii).productionEuros       * 100 /  C.productionEuros;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );

    set(gca, 'fontsize', 20) 
      
    ylabel('Variación % de Coste de Producción')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
    figure;
    
    subplot(1,2,1)
    
    for ii = 1:1:length(val)
    Y1(ii) = C1(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
    Y2(ii) = C2(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
    Y3(ii) = C3(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
    Y4(ii) = C4(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
    Y5(ii) = C5(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
    Y6(ii) = C6(ii).productionEurosAmort       * 100 /  C.productionEurosAmort;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );
      
    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste de Producción Amortizado')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 
 
    
    subplot(1,2,2)
    
    for ii = 1:1:length(val)
    Y1(ii) = C1(ii).totalAmort       * 100 /  C.totalAmort;
    Y2(ii) = C2(ii).totalAmort       * 100 /  C.totalAmort;
    Y3(ii) = C3(ii).totalAmort       * 100 /  C.totalAmort;
    Y4(ii) = C4(ii).totalAmort       * 100 /  C.totalAmort;
    Y5(ii) = C5(ii).totalAmort       * 100 /  C.totalAmort;
    Y6(ii) = C6(ii).totalAmort       * 100 /  C.totalAmort;
end

    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-','linewidth',2 );
      
    set(gca, 'fontsize', 20) 
    
    ylabel('Variación % de Coste Total Amortizado')
    xlabel('Variación % de Variables')
    legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')

    hold off 

legend({'Años Totales', 'Años Operacionales', 'Masa de Propulsante', 'Masa de Motores', 'Masa de Carga de Pago', 'Tasa Anual de Lanzamiento'}, 'Location', 'bestoutside')
figure;
%------------------------------------------------------------

%%

subplot(1,2,1)

Y1 = zeros(size(val));
Y2 = zeros(size(val));
Y3 = zeros(size(val));
Y4 = zeros(size(val));
Y5 = zeros(size(val));
Y6 = zeros(size(val));
Y7 = zeros(size(val));
Y8 = zeros(size(val));
Y9 = zeros(size(val));
Y10 = zeros(size(val));
Y11 = zeros(size(val));


for ii = 1:length(C1)
    Y1(ii) = C1(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C1(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C1(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C1(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C1(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C1(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C1(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C1(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C1(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C1(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C1(ii).totalAmort   * 100 /  C.totalAmort;
end

    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:' ,'linewidth',2);
    
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Años Totales')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    
    subplot(1,2,2)

for ii = 1:length(C2)
    Y1(ii) = C2(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C2(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C2(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C2(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C2(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C2(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C2(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C2(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C2(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C2(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C2(ii).totalAmort   * 100 /  C.totalAmort;
end

    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:','linewidth',2 );
      
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Años Operacionales')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    figure;

    subplot(1,2,1)

for ii = 1:length(C3)
    Y1(ii) = C3(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C3(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C3(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C3(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C3(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C3(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C3(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C3(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C3(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C3(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C3(ii).totalAmort   * 100 /  C.totalAmort;
end

    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:','linewidth',2 );
      
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Masa de Propulsante')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    
    subplot(1,2,2)

for ii = 1:length(C4)
    Y1(ii) = C4(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C4(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C4(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C4(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C4(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C4(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C4(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C4(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C4(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C4(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C4(ii).totalAmort   * 100 /  C.totalAmort;
end
    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:' ,'linewidth',2);
      
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Masa de Motores')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    figure;
    
    subplot(1,2,1)
    
for ii = 1:length(C5)
    Y1(ii) = C5(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C5(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C5(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C5(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C5(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C5(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C5(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C5(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C5(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C5(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C5(ii).totalAmort   * 100 /  C.totalAmort;
end

    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:' ,'linewidth',2);
      
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Carga de Pago')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    
    subplot(1,2,2)
    
for ii = 1:length(C6)
    Y1(ii) = C6(ii).costPerKg       * 100 /  C.costPerKg;
    Y2(ii) = C6(ii).costPerKgAmort  * 100 /  C.costPerKgAmort;
    Y3(ii) = C6(ii).costPerLaunch   * 100 /  C.costPerLaunch;
    Y4(ii) = C6(ii).developmentEuros       * 100 /  C.developmentEuros;
    Y5(ii) = C6(ii).developmentEurosAmort   * 100 /  C.developmentEurosAmort;
    Y6(ii) = C6(ii).lifeCycleCostEuros  * 100 /  C.lifeCycleCostEuros;
    Y7(ii) = C6(ii).operationsEuros   * 100 /  C.operationsEuros;
    Y8(ii) = C6(ii).operationsEurosAmort   * 100 /  C.operationsEurosAmort;
    Y9(ii) = C6(ii).productionEuros       * 100 /  C.productionEuros;
    Y10(ii) = C6(ii).productionEurosAmort  * 100 /  C.productionEurosAmort;
    Y11(ii) = C6(ii).totalAmort   * 100 /  C.totalAmort;
end

    
    hold on
    plot( val, Y1,        ...
          val, Y2, 'c-',  ...
          val, Y3, 'm-',   ...
          val, Y4, 'y-',   ...
          val, Y5, 'r-',  ...
          val, Y6, 'g-',   ...
          val, Y7, 'b-',   ...
          val, Y8, 'b--',  ...
          val, Y9, 'k-',   ... 
          val, Y10, 'r--',  ...
          val, Y11, 'm:' ,'linewidth',2);
      
    set(gca, 'fontsize', 17) 
      
    xlabel('Variación % de Tasa Anual de Lanzamientos')
    ylabel('Variación % de Costes')
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')

    hold off 
    
    legend({'Coste por Kg', 'Coste por Kg Amortizado', 'Coste por Lanzamiento', 'Coste de Desarrollo', 'Coste de Desarrollo Amortizado', 'Coste por Ciclo de Vida', 'Coste Operacional', 'Coste Operacional Amortizado', 'Coste de Producción', 'Coste de Producción Amortizado', 'Coste Total Amortizado'}, 'Location', 'bestoutside')
    
