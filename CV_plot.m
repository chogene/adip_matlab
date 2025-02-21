clear; clc; close all;

T = readtable('250210_initialcapa_001_totaldata.txt');

T.Properties.VariableNames = {...
    'Rec', 'CycleP', 'CycleC', 'Step', 'TestTime_h', 'StepTime_h', ...
    'Capacity_Ah', 'Energy_Wh', 'Current_A', 'Voltage_V', 'Mode', 'ES', 'DPT_Time', ...
    'VAR1', 'VAR2', 'VAR3', 'VAR4', 'VAR5', 'VAR6', 'VAR7', 'VAR8', 'VAR9', 'VAR10',...
    'VAR11', 'VAR12', 'VAR13', 'VAR14', 'VAR15'};

someCycle = (T.CycleC == 4) & ((T.Step == 5) | (T.Step == 6));
% someCycle = (T.CycleC == 4) & (strcmp(T.Mode, 'C') | strcmp(T.Mode, 'R')); 
% a = (someCycle == testCycle);
voltageCycle = T.Voltage_V(someCycle);
currentCycle = T.Current_A(someCycle);

% Calculating time excluding the inital adjusting period
time = T.TestTime_h(someCycle);
time0 = (time - time(1)) / 60;

% Tolerance
tol = 1e-10;

% Index where V = 42
idx = abs(voltageCycle - 4.2) < tol;
% idx = firstCycle & idx;

time_idx = time0(idx);

if isempty(time_idx)
    fprintf('Nothing found');
else
    t0 = min(time_idx);
    t1 = max(time_idx);
    dt = t1 - t0;

    disp(t0);
    disp(t1);
    disp(dt);
end

trapz(time_idx, T.Current_A(idx))

rangeCV = time0 <= t1;

figure;
plot(time0(rangeCV), voltageCycle(rangeCV), 'b-');
ylabel('Voltage [V]');
hold on;

yyaxis right;
plot(time0(rangeCV), currentCycle(rangeCV), 'r-');
xlabel('Time (hours)');
ylabel('Current [A]');
hold off;
grid on;











