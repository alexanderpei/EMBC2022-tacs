%% Figure 1: Sample trial and spectrum

% Plot a sample trial and spectrum

clc
clear all
close all

load ftdata_1
load ftdata_freq_1

%% Generate the plot

iTrial = 1;

fig = figure;
fig.Position = [944 697 834 220];

% Time series
subplot(1,2,1)
hold on
box on

iT = 1:200;
iF = 1:60;
t = ftdata.time{iTrial}(iT);
y1 = ftdata.trial{iTrial}(1, iT);
y2 = ftdata.trial{iTrial}(2, iT);

plot(t, y1, 'b', 'LineWidth', 1.2)
plot(t, y2, 'r', 'LineWidth', 1.2)

ylim([-1 1])
yticks([-1 0 1])
yticklabels({'-1', '0', '1'})
ylabel('Potential (mV)')
xlabel('Time (s)')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;

% Power spectrum
subplot(1,2,2)
hold on
box on

f = freq.freq(iF);

y1f = squeeze(mean(freq.powspctrm(iTrial, 1, iF), 1));
y2f = squeeze(mean(freq.powspctrm(iTrial, 2, iF), 1));

plot(f, y1f, 'b', 'LineWidth', 1.2)
plot(f, y2f, 'r', 'LineWidth', 1.2)

ylim([0 2e-3])
yticks([0 1e-3 2e-3])
yticklabels({'0', '1e-3', '2e-3'})
ylabel('Power (mv^2/Hz)')
xlabel('Frequency (Hz)')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
