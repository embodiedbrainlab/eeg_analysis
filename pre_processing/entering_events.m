%% Entering Events

%% Comment Names

comments = ["start_baseline",...
    "end_baseline",...
    "start_eyegaze",...
    "end_eyegaze",...
    "start_convo",...
    "end_convo",...
    "start_follow",...
    "end_follow",...
    "start_lead",...
    "end_lead",...
    "start_improv",...
    "end_improv"];

values = [500,... %start_baseline
    1000,... %end_baseline
    1500,... %start_eyegaze
    2000,... %end_eyegaze
    2500,... %start_convo
    3000,... %end_convo
    3500,... %start_follow
    4000,... %end_follow
    4500,... %start_lead
    5000,... %end_lead
    5500,... %start_improv
    6000]; %end_improv

for i = 1:length(comments)
    newEvent = struct();
    newEvent.latency = values(i);
    newEvent.duration = 1;
    newEvent.channel = 0;
    newEvent.bvtime = [];
    newEvent.bvmknum = NaN;
    newEvent.visible = [];
    newEvent.type = comments(i);
    newEvent.code = 'Comment';
    newEvent.urevent = NaN;
    EEG.event = [EEG.event, newEvent];
end
