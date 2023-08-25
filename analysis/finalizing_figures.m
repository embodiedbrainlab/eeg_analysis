set(gca,'fontweight','bold')
hold on
plot(avg_coh(1,:),'LineWidth',2.0,'Color',[0 0.4470 0.7410]) %fp1
plot(avg_coh(2,:),'LineWidth',2.0, 'Color',[0.8500 0.3250 0.0980]) %fp2
plot(avg_coh(4,:),'LineWidth',2.0,'Color',[0.4940 0.1840 0.5560]) %t3
plot(avg_coh(8,:),'LineWidth',2.0,'Color',[0.25 0.80 0.54]) %t4
plot(avg_coh(3,:),'LineWidth',2.0, 'Color',[0.9290 0.6940 0.1250]) %c3
plot(avg_coh(7,:),'LineWidth',2.0,'Color',[0.6350 0.0780 0.1840]) %c4
plot(avg_coh(5,:),'LineWidth',2.0,'Color',[0.4660 0.6740 0.1880]) %o1
plot(avg_coh(6,:),'LineWidth',2.0,'Color',[0.3010 0.7450 0.9330]) %o2
legend(labels([1 2 4 8 3 7 5 6]))
L = legend;
L.AutoUpdate = 'off';

stdcolormap = [0 0.4470 0.7410; %fp1
    0.8500 0.3250 0.0980; %fp2
    0.9290 0.6940 0.1250; %c3
    0.4940 0.1840 0.5560; %t3
    0.4660 0.6740 0.1880; %o1
    0.3010 0.7450 0.9330; %o2
    0.6350 0.0780 0.1840; %c4
    0.25 0.80 0.54]; %t4

for i = [1 2 4 8 3 7 5 6]
    x = 1:45;
    curve1 = avg_coh(i,:) + sem_coh(i,:);
    curve2 = avg_coh(i,:) - sem_coh(i,:);
    plot(curve1, 'LineStyle','none');
    hold on;
    plot(curve2, 'LineStyle','none');
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    fill(x2, inBetween, stdcolormap(i,:), 'FaceAlpha', 0.5, 'LineStyle','none');
end
fontsize(legend,16,'points')
ylim([0 1])
xlim([4.5 45])
xlabel('Frequency (Hz)','FontSize',16)
ylabel('Average Coherence','FontSize',16)
hold off
set(gcf,'position',[10,10,1100,800])

%% Codes to use to add SEM bars

% stdcolormap = [0 0.4470 0.7410;
%     0.8500 0.3250 0.0980;
%     0.9290 0.6940 0.1250;
%     0.4940 0.1840 0.5560;
%     0.4660 0.6740 0.1880;
%     0.3010 0.7450 0.9330;
%     0.6350 0.0780 0.1840;
%     0.25 0.80 0.54];
% 
% for i = 1:size(coherogram,3)
%     x = 1:45;
%     curve1 = avg_coh(i,:) + sem_coh(i,:);
%     curve2 = avg_coh(i,:) - sem_coh(i,:);
%     plot(curve1, 'LineStyle','none');
%     hold on;
%     plot(curve2, 'LineStyle','none');
%     x2 = [x, fliplr(x)];
%     inBetween = [curve1, fliplr(curve2)];
%     fill(x2, inBetween, stdcolormap(i,:), 'FaceAlpha', 0.5, 'LineStyle','none');
% end
% hold on
% for i = 1:size(coherogram,3)
%     plot(avg_coh(i,:),'Color',stdcolormap(i,:))
% end
% legend(labels,'Location','southwest','NumColumns',2)
% ylim([0 1])
% title('Average coherence across frequencies - Trish and PWD')
% xlabel('Frequencies (Hz)') 
% ylabel('Average Coherence') 