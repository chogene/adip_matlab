clear; clc; % close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

% First cycle is for adjusting the battery
ignoreFirstCycle= (T.CycleC == 1);
T(ignoreFirstCycle, :) = [];

% Need to add function to check through all loops
% Checking SOC of cycle n
T_n = T(T.CycleC == 4, :);

% strcmp: string compare
% checkRest = strcmp(T_n.Mode, 'R');
checkDischarge = strcmp(T_n.Mode, 'D');
checkCharge = strcmp(T_n.Mode, 'C');

% Making sure current has proper sign, program calculates absolute value
signedCurrent = zeros(height(T_n), 1);
signedCurrent(checkCharge) = +T_n.Current_A(checkCharge);
signedCurrent(checkDischarge) = -T_n.Current_A(checkDischarge);

% Battery specifications 
nominalCapacity = 9.90277; % [Ah] 
% Average capacity [Ah] for the final three cycles bc first is obviously ignored 
% and the second cylce isn't considered since it's assumed that it is "unstable" and doesn't represent the physical state of the battery
% The battery fluctuates because of overpotential and chemical stuff.
initSOC = 99.999999; % [%] 

% Resetting time to start at cycle loop 
time_T_n = T_n.TestTime_h / 60;

% Time starts at cycle
time0 = time_T_n - time_T_n(1);

% Timestep
dt = [0; diff(time0)];

% Calculate SOC
SOC = zeros(height(T_n), 1);
SOC(1) = initSOC;

for i = 2:height(T_n)
    dQ = signedCurrent(i) * (dt(i));
    dSOC = (dQ / nominalCapacity) * 100;
    SOC(i) = SOC(i-1) + dSOC;
end

% figure('Name', '001 Cycle 4', 'NumberTitle', 'off');
% plot(time0, T_n.Voltage_V, 'b');
% ylabel('Voltage [V]');
% hold on;
% 
% yyaxis right;
% plot(time0, T_n.Current_A, 'r');
% xlabel('Time (hours)');
% ylabel('Current [A]');
% hold off;
% grid on;

voltage_charge = T_n.Voltage_V(checkCharge) + 0.0045;
voltage_discharge = T_n.Voltage_V(checkDischarge) - 0.0045;

figure('Name', '001 SOC', 'NumberTitle', 'off');
hold on;
grid on;

plot(SOC(checkCharge), voltage_charge, 'r-');
plot(SOC(checkDischarge), voltage_discharge, 'b-');

xlabel('SOC [%]');
ylabel('Voltage [V]');
xlim([0 100]);

legend('Charge', 'Discharge');

