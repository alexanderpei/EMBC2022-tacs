%%

clear all
close all

load ftdata_3
load ftdata_freq_3

%%

dts = 0:10:1000;

foi = 9;

pow = [];
coh = [];

for iCond = 1:length(dts)

    cfg = [];
    cfg.trials = freq.trialinfo == iCond;
    tempFreq = ft_selectdata(cfg, freq);

    cfg = [];
    cfg.method = 'coh';
    conn = ft_connectivityanalysis(cfg, tempFreq);

    pow = [pow squeeze(mean(tempFreq.powspctrm(:, 1, 9)))];
    coh = [coh conn.cohspctrm(1, 9)];

end

%%

f = 4.5;
t = 1/f;
w = 2*pi*f;
dtpi = dts*w/1000;

fig = figure;
fig.Position = [944 697 834 220*2];

subplot(2,2,1)
hold on
box on
scatter(dtpi, pow, 'k', 'filled')
xlim([0 3*pi])
xticks([0 pi 2*pi 3*pi])
xticklabels({'0', '\pi', '2\pi', '3\pi'})

ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 1.5;
xlabel('Phase Shift')
yticks([1.6 2.1 2.6]*1e-3)
ylabel('Power')

subplot(2,2,2)
hold on
box on

[~, iMax] = max(pow);
[~, iMin] = min(pow);

cfg = [];
cfg.trials = freq.trialinfo == iMax;
tempFreq = ft_selectdata(cfg, freq);

plot(freq.freq, squeeze(mean(tempFreq.powspctrm(:, 1, :))), 'b', 'LineWidth', 1.5)

cfg = [];
cfg.trials = freq.trialinfo == iMin;
tempFreq = ft_selectdata(cfg, freq);

plot(freq.freq, squeeze(mean(tempFreq.powspctrm(:, 1, :))), 'r', 'LineWidth', 1.5)

ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 1.5;

xlim([0 20])
ylim([0 3e-3])
xlabel('Frequency (Hz)')
ylabel('Power')

% Coherence vs. Phase
subplot(2,2,3)
hold on
box on
scatter(dtpi, coh, 'k', 'filled')
xlim([0 3*pi])
ylim([0.7 0.9])
xticks([0 pi 2*pi 3*pi])
xticklabels({'0', '\pi', '2\pi', '3\pi'})

ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 1.5;
xlabel('Phase Shift')
yticks([0.7 0.8 0.9])
ylabel('Coherence')

subplot(2,2,4)
hold on
box on

[~, iMax] = max(coh);
[~, iMin] = min(coh);

cfg = [];
cfg.trials = freq.trialinfo == iMax;
tempFreq = ft_selectdata(cfg, freq);
cfg = [];
cfg.method = 'coh';
conn = ft_connectivityanalysis(cfg, tempFreq);

plot(freq.freq, conn.cohspctrm, 'b', 'LineWidth', 1.5)

cfg = [];
cfg.trials = freq.trialinfo == iMin;
tempFreq = ft_selectdata(cfg, freq);
cfg = [];
cfg.method = 'coh';
conn = ft_connectivityanalysis(cfg, tempFreq);

plot(freq.freq, conn.cohspctrm, 'r', 'LineWidth', 1.5)

ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 1.5;

xlim([0 20])
ylim([0 1])
xlabel('Frequency (Hz)')
ylabel('Coherence')