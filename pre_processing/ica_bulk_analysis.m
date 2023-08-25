
for i = 1:38
    filenames = readtable("files_and_channels.xlsx");
    filename_list = filenames{:,1};
    channels = filenames{:,2};

    file = cell2mat(filename_list(i));
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    EEG = pop_loadset('filename',file,'filepath','C:\\Users\\ntasnim\\Virginia Tech\\Embodied Brain Lab - Documents\\dance_brain_summer22\\ica_analysis\\data\\');
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',0,'interrupt','on','pca',channels(i));
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    pop_topoplot(EEG, 0, [1:channels(i)] ,EEG.setname,[6 6] ,0,'electrodes','on')
    savefig(append(extractstringbeforeEEGchannel(file),'ICA_plot.fig'))
    EEG = pop_saveset(EEG, 'filename',append(extractstringbeforeEEGchannel(file),'ICA.set'),'filepath','C:\\Users\\ntasnim\\Virginia Tech\\Embodied Brain Lab - Documents\\dance_brain_summer22\\ica_analysis\\post_ica\\');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    close all
    clc
    clear
end

%somehow need to find dataset name

%clear and close out at the end of for loop

% [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% EEG = pop_loadset('filename','danc004_post_RR_eegchan_notch_bandpass_interp_reref_ASR_M1_events_replace.set','filepath','C:\\Users\\ntasnim\\Virginia Tech\\Embodied Brain Lab - Documents\\dance_brain_summer22\\DANC004\\danc004_postSD\\files_for_eeglab\\danc004_post_RR\\');
% [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',0,'interrupt','on','pca',25);
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% pop_topoplot(EEG, 0, [1:25] ,'danc004_post_RR_eegchan_notch_bandpass_interp_reref_ASR',[5 5] ,0,'electrodes','on');
% EEG = pop_iclabel(EEG, 'default');
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% EEG = pop_saveset( EEG, 'filename','danc004_post_RR_eegchan_notch_bandpass_interp_reref_ASR_M1_events_replace_ICA.set','filepath','C:\\Users\\ntasnim\\Virginia Tech\\Embodied Brain Lab - Documents\\dance_brain_summer22\\DANC004\\danc004_postSD\\files_for_eeglab\\danc004_post_RR\\');
% [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);