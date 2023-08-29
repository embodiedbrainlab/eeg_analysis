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