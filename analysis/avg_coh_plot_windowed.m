%% Plotting Windowed Coherence

coherence_data = [f.' (coherogram(:,:,21)).']; % Selecting TP10 for Presentation

% Extract time and coherence data from "coherence_data" array
time_seconds = coherence_data(:, 1);
coherence_values = coherence_data(:, 2:end);

% Define the time window size in seconds
window_size = 5;

% Calculate the number of windows
num_windows = floor(max(time_seconds) / window_size);

% Define the ranges for the specified groups of columns
group1_range = 5:9; % theta
group2_range = 9:13; % alpha
group3_range = 13:31; % beta

% Initialize arrays to store the average coherence values for each window and each group
avg_coherence_group1 = zeros(num_windows, 1);
avg_coherence_group2 = zeros(num_windows, 1);
avg_coherence_group3 = zeros(num_windows, 1);
time_in_windows = zeros(num_windows, 1);

% Calculate the average coherence values in each 5-second window for each group
for i = 1:num_windows
    % Determine the start and end indices for the current window
    start_idx = (i - 1) * window_size + 1;
    end_idx = i * window_size;
    
    % Select data within the current window
    window_data = coherence_values(time_seconds >= start_idx & time_seconds <= end_idx, :);
    
    % Calculate the average coherence value for each group of columns in the current window
    avg_coherence_group1(i) = mean(mean(window_data(:, group1_range)));
    avg_coherence_group2(i) = mean(mean(window_data(:, group2_range)));
    avg_coherence_group3(i) = mean(mean(window_data(:, group3_range)));
    
    % Store the time value in the middle of the window
    time_in_windows(i) = (start_idx + end_idx) / 2;
end

% Display the results
disp('Average Coherence Values over Time in 5-second Windows:');
disp('Time (seconds) | Average Coherence (Group 5 to 9) | Average Coherence (Group 9 to 13) | Average Coherence (Group 13 to 31)');
results = [time_in_windows, avg_coherence_group1, avg_coherence_group2, avg_coherence_group3];
disp(results);

% Plot the results
figure;
plot(time_in_windows, avg_coherence_group1, 'DisplayName', 'Theta');
hold on;
plot(time_in_windows, avg_coherence_group2, 'DisplayName', 'Alpha');
plot(time_in_windows, avg_coherence_group3, 'DisplayName', 'Beta');
xlabel('Time (seconds)');
ylabel('Average Coherence Value');
title('Average Coherence Values over Time in 5-second Windows');
legend('Location', 'southwest');
xlim([0 300])
ylim([0 0.9])
grid on;
