clc;
clear;
close all;

%% Load Caregiver Data
load("pcg003_session12_preprocessed.mat")

%% Convert Times to Seconds
times_s = times/1000;

%% Create Labels

for i = 1:length(chanlocs)
    labels(i) = cellstr(chanlocs(i).labels);
end

%% Create Event Types for indexing
event_types ={event.type};

%% Whole Data PART 1 - Caregiver

avsync_start_ind = 51837;
s2c_end_ind = 115487;

caregiver_wholedata1.data = data(:,avsync_start_ind:s2c_end_ind).';
caregiver_wholedata1.timestamps = (0:0.002:((s2c_end_ind - avsync_start_ind)*2/1000)).';

%% Whole Data PART 2 - Caregiver

close_start_ind = 358984;
avsync_end_ind = 682775;

caregiver_wholedata2.data = data(:,close_start_ind:avsync_end_ind).';
caregiver_wholedata2.timestamps = (0:0.002:((avsync_end_ind - close_start_ind)*2/1000)).';

%% Merged Data - Caregiver

caregiver_wholedata.data = cat(1,caregiver_wholedata1.data,caregiver_wholedata2.data);
caregiver_wholedata.timestamps = (0:0.002:(length(caregiver_wholedata.data)*0.002-0.002)).';
caregiver_wholedata.samplingRate = srate;

%% Load PERSON WITH DEMENTIA Data
load("pwd003_session12_preprocessed.mat")

%% Convert Times to Seconds
times_s = times/1000;

%% Create Event Types for indexing
event_types ={event.type};

%% Whole Data PART 1 - PWD

avsync_start_ind = 45953;
s2c_end_ind = 109603;

pwd_wholedata1.data = data(:,avsync_start_ind:s2c_end_ind).';
pwd_wholedata1.timestamps = (0:0.002:((s2c_end_ind - avsync_start_ind)*2/1000)).';

%% Whole Data PART 2 - PWD

close_start_ind = 353098;
avsync_end_ind = 676888;

pwd_wholedata2.data = data(:,close_start_ind:avsync_end_ind).';
pwd_wholedata2.timestamps = (0:0.002:((avsync_end_ind - close_start_ind)*2/1000)).';

%% Merged Data - PWD

pwd_wholedata.data = cat(1,pwd_wholedata1.data,pwd_wholedata2.data);
pwd_wholedata.timestamps = (0:0.002:(length(pwd_wholedata.data)*0.002-0.002)).';
pwd_wholedata.samplingRate = srate;

%% Load TRISH Data
load("trish_session12_preprocessed.mat")

%% Convert Times to Seconds
times_s = times/1000;

%% Create Event Types for indexing
event_types ={event.type};

%% Whole Data PART 1 - TRISH

avsync_start_ind = 40576;
s2c_end_ind = 104226;

trish_wholedata1.data = data(:,avsync_start_ind:s2c_end_ind).';
trish_wholedata1.timestamps = (0:0.002:((s2c_end_ind - avsync_start_ind)*2/1000)).';

%% Whole Data PART 2 - TRISH

close_start_ind = 337251;
avsync_end_ind = 661042;

trish_wholedata2.data = data(:,close_start_ind:avsync_end_ind).';
trish_wholedata2.timestamps = (0:0.002:((avsync_end_ind - close_start_ind)*2/1000)).';

%% Merged Data - TRISH

trish_wholedata.data = cat(1,trish_wholedata1.data,trish_wholedata2.data);
trish_wholedata.timestamps = (0:0.002:(length(trish_wholedata.data)*0.002-0.002)).';
trish_wholedata.samplingRate = srate;

%% Saving Data

basename = bz_BasenameFromBasepath(cd);
save([basename '_wholedata.lfp.mat'], 'caregiver_wholedata', 'pwd_wholedata', 'trish_wholedata', 'labels');