%%

clear all
close all

load ftdata_freq_1

%%

% Baseline 
cfg = [];
cfg.trials = freq.trialinfo == 1;
base = ft_selectdata(cfg, freq);

basePow = squeeze(mean(base.powspctrm(:, 1, :)));

cfg = [];
cfg.method = 'coh';
baseCoh = ft_connectivityanalysis(cfg, base);
%
acs = 0:0.5:20;

dFreq = [];
dCoh  = [];

for i = 1:length(acs)

    d = abs(freq.freq - acs(i));
    [~, iMin] = min(d);

    cfg = [];
    cfg.trials = freq.trialinfo == i;
    tempFreq = ft_selectdata(cfg, freq);

    tempPow = squeeze(mean(tempFreq.powspctrm(:, 1, :)));

    dFreq = [dFreq tempPow(iMin)-basePow(iMin)];

    cfg = [];
    cfg.method = 'coh';
    tempCoh = ft_connectivityanalysis(cfg, tempFreq);

    dCoh = [dCoh atanh(tempCoh.cohspctrm(1,iMin))-atanh(baseCoh.cohspctrm(1,iMin))];

end

%%

fig = figure;
fig.Position = [944 697 834 220];

% Time series
subplot(1,2,1)
hold on
box on

pos = [ 3 0.1e-4 2 5.85e-4];
rectangle('Position',pos,'FaceColor',[0, 1, 1], 'EdgeColor', [0, 1, 1])
scatter(acs, dFreq, 'k', 'filled')

ylim([0 6e-4])
yticks([0 3e-4 6e-4])
yticklabels({'0', '3e-4', '6e-4'})
xlabel('Simulation Frequency (Hz)')
ylabel('Power Diff.')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;

% Power spectrum
subplot(1,2,2)
hold on
box on

pos = [ 3 -0.39 2 0.585];
rectangle('Position',pos,'FaceColor',[0, 1, 1], 'EdgeColor', [0, 1, 1])
scatter(acs, dCoh, 'k', 'filled')

ylim([-0.4 0.2])
yticks([-0.4 -0.2 0 0.2])
yticklabels({'-0.4', '-0.2', '0', '0.2'})
ylabel('Coh. Diff.')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
