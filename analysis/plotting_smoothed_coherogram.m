%% Coherogram Plotting but Smoothed

C4 = coherogram(:,:,25);
figure()
contourf(C4,'linecolor','none')
title('C4')
ylabel('Frequency (Hz)')
xlabel('Time (s)')
xticklabels({'50', '100','150','200','250','300'})
colorbar
clim([0 1])
ylim([3.5 43])