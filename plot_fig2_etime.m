%%

clear all
close all

load ftdata_2
load ftdata_freqTFR_2
%% Calculate entrainment time

nTrial = 101;
idx = 84:916;

freqOI = squeeze(mean(freq.powspctrm(:, 1, 8:10, idx), 3));
ss = mean(freqOI(:, end));

eTime = zeros(1, 101);

for iTrial = 1:nTrial
    tempTrial = freqOI(iTrial, :);
    temp = find(tempTrial >= ss);
    eTime(iTrial) = temp(1);
end

%% Calculate pdot 

dts = 500:1:1500;
t = 0:0.01:0.5;
ac = 10*sin(2*pi*4*t);
en = [];


all1 = [];
all2 = [];

for i = 1:101

    x15 = ftdata.trial{i}(3,151+(i-1):151+(i-1)+50);
    x16 = ftdata.trial{i}(4,151+(i-1):151+(i-1)+50);

    pdot = x15 - x16 + ac;
    all1 = [all1 mean(pdot.^2)];

    x15 = ftdata.trial{i}(4,151+(i-1):151+(i-1)+50);
    pdot = x15 + ac;
    all2 = [all2 mean(pdot.^2)];

end

[~, iSort] = sort(eTime);
iSort(end-3:end) = [];

fig = figure;
fig.Position = [944 697 834 220];

corr = corrcoef(eTime(iSort), all1(iSort));
mdl = fitlm(all1(iSort), eTime(iSort));
% Time series
subplot(1,2,1)
hold on
box on

pos = [ 3 0.1e-4 2 5.85e-4];
scatter(eTime(iSort)/100, all1(iSort), 'k', 'filled')
% h = lsline;
% h.Color = 'r';
% h.LineWidth = 2;
ylabel('Ave. energy')
xlabel('Time (s)')
xlim([1 4.5])
% ylim([500 2000 ])

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;

% Power spectrum
subplot(1,2,2)
hold on
box on

[~, iMax] = max(eTime);
[~, iMin] = min(eTime);

plot(0.01:0.01:5, ftdata.trial{iMax}(1, 1:500), 'b')
plot(0.01:0.01:5, ftdata.trial{iMin}(1, 1:500), 'r')

xlim([0 5])
ylabel('Potential (mV)')
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
xlabel('Time (s)')

