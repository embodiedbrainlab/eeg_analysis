%% WE NEED TO CORRECT WHOLE DATA SECTIONS OF CODE! WE SHOULD ONLY BE 
%% EXTRACTING DATA BETWEEN RELEVANT M1 MARKERS!
% Use code for replacing chunks of data to find the first and last M1
% markers you need!

%% Formatting EEGLAB Data for Buzcode
% The following code will take complete preprocessed data of both the
% instructor and the participant and create separate .mat files for
% hyperscanning analysiso on Buzcode.

% Note that you must keep both .mat files in a folder named "[pariticipant
% ID]_[pretest/posttest]"

% IMPORTANT: Change lines 22 and 102 each time you run the code to load
% relevant .mat files

clc;
clear;
close all;

%% Load Caregiver Data
load("pcg003_preprocessed_ASR.mat")

%% Convert Times to Seconds
times_s = times/1000;

%% Create Labels

for i = 1:length(chanlocs)
    labels(i) = cellstr(chanlocs(i).labels);
end

%% Create Event Types for indexing
event_types ={event.type};

%% Whole Data - Caregiver
%find the first and last M1 and use similar commands as those below

avsync_start_ind = event(find(ismember(event_types,'av_sync_b1'))).latency;
avsync_end_ind = event(find(ismember(event_types,'av_sync_e5'))).latency;

caregiver_wholedata.data = data(:,avsync_start_ind:avsync_end_ind).';
caregiver_wholedata.timestamps = (0:0.002:((avsync_end_ind - avsync_start_ind)*2/1000)).';
caregiver_wholedata.samplingRate = srate;

%% Hello - Caregiver

hello_start_ind = event(find(ismember(event_types,'hello_start'))).latency;
hello_end_ind = event(find(ismember(event_types,'hello_end'))).latency;

caregiver_hello.data = data(:,hello_start_ind:hello_end_ind).';
caregiver_hello.timestamps = (0:0.002:((hello_end_ind - hello_start_ind)*2/1000)).';
caregiver_hello.samplingRate = srate;


%% Sync - Caregiver

sync_start_ind = event(find(ismember(event_types,'sync_start'))).latency;
sync_end_ind = event(find(ismember(event_types,'sync_end'))).latency;

caregiver_sync.data = data(:,sync_start_ind:sync_end_ind).';
caregiver_sync.timestamps = (0:0.002:((sync_end_ind - sync_start_ind)*2/1000)).';
caregiver_sync.samplingRate = srate;

%% Call/Response

cr_start_ind = event(find(ismember(event_types,'cr_start'))).latency;
cr_end_ind = event(find(ismember(event_types,'cr_end'))).latency;

caregiver_cr.data = data(:,cr_start_ind:cr_end_ind).';
caregiver_cr.timestamps = (0:0.002:((cr_end_ind - cr_start_ind)*2/1000)).';
caregiver_cr.samplingRate = srate;

%% Song to Calm

stc_start_ind = event(find(ismember(event_types,'stc_start'))).latency;
stc_end_ind = event(find(ismember(event_types,'stc_end'))).latency;

caregiver_stc.data = data(:,stc_start_ind:stc_end_ind).';
caregiver_stc.timestamps = (0:0.002:((stc_end_ind - stc_start_ind)*2/1000)).';
caregiver_stc.samplingRate = srate;

%% Shake

shake_start_ind = event(find(ismember(event_types,'shake_start'))).latency;
shake_end_ind = event(find(ismember(event_types,'shake_end'))).latency;

caregiver_shake.data = data(:,shake_start_ind:shake_end_ind).';
caregiver_shake.timestamps = (0:0.002:((shake_end_ind - shake_start_ind)*2/1000)).';
caregiver_shake.samplingRate = srate;

%% Closing Song

closing_start_ind = event(find(ismember(event_types,'closing_start'))).latency;
closing_end_ind = event(find(ismember(event_types,'closing_end'))).latency;

caregiver_closing.data = data(:,closing_start_ind:closing_end_ind).';
caregiver_closing.timestamps = (0:0.002:((closing_end_ind - closing_start_ind)*2/1000)).';
caregiver_closing.samplingRate = srate;

