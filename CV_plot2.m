clear; clc; % close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

% T.Properties.VariableNames = {...
%     'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
%     'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
%     'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
%     'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15', 'EVTemp', 'EVHum'};

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

restMask = (T.CycleC == 4) & strcmp(T.Mode, 'R');
restIndices = find(restMask);
gapDiff = diff(restIndices);

blockStart = [restIndices(1); restIndices(find(gapDiff > 1) + 1)];
blockEnd = [restIndices(find(gapDiff > 1 )); restIndices(end)];

firstRest = blockStart(1):blockEnd(1);

someCycle = (T.CycleC == 4) & strcmp(T.Mode, 'C');

voltageCycle = T.Voltage_V(someCycle);
currentCycle = T.Current_A(someCycle);

% Calculating time excluding the inital adjusting period
time = T.TestTime_h(someCycle);
time0 = (time - time(1)) / 60;

% strcmp: string compare
% checkRest = strcmp(T_n.Mode, 'R');
% checkDischarge = strcmp(T_.Mode, 'D');
% checkCharge = strcmp(T_n.Mode, 'C');

% Making sure current has proper sign, program calculates absolute value
% signedCurrent = zeros(height(someCycle), 1);
% signedCurrent(checkCharge) = +.Current_A(checkCharge);
% signedCurrent(checkDischarge) = -T_n.Current_A(checkDischarge);


figure;
plot(time0, voltageCycle, 'b-');
ylabel('Voltage [V]');
hold on;

yyaxis right;
plot(time0, currentCycle, 'r-');
xlabel('Time (hours)');
ylabel('Current [A]');

plot(time0, T.Capacity_Ah(someCycle), 'g-');
xlabel('Time');
grid on;

% figure;
% plot(T.TestTime_h, T.Voltage_V, 'b');
% ylabel('Voltage [V]');
% hold on;
% 
% yyaxis right;
% plot(T.TestTime_h, T.Current_A, 'r');
% xlabel('Time (hours)');
% ylabel('Current [A]');
% hold off;
% grid on;

