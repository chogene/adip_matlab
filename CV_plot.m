clear; clc; close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

time = T.TestTime_h; 
current = T.Current_A;
voltage = T.Voltage_V;

% first cycle is always for calibration

ignoreFirstCycle = (T.CycleC == 1);
T(ignoreFirstCycle, :) = [];

% T2 = T(T.CycleC == 3, :);

figure;
plot(time, voltage, 'b');
ylabel("Voltage (V)");
hold on;

yyaxis right;
plot(time, current, 'r');
xlabel("Time (hours)");
ylabel("Current (A)");
grid on;

