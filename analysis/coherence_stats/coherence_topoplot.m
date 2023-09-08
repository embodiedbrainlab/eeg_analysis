%% Topographic plot
% Load Mean Data
%mean_data is a 32x6 double
%average for each channel across the 6 frequency bands should be fine
%with each channel being a row

load('EEGchanlocs.mat')

%load from topoplot/data
filepath = "D:\dance_brain_study\coherence_stats_analysis\topoplot\topoplot_data\dance_posttest_avgs.csv";
mean_data = readmatrix(filepath);
mean_data = mean_data(:,2:7); %removes column containing channel names
freq_band_labels = ["Delta (1-4 Hz)" "Theta (4-8 Hz)" "Alpha (8-12 Hz)" "Beta (12-30 Hz)"...
    "Low Gamma (30-45 Hz)" "High Gamma (45-80 Hz)"];

% Plot the scalp map series
figure
for k = 1:6
    sbplot(2,3,k);
    % A more flexible version of subplot
    topoplot(mean_data(:,k), channellocations, 'maplimits', [0 1], 'electrodes', 'on', 'style', 'both', ...
        'numcontour',0);
    title(freq_band_labels(k)); % frequency band titles
end
cbar; % 