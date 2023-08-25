%% Working with Accelerometer Data

% Loading Data
acceleration = [double(EEG.data(9,:)); double(EEG.data(10,:)); double(EEG.data(11,:))]; %ACC channels from EEGLAB Data
acc_labels = ["ACC8" "ACC9" "ACC10"]; %Labels for Plot Titles

%% Calculating Acceleration Magnitude

% % set up filter
% % Filter parameters
% sampling_rate = 500; % Sampling rate
% cutoff_frequency = 5; % Cutoff frequency for the low-pass filter
%     
% % Filter accelerometer data
% normalized_cutoff_frequency = cutoff_frequency / (sampling_rate/2);
% [b, a] = butter(4, normalized_cutoff_frequency, 'low'); % 4th-order Butterworth low-pass filter
% filtered_acceleration_x = filtfilt(b, a, acceleration(1,:)); % Zero-phase filtering
% filtered_acceleration_y = filtfilt(b, a, acceleration(2,:));
% filtered_acceleration_z = filtfilt(b, a, acceleration(3,:));
% acc_mag = sqrt((filtered_acceleration_x).^2 + (filtered_acceleration_y).^2);% + (filtered_acceleration_z).^2);

%% Other Code
for i = 1:3
    time = 0:0.002:(length(acceleration)*0.002-0.002); % Time vector
    
    % Filter parameters
    sampling_rate = 500; % Sampling rate
    cutoff_frequency = 10; % Cutoff frequency for the low-pass filter
    
    % Filter accelerometer data
    normalized_cutoff_frequency = cutoff_frequency / (sampling_rate/2);
    [b, a] = butter(4, normalized_cutoff_frequency, 'low'); % 4th-order Butterworth low-pass filter
    filtered_acceleration = filtfilt(b, a, acceleration(i,:)); % Zero-phase filtering

    % Convert Filtered Acceleration from g-unit to m/s^2
    acc_ms2 = (filtered_acceleration/1000)*9.81;

    % Calculate velocity by integrating the filtered acceleration
    velocity = cumtrapz(time, acc_ms2);
    
    % Calculate displacement by integrating velocity
    displacement = cumtrapz(time, velocity);
    
    % Plot original and filtered accelerometer data
    figure;
    subplot(2,1,1);
    plot(time, acceleration(i,:));
    xlabel('Time (s)');
    ylabel(acc_labels(i));
    title(append('Original',' ',acc_labels(i),' ','Data'));
    
    subplot(2,1,2);
    plot(time, filtered_acceleration);
    xlabel('Time (s)');
    ylabel(acc_labels(i));
    title(append('Filtered',' ',acc_labels(i),' ','Data'));
    
    % Plot velocity and displacement AND CONVERTED ACCELEROMETER
    figure;
    subplot(3,1,1)
    plot(time,acc_ms2);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    title(append('Convert Acceleration from Filtered',' ',acc_labels(i),' ','Data'))

    subplot(3,1,2)
    plot(time, velocity);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title(append('Velocity from Filtered',' ',acc_labels(i),' ','Data'));
    
    subplot(3,1,3);
    plot(time,displacement);
    xlabel('Time (s)');
    ylabel('Displacement (m)');
    title(append('Displacement from Calculated Velocity of Filtered',' ',acc_labels(i)));
end
