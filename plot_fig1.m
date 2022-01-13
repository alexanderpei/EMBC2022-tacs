%%

clear all
close all

load ftdata_freq_small_1

%%

acs = 0:0.5:20;

figure 

subplot(1,2,1)
cfg = [];
cfg.trials = freq.trialinfo == 9;

freq1 = ft_selectdata(cfg, freq);

plot(freq.freq, squeeze(mean(freq1.powspctrm(:,1,:)))')

cfg = [];
cfg.trials = freq.trialinfo == 1;

freq2 = ft_selectdata(cfg, freq);

plot(freq.freq, squeeze(mean(freq2.powspctrm(:,1,:)))')

subplot(1,2,2)
hold on

cfg = [];
cfg.method = 'coh';

conn1 = ft_connectivityanalysis(cfg, freq1);
conn2 = ft_connectivityanalysis(cfg, freq2);

plot(freq.freq, conn1.cohspctrm)
plot(freq.freq, conn2.cohspctrm)

