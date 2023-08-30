
cd D:\dance_brain_study\dance_brain_final_data\
filelist = dir;

activity = ["baseline" "convo" "eyegaze" "follow" "improv" "lead"];
testing = ["pretest" "posttest"];

for filename = 3:13
    participant_id = filelist(filename).name;
    cd(append("D:\dance_brain_study\dance_brain_final_data\",participant_id))
    for testing_type = 1:2
        if testing(testing_type) == "posttest"
            cd ..\..\
        end
        cd(append(participant_id,"_",testing(testing_type)))
        for activity_type = 1:6
            if activity(activity_type) ~= "baseline"
                cd ..\
            end
            cd(activity(activity_type))
            load(activity(activity_type),"-mat","labels","coherogram") %"spectrogram_inst","spectrogram_part" for later spectrogram analysis
            for channel = 1:size(coherogram,3)
                delta = coherogram(1:4,:,channel);
                delta_avg(channel) = mean(delta,"all");
                delta_sem(channel) = std(delta(:))/sqrt(numel(delta));
                theta = coherogram(4:8,:,channel);
                theta_avg(channel) = mean(theta,"all");
                theta_sem(channel) = std(theta(:))/sqrt(numel(theta));
                alpha = coherogram(8:12,:,channel);
                alpha_avg(channel) = mean(alpha,"all");
                alpha_sem(channel) = std(alpha(:))/sqrt(numel(alpha));
                beta = coherogram(12:30,:,channel);
                beta_avg(channel) = mean(beta,"all");
                beta_sem(channel) = std(beta(:))/sqrt(numel(beta));
                lowgamma = coherogram(30:45,:,channel);
                lowgamma_avg(channel) = mean(lowgamma,"all");
                lowgamma_sem(channel) = std(lowgamma(:))/sqrt(numel(lowgamma));
                higamma = coherogram(45:80,:,channel);
                higamma_avg(channel) = mean(higamma,"all");
                higamma_sem(channel) = std(higamma(:))/sqrt(numel(higamma));
            end
            delta_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("delta",32,1) delta_avg.' delta_sem.'];
            theta_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("theta",32,1) theta_avg.' theta_sem.'];
            alpha_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("alpha",32,1) alpha_avg.' alpha_sem.'];
            beta_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("beta",32,1) beta_avg.' beta_sem.'];
            lowgamma_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("lowgamma",32,1) lowgamma_avg.' lowgamma_sem.'];
            higamma_array = [repmat(participant_id,32,1) repmat(testing(testing_type),32,1) repmat(activity(activity_type),32,1) labels.' repmat("higamma",32,1) higamma_avg.' higamma_sem.'];
            compiled_array = [delta_array; theta_array; alpha_array; beta_array; lowgamma_array; higamma_array];
            writematrix(compiled_array,append("D:\dance_brain_study\final_arrays\",participant_id,"_",testing(testing_type),"_",activity(activity_type),".csv"))
        end
    end
end
