%%

clear all
close all

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

%% Convert time shift to wrapped radians

f = 4.5;
t = 1/f;
w = 2*pi*f;

dts = 0:10:1000;

cmap = [jet(nTrial) ; flipud(jet(nTrial))];
cmap = cmap(1:2:nTrial*2, :);

%%

dtpi = dts*w/1000;
dtpi_ = wrapTo2Pi(dtpi);

%%


