%%

clear all
close all

load ftdata_freq_2

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
dtpi_ = wrapToPi(dtpi);

[~,iSort] = sort(dtpi_);

dtpi_ = dtpi_(iSort);
dtpi = dtpi(iSort);

dpi = abs(dtpi_ - 0);
[~, iPi] = sort(dpi);

dpi = abs(dtpi_ - pi);
[~, iPi_] = sort(dpi);

%%


fig = figure;
fig.Position = [878   954   919   384];

hold on
box on

for iTrial = 1:length(iSort)
    if ismember(iTrial, iPi(1))
        plot(freq.time(idx), freqOI(iSort(iTrial), :), 'color', cmap(iTrial, :), 'LineWidth', 4)
    elseif ismember(iTrial, iPi_(1:5))
        plot(freq.time(idx), freqOI(iSort(iTrial), :), 'color', cmap(iTrial, :), 'LineWidth', 4)
    else
        plot(freq.time(idx), freqOI(iSort(iTrial), :), 'color', cmap(iTrial, :), 'LineWidth', 1.1)
    end
end
colormap(cmap)
c = colorbar;
                                                                                                            
ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 2;
caxis([min(dts) max(dts)])
c.Ticks = linspace(min(dts), max(dts), 3);
c.TickLabels = {'0', '\pi', '2\pi'};
c.LineWidth = 2;

xlim([1 7])
ylim([3e4 6e4])
xlabel('Time (s)')
ylabel('Power')