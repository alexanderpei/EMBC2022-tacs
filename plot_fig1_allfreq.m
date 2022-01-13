%%

clear all
close all

load ftdata_freq_small_1
load ftdata_conn_small_1

nPerm = 100;
alpha = 0.01;
%%

fig = figure;
fig.Position = [944 74 834 1252];

acs = 0:0.5:20;

subplot(2,1,1)
box on
grid on
hold on

for i = 1:length(acs)

    cfg = [];
    cfg.trials = freq.trialinfo == 1;
    cfg.channel = 1;
    cfg.frequency =  [0 20];
    freq1 = ft_selectdata(cfg, freq);

    cfg = [];
    cfg.trials = freq.trialinfo == i;
    cfg.channel = 1;
    cfg.frequency =  [0 20];
    freq2 = ft_selectdata(cfg, freq);

    [t, allT, idxClust] = fn_cluster_perm(freq1, freq2, nPerm, alpha);

    stat(i).tPow = t;
    stat(i).allTPow = allT;
    stat(i).idxClustPow = idxClust;
    
    plot3(freq1.freq, ones([1 length(freq1.freq)])*i/2, squeeze(mean(freq2.powspctrm(:, 1, :))), 'k')

end

for i = 1:length(acs)
    
    temp = stat(i).idxClustPow;
    pVal = sum(stat(i).tPow > stat(i).allTPow)/nPerm;
    if pVal < 0.05
        color = 'r';
        plot3(freq1.freq(temp), ones([1 length(temp)])*i/2, zeros(1,length(temp)), color, 'LineWidth',3)
    else
        color = 'b';
    end
    
end


ax = gca;
ax.FontSize = 16;
ax.LineWidth = 2;
ax.CameraPosition = [160.6161 -100.0337 0.0159];
xlim([0 20])
xlabel('Frequency (Hz)')
ylabel('Stim. Frequency (Hz)')
zlabel('Power')
yticks([0 10 20])
yticklabels({'0', '10', '20'})
xticks([0 10 20])
xticklabels({'0', '10', '20'})
subplot(2,1,2)

box on 
grid on
hold on

for i = 1:length(acs)

    cfg = [];
    cfg.trials = freq.trialinfo == 1;
%     cfg.channel = 1:2;
    cfg.frequency =  [0 20];

    freq1 = ft_selectdata(cfg, freq);
%     freq1.crsspctrm = freq1.crsspctrm(:, 1:2, :);
%     freq1.labelcmb = freq1.labelcmb(1, :);

    cfg = [];
    cfg.trials = freq.trialinfo == i;
%     cfg.channel = 1:2;
    cfg.frequency =  [0 20];

    freq2 = ft_selectdata(cfg, freq);
%     freq2.crsspctrm = freq2.crsspctrm(:, 1:2, :);

    cfg = [];
    cfg.method = 'coh';
    cfg.complex = 'imag';

    coh1 = ft_connectivityanalysis(cfg, freq1);
    coh2 = ft_connectivityanalysis(cfg, freq2);

    [t, allT, idxClust] = fn_cluster_perm_coh(coh1, coh2, freq1, freq2, nPerm, alpha, cfg);

    stat(i).tCoh = t;
    stat(i).allTCoh = allT;
    stat(i).idxClustCoh = idxClust;

    plot3(freq1.freq, ones([1 length(freq1.freq)])*i/2, coh2.cohspctrm(1,:), 'k')

end

for i = 1:length(acs)
    
    temp = stat(i).idxClustCoh;
    pVal = sum(stat(i).tCoh < stat(i).allTCoh)/nPerm;
    if pVal < 0.05
        color = 'r';
        plot3(freq.freq(temp), ones([1 length(temp)])*i/2, zeros(1,length(temp)), color, 'LineWidth',3)
    else
        color = 'b';
    end
    
end

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 2;
ax.CameraPosition = [143.8193  -89.4032    4.4004];
xlim([0 20])
xlabel('Frequency (Hz)')
ylabel('Stim. Frequency (Hz)')
zlabel('Coherence')
yticks([0 10 20])
yticklabels({'0', '10', '20'})
xticks([0 10 20])
xticklabels({'0', '10', '20'})