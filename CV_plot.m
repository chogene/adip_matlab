clear; clc; close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

firstCycle = (T.CycleC == 1) & ((T.Step == 5) | (T.Step == 6));

% Calculating time excluding the inital adjusting period
time = T.TestTime_h(firstCycle);
time0 = (time - time(1)) / 60;
% time0 = time_T_n - time_T_n(1);

figure;
plot(time0, T.Voltage_V(firstCycle), 'b');
ylabel('Voltage [V]');
hold on;

yyaxis right;
plot(time0, T.Current_A(firstCycle), 'r');
xlabel('Time (hours)');
ylabel('Current [A]');
hold off;
grid on;

% plot rest
% try using step 
T(firstCycle, :) = [];
time = T.TestTime_h / 60; 
current = T.Current_A;
voltage = T.Voltage_V;


% figure;
% plot(T.TestTime_h(thirdCycle) / 60, T.Voltage_V(thirdCycle), 'b');
% ylabel("Voltage [V]");
% hold on;
% 
% yyaxis right;
% plot(T.TestTime_h(thirdCycle) / 60, T.Current_A(thirdCycle), 'r');
% xlabel("Time [hours]");
% ylabel("Current [A]");
% hold off;
% grid on;

% figure;
% plot(T.TestTime_h(secondCycle) / 60, T.Voltage_V(secondCycle), 'b');
% ylabel("Voltage [V]");
% hold on;
% 
% yyaxis right;
% plot(T.TestTime_h(secondCycle) / 60, T.Current_A(secondCycle), 'r');
% xlabel("Time [hours]");
% ylabel("Current [A]");
% hold off;
% grid on;

