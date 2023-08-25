%% Analyzing EEG Data
% This code is to be run after pre-processing EEG data through EEGLAB
% The code assumes that the data consists of 32 channels and assesses the
% data with functions available from the Buzsaki Lab's Buzcode

%% Load compiled .mat file

% basename = bz_BasenameFromBasepath(cd); %basename from directory folder
% load([basename '.lfp.mat']); %load .lfp.mat file created from eeglab_formatting.m
load("with_ASR_wholedata.lfp.mat")
caregiver = caregiver_wholedata; %indicate instructor data
person_with_dementia = pwd_wholedata; %indicate participant data

%% Cropping (when needed)

value_to_decrease = 5;

% caregiver.data = caregiver_cr.data(1:(length(caregiver_cr.data)-value_to_decrease),:);
% caregiver.timestamps = caregiver_cr.timestamps(1:(length(caregiver_cr.timestamps)-value_to_decrease),:);

person_with_dementia.data = pwd_sync.data(1:(length(pwd_sync.data)-value_to_decrease),:);
person_with_dementia.timestamps = pwd_sync.timestamps(1:(length(pwd_sync.timestamps)-value_to_decrease),:);

%% Parameters
Fs = caregiver.samplingRate; %sampling rate
L = length(caregiver.timestamps); %length of dataset

%% FFT

pow1=[];
pow2=[];

for i = 1:size(caregiver.data,2) % loop through each channel
    caregiver.data(:,i) = caregiver.data(:,i) + abs(min(caregiver.data(:,i)));
    y4yay = fft(caregiver.data(:,i)); % run fast foureir transform
    P2 = abs(y4yay/L); % compute the 2 sided spectrum
    P1 = P2(1:L/2+1); % compute the 1 sided spectrum
    P1(2:end-1) = 2*P1(2:end-1); %
    P1 = zscore(P1);
    pow1(:,i) = P1; % to get raw power out
    pow1(:,i) = pow1(:,i)/mean(pow1(:,i)); % mean subtraction
    pow1(:,i) = sgolayfilt(P1, 5, 251); % Smooth fft
end

for i = 1:size(person_with_dementia.data,2)
    person_with_dementia.data(:,i) = person_with_dementia.data(:,i) + abs(min(person_with_dementia.data(:,i)));
    y4yay = fft(person_with_dementia.data(:,i)); % run fast foureir transform
    P2 = abs(y4yay/L); % compute the 2 sided spectrum
    P1 = P2(1:L/2+1); % compute the 1 sided spectrum
    P1(2:end-1) = 2*P1(2:end-1); %
    P1 = zscore(P1);
    pow2(:,i) = P1; % to get raw power out
    pow2(:,i) = pow2(:,i)/mean(pow2(:,i)); % mean subtraction
    pow2(:,i) = sgolayfilt(P1, 5, 251); % smooth fft
end

freqs = [0 Fs*(1:(L/2))/L];% round((Fs*(1:(L/2))/L) + 1);

basename = bz_BasenameFromBasepath(cd);
save([basename '.FFT.mat'], 'pow1', 'pow2', 'freqs')

%% PSD Plotting

[~,xlimInd] = min(abs(freqs - 45));

figure
for i = 1:size(person_with_dementia.data,2)
    subplot(round(sqrt(size(person_with_dementia.data,2))),round(sqrt(size(person_with_dementia.data,2))),i)
    plot(pow1(128:end,i))
    hold on
    plot(pow2(128:end,i))
    xlim([1 xlimInd])
    xticks(1:100:xlimInd)
    xticklabels(round(freqs(1:100:xlimInd)))
    ylim([0 1])
    title(['Channel ' labels{i} ' Frequency Power'])
    ylabel('Power (a.u.)')
    xlabel('Frequency (Hz)')
end
legend('Caregiver','Person with Dementia')

%% Plotting F8 Only

[~,xlimInd] = min(abs(freqs - 100));

figure
% subplot(round(sqrt(size(participant.data,2))),round(sqrt(size(participant.data,2))),i)
plot(pow1(128:end,31))
hold on
plot(pow2(128:end,31))
xlim([1 xlimInd])
xticks(1:2000:xlimInd)
xticklabels(round(freqs(1:2000:xlimInd)))
ylim([0 2.5])
title(['Channel ' labels{31} ' Frequency Power'])
ylabel('Power (a.u.)')
xlabel('Frequency (Hz)')
legend('Instructor','Participant')

%% Coherogram Plotting
% Just take the coherogram output and plot it through contourf instead of
% imagesc. Then when plotting with countourf, try some smoothing.

% Best approach will be to go into buzcode for coherogram and comment out
% the plotting function.

%SYNC WITH GITKRAKEN BEFORE YOU EDIT BUZCODE!

win = 1;

coherogram = [];
time = [];
f = [];

for i = 1:length(labels)
    [coherogram(:,:,i),time,f] = bz_MTCoherogram(caregiver.data(:,i),...
        person_with_dementia.data(:,i),'frequency',500,...
       'range', [1 45], 'window', win, 'tapers',[3 5],'show','on');
   colormap default
   title(labels(i))
end

save([basename '_coherogram.mat'], 'coherogram', 'time', 'f')

%% Coherogram Plotting but Smoothed

% imagesc(Fp1)
% set(gca,'YDir','normal')
F8 = coherogram(:,:,31);
figure()
contourf(F8,'linecolor','none')
title('F8')
ylabel('Frequency (Hz)')
xlabel('Time (s)')
xticklabels({'50', '100','150','200','250','300'})
colorbar
clim([0 1])
ylim([4 80])
%label axes
% Have y axis start from 4
%change x axis values
%color bar - color
%color bar - scale

%% Coherogram Analysis
% Pull out values of coherogram for statistical analysis

for i = 1:size(coherogram,3)
    for r = 1:size(coherogram,1)
    avg_coh(i,r) = mean(coherogram(r,:,i));
    sig_time_s(i,r) = (sum(coherogram(r,:,i) >= 0.8))*0.5;
    end
end

% 32 rows of channels
% 80 columns for frequency
% each cell is average OR time in seconds above significance

%% Next steps

% Use frequency ranges to get values for theta, beta, and gamma
