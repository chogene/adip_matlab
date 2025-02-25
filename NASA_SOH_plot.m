clc; clear; close all;

% T = readtable('NASA_cycle_dataset_B0005.csv');

load('/home/chogene/matlab/adip/NASA_BatteryAging/battery_data/B0005.mat');

FTime = B0005.cycle(1).data.Time/60;
FreshCell_V = B0005.cycle(1).data.Voltage_measured;
FreshCell_I = B0005.cycle(1).data.Current_measured;
FreshCell_T = B0005.cycle(1).data.Temperature_measured;

aged_num = 606;
ATime =  B0005.cycle(aged_num).data.Time/60;
AgedCell_V = B0005.cycle(aged_num).data.Voltage_measured;
AgedCell_I = B0005.cycle(aged_num).data.Current_measured;
AgedCell_T = B0005.cycle(aged_num).data.Temperature_measured;

figure;
subplot(311);
plot(FTime, FreshCell_V, 'b-', 'linewidth', 2); hold on; plot(ATime, AgedCell_V, 'r--', 'linewidth', 2);
hold off; legend('Fresh Cell - 1st Cycle', 'Aged cell - 606th Cycle'); ylabel('Voltage [V]');
ylim([3.5 4.5]); grid on;

subplot(312);
plot(FTime, FreshCell_I, 'b-', 'linewidth', 2); hold on; plot(ATime, AgedCell_I, 'r--', 'linewidth', 2);
hold off; legend('Fresh Cell - 1st Cycle', 'Aged Cell - 606th Cycle'); ylabel('Current (A)');
grid on;

subplot(313);
plot(FTime, FreshCell_T, 'b-', 'linewidth', 2); hold on; plot(ATime, AgedCell_T, 'r--', 'linewidth', 2);
hold off; legend('Fresh Cell - 1st Cycle', 'Aged Cell - 606th Cycle'); ylabel('Temperature (C)');
grid on;

figure;
subplot(211);
plot(FTime, FreshCell_I, 'r-', 'linewidth', 1.5); hold on; 
xlabel('Time'); ylabel('Capacity');
yyaxis left;
plot(FTime, FreshCell_V, 'b-', 'linewidth', 1.5);
ylabel('Voltage');
hold off; grid on;

subplot(212);
plot(ATime, AgedCell_I, 'r-', 'linewidth', 1.5); hold on; 
xlabel('Time'); ylabel('Capacity');
yyaxis left;
plot(ATime, AgedCell_V, 'b-', 'linewidth', 1.5);
ylabel('Voltage');
hold off; grid on;
