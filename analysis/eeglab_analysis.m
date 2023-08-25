%% Analyzing EEG Data
% This code is to be run after pre-processing EEG data through EEGLAB
% The code assumes that the data consists of 32 channels and assesses the
% data with functions available from the Buzsaki Lab's Buzcode

clc;
clear;
close all;

activity = ["baseline" "eyegaze" "convo" "follow" "lead" "improv" "wholedata"];
instructor_variables = ["instructor_baseline" "instructor_eyegaze" "instructor_convo" "instructor_follow" "instructor_lead" "instructor_improv" "instructor_wholedata"];
participant_variables = ["participant_baseline" "participant_eyegaze" "participant_convo" "participant_follow" "participant_lead" "participant_improv" "participant_wholedata"];

for i = 1:length(activity) %looping pipeline through each activity
    
    basename = bz_BasenameFromBasepath(cd); %basename from directory folder
    select_activity = activity(i); %select activity
    load(append(basename,'_',select_activity,'.lfp.mat')); %load .lfp.mat file created from eeglab_formatting.m

    %% Creating Instructo Variable

    instructor = eval(instructor_variables(i));
    participant = eval(participant_variables(i));
    
    %% Create a folder for activity 
    
    % Create a folder with the name stored in the "activity" variable
    if ~exist(select_activity, 'dir')
        mkdir(select_activity);
    end
    
    % Set the created folder as your working directory
    cd(select_activity);
    
    % Display the current working directory to verify
    disp(['Current working directory: ' pwd]);
    
    %% Cropping Data (if needed)
    
    % Check if "data" lengths are the same in both structures
    if length(instructor.data) == length(participant.data)
        disp('No cropping required. Data lengths are the same.')
    else
        % Determine which structure has longer data
        if length(instructor.data) > length(participant.data)
            longerStruct = 'instructor';
            shorterStruct = 'participant';
        else
            longerStruct = 'participant';
            shorterStruct = 'instructor';
        end
        
        % Calculate how many data points to crop
        numPointsToCrop = abs(length(instructor.data) - length(participant.data));
        
        % Crop the longer structure
        eval(sprintf('%s.data = %s.data(1:end - %d, :);', longerStruct, longerStruct, numPointsToCrop));
        eval(sprintf('%s.timestamps = %s.timestamps(1:end - %d, :);', longerStruct, longerStruct, numPointsToCrop));
        
        % Save the cropping information to a .txt file
        fid = fopen('crop_info.txt', 'wt');
        fprintf(fid, 'The structure %s was cropped by %d data points.\n', longerStruct, numPointsToCrop);
        fclose(fid);
    end
    
    
    %% Parameters
    Fs = instructor.samplingRate; %sampling rate
    L = length(instructor.timestamps); %length of dataset
    
    %% FFT
    
    pow1=[];
    pow2=[];
    
    for i = 1:size(instructor.data,2) % loop through each channel
        instructor.data(:,i) = instructor.data(:,i) + abs(min(instructor.data(:,i)));
        y4yay = fft(instructor.data(:,i)); % run fast foureir transform
        P2 = abs(y4yay/L); % compute the 2 sided spectrum
        P1 = P2(1:L/2+1); % compute the 1 sided spectrum
        P1(2:end-1) = 2*P1(2:end-1); %
        P1 = zscore(P1);
        pow1(:,i) = P1; % to get raw power out
        pow1(:,i) = pow1(:,i)/mean(pow1(:,i)); % mean subtraction
        pow1(:,i) = sgolayfilt(P1, 5, 251); % Smooth fft
    end
    
    for i = 1:size(participant.data,2)
        participant.data(:,i) = participant.data(:,i) + abs(min(participant.data(:,i)));
        y4yay = fft(participant.data(:,i)); % run fast foureir transform
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
    
    [~,xlimInd] = min(abs(freqs - 80));
    
    figure('units','normalized','outerposition',[0 0 1 1])
    for i = 1:size(participant.data,2)
        subplot(round(sqrt(size(participant.data,2))),round(sqrt(size(participant.data,2))),i)
        plot(pow1(128:end,i))
        hold on
        plot(pow2(128:end,i))
        xlim([1 xlimInd])
        xticks(1:2000:xlimInd)
        xticklabels(round(freqs(1:2000:xlimInd)))
        ylim([0 1])
        title(['Channel ' labels{i} ' Frequency Power'])
        ylabel('Power (a.u.)')
        xlabel('Frequency (Hz)')
    end
    legend('Instructor','Participant')
    savefig('normalized_power_for_all_channels.fig')
    close all
    
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
        [coherogram(:,:,i),time,f] = bz_MTCoherogram(instructor.data(:,i),...
            participant.data(:,i),'frequency',500,...
           'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
       colormap default
       colorbar
       ylim([3.5 80])
       title(labels(i))
    end
    
    save([basename '_coherogram.mat'], 'coherogram', 'time', 'f')
    
    % Create a new folder to store all open figures
    folderName = [basename '_coherograms'];
    mkdir(folderName);
    
    % Get the handles of all open figures
    figureHandles = findobj('Type', 'figure');
    
    % Loop through each figure
    for i = 1:numel(figureHandles)
        % Capture the figure as an image
        figureImage = getframe(figureHandles(i));
        imageData = figureImage.cdata;
        
        % Save the image as a .png file in the new folder
        imageName = sprintf('Figure%d.png', i);
        imagePath = fullfile(folderName, imageName);
        imwrite(imageData, imagePath, 'png');
    end
    
    disp('All open figures saved as .png files.');
    disp(['Saved in folder: ' folderName]);
    close all
    
    %% Coherogram Analysis
    
    for i = 1:size(coherogram,3) %looping through channels
        for r = 1:size(coherogram,1) %looping through each frequency
        avg_coh(i,r) = mean(coherogram(r,:,i));
        sem_coh(i,r) = std(coherogram(r,:,i))/sqrt(length(coherogram)); %should be 32x80 double
        end
    end
    
    hold on
    for i = 1:size(coherogram,3)
        plot(avg_coh(i,:))
    end
    legend(labels)
    ylim([0 1])
    title('Average coherence across frequencies')
    xlabel('Frequencies (Hz)') 
    ylabel('Average Coherence')
    hold off
    
    
    for i = 1:size(coherogram,3)
        delta = coherogram(1:4,:,i);
        delta_avg(i) = mean(delta,"all");
        delta_sem(i) = std(delta(:))/sqrt(numel(delta));
        theta = coherogram(4:8,:,i);
        theta_avg(i) = mean(theta,"all");
        theta_sem(i) = std(theta(:))/sqrt(numel(theta));
        alpha = coherogram(8:12,:,i);
        alpha_avg(i) = mean(alpha,"all");
        alpha_sem(i) = std(alpha(:))/sqrt(numel(alpha));
        beta = coherogram(12:30,:,i);
        beta_avg(i) = mean(beta,"all");
        beta_sem(i) = std(beta(:))/sqrt(numel(beta));
        lowgamma = coherogram(30:45,:,i);
        lowgamma_avg(i) = mean(lowgamma,"all");
        lowgamma_sem(i) = std(lowgamma(:))/sqrt(numel(lowgamma));
        higamma = coherogram(45:80,:,i);
        higamma_avg(i) = mean(higamma,"all");
        higamma_sem(i) = std(higamma(:))/sqrt(numel(higamma));
    end
    
    %transpose outputs for R
    delta_avg = delta_avg.';
    delta_sem = delta_sem.';
    theta_avg = theta_avg.';
    theta_sem = theta_sem.';
    alpha_avg = alpha_avg.';
    alpha_sem = alpha_sem.';
    beta_avg = beta_avg.';
    beta_sem = beta_sem.';
    lowgamma_avg = lowgamma_avg.';
    lowgamma_sem = lowgamma_sem.';
    higamma_avg = higamma_avg.';
    higamma_sem = higamma_sem.';
    
    savefig('coherogram_avgs.fig')
    close all
    
    save([basename '_coherogram_analysis.mat'], 'avg_coh', 'sem_coh',...
        'delta_avg', 'delta_sem', 'theta_avg', 'theta_sem', 'alpha_avg', 'alpha_sem',...
        'beta_avg', 'beta_sem','lowgamma_avg', 'lowgamma_sem',...
        'higamma_avg', 'higamma_sem', 'labels');
    
    %% Spectrogram Plotting - Instructor
    
    win = 1;
    
    spectrogram = [];
    time = [];
    f = [];
    
    for i = 1:length(labels)
        figure
        [spectrogram(:,:,i),time,f] = MTSpectrogram(instructor.data(:,i),'frequency',500,...
           'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
        colormap default
        colorbar
        clim([0 2])
        title(labels(i))
    end
    
    % Create a new folder to store all open figures
    folderName = [basename '_instructor_spectrograms'];
    mkdir(folderName);
    
    % Get the handles of all open figures
    figureHandles = findobj('Type', 'figure');
    
    % Loop through each figure
    for i = 1:numel(figureHandles)
        % Capture the figure as an image
        figureImage = getframe(figureHandles(i));
        imageData = figureImage.cdata;
        
        % Save the image as a .png file in the new folder
        imageName = sprintf('Figure%d.png', i);
        imagePath = fullfile(folderName, imageName);
        imwrite(imageData, imagePath, 'png');
    end
    
    disp('All open figures saved as .png files.');
    disp(['Saved in folder: ' folderName]);
    close all
    
    %% Spectrogram Plotting - Participant
    
    win = 1;
    
    spectrogram = [];
    time = [];
    f = [];
    
    for i = 1:length(labels)
        figure
        [spectrogram(:,:,i),time,f] = MTSpectrogram(participant.data(:,i),'frequency',500,...
           'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
        colormap default
        colorbar
        clim([0 2])
       title(labels(i))
    end
    
    % Create a new folder to store all open figures
    folderName = [basename '_participant_spectrograms'];
    mkdir(folderName);
    
    % Get the handles of all open figures
    figureHandles = findobj('Type', 'figure');
    
    % Loop through each figure
    for i = 1:numel(figureHandles)
        % Capture the figure as an image
        figureImage = getframe(figureHandles(i));
        imageData = figureImage.cdata;
        
        % Save the image as a .png file in the new folder
        imageName = sprintf('Figure%d.png', i);
        imagePath = fullfile(folderName, imageName);
        imwrite(imageData, imagePath, 'png');
    end
    
    disp('All open figures saved as .png files.');
    disp(['Saved in folder: ' folderName]);
    close all
    
    %% Save entire workspace
    
    save([basename '.mat']);
    
    %% Return to parent directory
    
    cd('..');
end

%% Coherogram Plotting but Smoothed
% 
% C4 = coherogram(:,:,25);
% figure()
% contourf(C4,'linecolor','none')
% title('C4')
% ylabel('Frequency (Hz)')
% xlabel('Time (s)')
% xticklabels({'50', '100','150','200','250','300'})
% colorbar
% clim([0 1])
% ylim([3.5 43])

%% Next steps

% Use frequency ranges to get values for theta, beta, and gamma
