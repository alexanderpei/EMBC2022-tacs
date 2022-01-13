%%

clear all
close all

load ftdata_freq_3

%% Calculate entrainment time 

nTrial = 101;
idx = 84:916;

freqOI = squeeze(freq.powspctrm(:, 1, :));

%%

figure
hold on
plot(freqOI(1,:))
plot(freqOI(1:10:end,:)')
