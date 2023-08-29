%% Replacing Bad Segments with Channel Average
% Run this code while EEGLAB window and preferred dataset open

%% Allocating Event Types
% We need to list out all the event types in order to be able to go into
% the "master" event list and pull out the latencies

event_types ={EEG.event.type};

%% Indexing First and Last M1 Markers

m1 = find(ismember(event_types,'M  1')); % lists M1 marker in "event_types"
m1_beg = m1(m1 <= (m1(1) + 20)); % beginning M1 markers' event positions
m1_end = m1(m1 >= (m1(end) - 20)); % ending M1 markers' event positions

m1_beg_first_ind = EEG.event(m1_beg(1)).latency;
m1_beg_last_ind = EEG.event(m1_beg(end)).latency;

m1_end_first_ind = EEG.event(m1_end(1)).latency;
m1_end_last_ind = EEG.event(m1_end(end)).latency;

%% Indexing Comments

baseline_start_ind = EEG.event(find(ismember(event_types,'start_baseline'))).latency;
baseline_end_ind = EEG.event(find(ismember(event_types,'end_baseline'))).latency;

eyegaze_start_ind = EEG.event(find(ismember(event_types,'start_eyegaze'))).latency;
eyegaze_end_ind = EEG.event(find(ismember(event_types,'end_eyegaze'))).latency;

convo_start_ind = EEG.event(find(ismember(event_types,'start_convo'))).latency;
convo_end_ind = EEG.event(find(ismember(event_types,'end_convo'))).latency;

follow_start_ind = EEG.event(find(ismember(event_types,'start_follow'))).latency;
follow_end_ind = EEG.event(find(ismember(event_types,'end_follow'))).latency;

lead_start_ind = EEG.event(find(ismember(event_types,'start_lead'))).latency;
lead_end_ind = EEG.event(find(ismember(event_types,'end_lead'))).latency;

improv_start_ind = EEG.event(find(ismember(event_types,'start_improv'))).latency;
improv_end_ind = EEG.event(find(ismember(event_types,'end_improv'))).latency;

%% Replacing Bad Segments

avg_uV = mean(EEG.data,2); %average microvolt value for each row

%% Segment between Baseline and Eyegaze

for i = 1:32
    EEG.data(i,1:m1_beg_first_ind) = avg_uV(i);
    EEG.data(i,m1_beg_last_ind:baseline_start_ind) = avg_uV(i);
    EEG.data(i,baseline_end_ind:eyegaze_start_ind) = avg_uV(i);
    EEG.data(i,eyegaze_end_ind:convo_start_ind) = avg_uV(i);
    EEG.data(i,convo_end_ind:follow_start_ind) = avg_uV(i);
    EEG.data(i,follow_end_ind:lead_start_ind) = avg_uV(i);
    EEG.data(i,lead_end_ind:improv_start_ind) = avg_uV(i);
    EEG.data(i,improv_end_ind:m1_end_first_ind) = avg_uV(i);
    EEG.data(i,m1_end_last_ind:length(EEG.data)) = avg_uV(i);
end

%% Re-upload transformed data as a new dataset on GUI and then process ICA

[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
eeglab redraw;