%% Load PERSON WITH DEMENTIA Data
load("pwd003_preprocessed_ASR.mat")

%% Convert Times to Seconds
times_s = times/1000;

%% Create Event Types for indexing
event_types ={event.type};

%% Whole Data - PWD
%find the first and last M1 and use similar commands as those below

avsync_start_ind = event(find(ismember(event_types,'av_sync_b1'))).latency;
avsync_end_ind = event(find(ismember(event_types,'av_sync_e5'))).latency;

pwd_wholedata.data = data(:,avsync_start_ind:avsync_end_ind).';
pwd_wholedata.timestamps = (0:0.002:((avsync_end_ind - avsync_start_ind)*2/1000)).';
pwd_wholedata.samplingRate = srate;

%% Hello - Caregiver

hello_start_ind = event(find(ismember(event_types,'hello_start'))).latency;
hello_end_ind = event(find(ismember(event_types,'hello_end'))).latency;

pwd_hello.data = data(:,hello_start_ind:hello_end_ind).';
pwd_hello.timestamps = (0:0.002:((hello_end_ind - hello_start_ind)*2/1000)).';
pwd_hello.samplingRate = srate;


%% Sync - Caregiver

sync_start_ind = event(find(ismember(event_types,'sync_start'))).latency;
sync_end_ind = event(find(ismember(event_types,'sync_end'))).latency;

pwd_sync.data = data(:,sync_start_ind:sync_end_ind).';
pwd_sync.timestamps = (0:0.002:((sync_end_ind - sync_start_ind)*2/1000)).';
pwd_sync.samplingRate = srate;

%% Call/Response

cr_start_ind = event(find(ismember(event_types,'cr_start'))).latency;
cr_end_ind = event(find(ismember(event_types,'cr_end'))).latency;

pwd_cr.data = data(:,cr_start_ind:cr_end_ind).';
pwd_cr.timestamps = (0:0.002:((cr_end_ind - cr_start_ind)*2/1000)).';
pwd_cr.samplingRate = srate;

%% Song to Calm

stc_start_ind = event(find(ismember(event_types,'stc_start'))).latency;
stc_end_ind = event(find(ismember(event_types,'stc_end'))).latency;

pwd_stc.data = data(:,stc_start_ind:stc_end_ind).';
pwd_stc.timestamps = (0:0.002:((stc_end_ind - stc_start_ind)*2/1000)).';
pwd_stc.samplingRate = srate;

%% Shake

shake_start_ind = event(find(ismember(event_types,'shake_start'))).latency;
shake_end_ind = event(find(ismember(event_types,'shake_end'))).latency;

pwd_shake.data = data(:,shake_start_ind:shake_end_ind).';
pwd_shake.timestamps = (0:0.002:((shake_end_ind - shake_start_ind)*2/1000)).';
pwd_shake.samplingRate = srate;

%% Closing Song

closing_start_ind = event(find(ismember(event_types,'closing_start'))).latency;
closing_end_ind = event(find(ismember(event_types,'closing_end'))).latency;

pwd_closing.data = data(:,closing_start_ind:closing_end_ind).';
pwd_closing.timestamps = (0:0.002:((closing_end_ind - closing_start_ind)*2/1000)).';
pwd_closing.samplingRate = srate;

%% Saving Data
% Ideally we want to tell MATLAB to create a new folder and save the files
% to that folder!

basename = bz_BasenameFromBasepath(cd);
save([basename '_wholedata.lfp.mat'], 'caregiver_wholedata', 'pwd_wholedata', 'labels');
save([basename '_hello.lfp.mat'], 'caregiver_hello', 'pwd_hello', 'labels');
save([basename '_sync.lfp.mat'], 'caregiver_sync', 'pwd_sync', 'labels');
save([basename '_callresponse.lfp.mat'],'caregiver_cr', 'pwd_cr', 'labels');
save([basename '_songtocalm.lfp.mat'], 'caregiver_stc', 'pwd_stc', 'labels');
save([basename '_shake.lfp.mat'], 'caregiver_shake', 'pwd_shake', 'labels');
save([basename '_closingsong.lfp.mat'], 'caregiver_closing', 'pwd_closing', 'labels');
