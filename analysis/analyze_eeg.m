function [] = analyze_eeg(main_directory)
    %% Analyzing EEG Data
    % This code is to be run after pre-processing EEG data through EEGLAB
    % The code assumes that the data consists of 32 channels and assesses the
    % data with functions available from the Buzsaki Lab's Buzcode

    % This function also assumes that the directory containing the files
    % you intend to analyze is already set in your path on MATLAB.

    % Noor Tasnim - 8.28.23
    
    activity = ["baseline" "eyegaze" "convo" "follow" "lead" "improv" "wholedata"];
    instructor_variables = ["instructor_baseline" "instructor_eyegaze" "instructor_convo" "instructor_follow" "instructor_lead" "instructor_improv" "instructor_wholedata"];
    participant_variables = ["participant_baseline" "participant_eyegaze" "participant_convo" "participant_follow" "participant_lead" "participant_improv" "participant_wholedata"];
    
    for i = 1:length(activity) %looping pipeline through each activity
        
        basename = bz_BasenameFromBasepath(main_directory); %basename from directory folder
        select_activity = activity(i); %select activity
        load(append(basename,'_',select_activity,'.lfp.mat')); %load .lfp.mat file created from eeglab_formatting.m
    
        %% Creating Instructor Variable
    
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
        
        win = 1;
        
        coherogram = [];
        coh_time = [];
        coh_f = [];
        
        for i = 1:length(labels)
            [coherogram(:,:,i),coh_time,coh_f] = bz_MTCoherogram(instructor.data(:,i),...
                participant.data(:,i),'frequency',500,...
               'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
           colormap default
           colorbar
           ylim([3.5 80])
           title(labels(i))
        end
        
        save([basename '_coherogram.mat'], 'coherogram', 'coh_time', 'coh_f')
        
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
        
        %% Spectrogram Plotting - Instructor
        
        win = 1;
        
        spectrogram_inst = [];
        spec_time_inst = [];
        spec_f_inst = [];
        
        for i = 1:length(labels)
            figure
            [spectrogram_inst(:,:,i),spec_time_inst,spec_f_inst] = MTSpectrogram(instructor.data(:,i),'frequency',500,...
               'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
            colormap default
            colorbar
            clim([0 2])
            title(labels(i))
        end

        save([basename '_instructor_spectrogram.mat'], 'spectrogram_inst', 'spec_time_inst', 'spec_f_inst')
        
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
        
        spectrogram_part = [];
        spec_time_part = [];
        spec_f_part = [];
        
        for i = 1:length(labels)
            figure
            [spectrogram_part(:,:,i),spec_time_part,spec_f_part] = MTSpectrogram(participant.data(:,i),'frequency',500,...
               'range', [1 80], 'window', win, 'tapers',[3 5],'show','on');
            colormap default
            colorbar
            clim([0 2])
           title(labels(i))
        end

        save([basename '_participant_spectrogram.mat'], 'spectrogram_part', 'spec_time_part', 'spec_f_part')
        
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

        %% Clear Variables for Next Loop

        clearvars -except main_directory activity instructor_variables participant_variables 
        
        %% Return to parent directory
        
        cd('..');
    end
clear
end