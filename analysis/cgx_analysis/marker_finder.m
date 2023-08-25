%% Jo Session 1 Markers

trigger = EEG.data(13,:);

for i = 11:19
    marker = find(trigger == 256*i);
    marker_table2(i) = marker(1);
end

marker_table2 = marker_table2.';