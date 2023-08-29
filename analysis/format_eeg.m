%% Formatting EEGLAB Data for Analysis
% The following code will take complete preprocessed data of both the
% instructor and the participant and create separate .mat files for
% hyperscanning analysiso on Buzcode.

% Note that you must keep both .mat files in a folder named "[pariticipant
% ID]_[pretest/posttest]"

%% Load INSTRUCTOR Data

load("danc001_post_RR.mat") %input instructor .mat file here

%% Convert Times to Seconds
times_s = times/1000;

%% Create Labels

for i = 1:length(chanlocs)
    labels(i) = cellstr(chanlocs(i).labels);
end

%% Create Event Types for indexing
event_types ={event.type};

%% Baseline - INSTRUCTOR

baseline_start_ind = event(find(ismember(event_types,'start_baseline'))).latency;
baseline_end_ind = event(find(ismember(event_types,'end_baseline'))).latency;

instructor_baseline.data = data(:,baseline_start_ind:baseline_end_ind).';
instructor_baseline.timestamps = (0:0.002:((baseline_end_ind - baseline_start_ind)*2/1000)).';
instructor_baseline.samplingRate = srate; %usally 500 on the .mat file

%% Eyegaze - INSTRUCTOR

eyegaze_start_ind = event(find(ismember(event_types,'start_eyegaze'))).latency;
eyegaze_end_ind = event(find(ismember(event_types,'end_eyegaze'))).latency;

instructor_eyegaze.data = data(:,eyegaze_start_ind:eyegaze_end_ind).';
instructor_eyegaze.timestamps = (0:0.002:((eyegaze_end_ind - eyegaze_start_ind)*2/1000)).';
instructor_eyegaze.samplingRate = srate; %usally 500 on the .mat file

%% Conversation - INSTRUCTOR

convo_start_ind = event(find(ismember(event_types,'start_convo'))).latency;
convo_end_ind = event(find(ismember(event_types,'end_convo'))).latency;

instructor_convo.data = data(:,convo_start_ind:convo_end_ind).';
instructor_convo.timestamps = (0:0.002:((convo_end_ind - convo_start_ind)*2/1000)).';
instructor_convo.samplingRate = srate; %usally 500 on the .mat file

%% Following - INSTRUCTOR

follow_start_ind = event(find(ismember(event_types,'start_follow'))).latency;
follow_end_ind = event(find(ismember(event_types,'end_follow'))).latency;

instructor_follow.data = data(:,follow_start_ind:follow_end_ind).';
instructor_follow.timestamps = (0:0.002:((follow_end_ind - follow_start_ind)*2/1000)).';
instructor_follow.samplingRate = srate; %usally 500 on the .mat file

%% Leading - INSTRUCTOR

lead_start_ind = event(find(ismember(event_types,'start_lead'))).latency;
lead_end_ind = event(find(ismember(event_types,'end_lead'))).latency;

instructor_lead.data = data(:,lead_start_ind:lead_end_ind).';
instructor_lead.timestamps = (0:0.002:((lead_end_ind - lead_start_ind)*2/1000)).';
instructor_lead.samplingRate = srate; %usally 500 on the .mat file

%% Improv - INSTRUCTOR

improv_start_ind = event(find(ismember(event_types,'start_improv'))).latency;
improv_end_ind = event(find(ismember(event_types,'end_improv'))).latency;

instructor_improv.data = data(:,improv_start_ind:improv_end_ind).';
instructor_improv.timestamps = (0:0.002:((improv_end_ind - improv_start_ind)*2/1000)).';
instructor_improv.samplingRate = srate; %usally 500 on the .mat file

%% Whole Data - Instructor
% We can assume that the whole data is now lined up between "Start
% Basline" and "End Improv" because they were manually calculated based
% on the M1 markers that were collected during recording.

instructor_wholedata.data = data(:,baseline_start_ind:improv_end_ind).';
instructor_wholedata.timestamps = (0:0.002:((improv_end_ind - baseline_start_ind)*2/1000)).';
instructor_wholedata.samplingRate = srate;

%% Load PARTICIPANT Data

load("danc001_post.mat") %input participant file name here

