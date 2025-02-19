clear; clc; close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

removeFirstCycle = (T.CycleC == 1);
T(removeFirstCycle, :) = [];

T2 = T(T.CycleC == 3, :);
% T3 = T(T.CycleC == 3, :);

checkDischarge = strcmp(T2.Mode, 'D');
checkCharge = strcmp(T2.Mode, 'C');

signedCurrent = zeros(height(T2), 1);
signedCurrent(checkCharge) = +T2.Current_A(checkCharge);
signedCurrent(checkDischarge) = -T2.Current_A(checkDischarge);

nominalCapacity = 10; % [Ah]
initSOC = 0; % [%] 

time_T2 = T2.TestTime_h / 60;

% calculating absolute time?
time0 = time_T2 - time_T2(1);
dt = [0; diff(time0)];

% calculate SOC
SOC = zeros(height(T2), 1);
SOC(1) = initSOC;

for i = 2:height(T2)

figure('Name', '001 CCCV');
yyaxis left;
plot(time_T2, T2.Voltage_V, 'b-');
xlabel('Time');
ylabel('Voltage [V]');
xlim([21.5942 25.66]);
hold on;

yyaxis right;
plot(time_T2, T2.Current_A, 'r');
ylabel('Current [A]');
grid on;

%figure('Name', '001 SOC');
%yyaxis left;
%plot(T.TestTime_h, T.Capacity_Ah, 'b-');
