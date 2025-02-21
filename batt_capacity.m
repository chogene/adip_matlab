% Load data
data = readtable('250210_initialcapa_002.txt', 'Delimiter', '\t', 'ReadVariableNames', true);

% Extract columns
time = data.Time;     
current = data.Current;
voltage = data.Voltage;

% Define time and current thresholds
% need to work on
% time_start = [0, 9, 16, 25, 33];  
% time_end = [5, 12, 20, 28, 36]; 
time_start = 9;
time_end = 12;
I_threshold = 5.2; 

% Find indices where time is between 5 and 10 hours
time_idx = (time >= time_start) & (time <= time_end);

% Further filter these indices where current exceeds 5.2A
final_idx = find(time_idx & (current > I_threshold));


% Extract the relevant time and current values
time_filtered = time(final_idx);
current_filtered = current(final_idx);

% Calculate the area under the current-time curve using trapezoidal integration
area_under_curve = trapz(time_filtered, current_filtered)