%% Convert Times to Seconds
times_s = times/1000;

%% Create Event Types for indexing
event_types ={event.type};

%% Baseline - PARTICIPANT

baseline_start_ind = event(find(ismember(event_types,'start_baseline'))).latency;
baseline_end_ind = event(find(ismember(event_types,'end_baseline'))).latency;

participant_baseline.data = data(:,baseline_start_ind:baseline_end_ind).';
participant_baseline.timestamps = (0:0.002:((baseline_end_ind - baseline_start_ind)*2/1000)).';
participant_baseline.samplingRate = srate; %usally 500 on the .mat file

%% Eyegaze - PARTICIPANT

eyegaze_start_ind = event(find(ismember(event_types,'start_eyegaze'))).latency;
eyegaze_end_ind = event(find(ismember(event_types,'end_eyegaze'))).latency;

participant_eyegaze.data = data(:,eyegaze_start_ind:eyegaze_end_ind).';
participant_eyegaze.timestamps = (0:0.002:((eyegaze_end_ind - eyegaze_start_ind)*2/1000)).';
participant_eyegaze.samplingRate = srate; %usally 500 on the .mat file

%% Conversation - PARTICIPANT

convo_start_ind = event(find(ismember(event_types,'start_convo'))).latency;
convo_end_ind = event(find(ismember(event_types,'end_convo'))).latency;

participant_convo.data = data(:,convo_start_ind:convo_end_ind).';
participant_convo.timestamps = (0:0.002:((convo_end_ind - convo_start_ind)*2/1000)).';
participant_convo.samplingRate = srate; %usally 500 on the .mat file

%% Following - PARTICIPANT

follow_start_ind = event(find(ismember(event_types,'start_follow'))).latency;
follow_end_ind = event(find(ismember(event_types,'end_follow'))).latency;

participant_follow.data = data(:,follow_start_ind:follow_end_ind).';
participant_follow.timestamps = (0:0.002:((follow_end_ind - follow_start_ind)*2/1000)).';
participant_follow.samplingRate = srate; %usally 500 on the .mat file

%% Leading - PARTICIPANT

lead_start_ind = event(find(ismember(event_types,'start_lead'))).latency;
lead_end_ind = event(find(ismember(event_types,'end_lead'))).latency;

participant_lead.data = data(:,lead_start_ind:lead_end_ind).';
participant_lead.timestamps = (0:0.002:((lead_end_ind - lead_start_ind)*2/1000)).';
participant_lead.samplingRate = srate; %usally 500 on the .mat file

%% Improv - PARTICIPANT

improv_start_ind = event(find(ismember(event_types,'start_improv'))).latency;
improv_end_ind = event(find(ismember(event_types,'end_improv'))).latency;

participant_improv.data = data(:,improv_start_ind:improv_end_ind).';
participant_improv.timestamps = (0:0.002:((improv_end_ind - improv_start_ind)*2/1000)).';
participant_improv.samplingRate = srate; %usally 500 on the .mat file

%% Whole Data - PARTICIPANT

participant_wholedata.data = data(:,baseline_start_ind:improv_end_ind).';
participant_wholedata.timestamps = (0:0.002:((improv_end_ind - baseline_start_ind)*2/1000)).';
participant_wholedata.samplingRate = srate;

%% Get basename

basename = bz_BasenameFromBasepath(cd);

%% Saving Data
% Ideally we want to tell MATLAB to create a new folder and save the files
% to that folder!

save([basename '_wholedata.lfp.mat'], 'instructor_wholedata', 'participant_wholedata', 'labels');
save([basename '_baseline.lfp.mat'], 'instructor_baseline', 'participant_baseline', 'labels');
save([basename '_eyegaze.lfp.mat'], 'instructor_eyegaze', 'participant_eyegaze', 'labels');
save([basename '_convo.lfp.mat'],'instructor_convo', 'participant_convo', 'labels');
save([basename '_follow.lfp.mat'], 'instructor_follow', 'participant_follow', 'labels');
save([basename '_lead.lfp.mat'], 'instructor_lead', 'participant_lead', 'labels');
save([basename '_improv.lfp.mat'], 'instructor_improv', 'participant_improv', 'labels');
