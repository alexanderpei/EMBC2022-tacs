clear all
close all

load ftdata_2

nTrial = 101;

f = 4.5;
t = 1/f;
w = 2*pi*f;

dts = 0:10:1000;

cmap = [jet(nTrial) ; flipud(jet(nTrial))];
cmap = cmap(1:2:nTrial*2, :);


%%

t = ftdata.time{1}(1:500);
ac = sin(2*pi*4.5*t);
ax.LineWidth = 2;
figure

subplot(4,1,1)
box on
plot(t, ftdata.trial{1}(3, 1:500)-ftdata.trial{1}(4, 1:500), 'k', 'LineWidth', 4)
xticks([0:5])
ax = gca;                           
ax.FontSize = 12;
ax.LineWidth = 6;
ax.XTick = [];
ax.YTick = [];

subplot(4,1,2)

iTrial = 8;

box on
hold on
temp = [zeros(1,150+(iTrial-1)) ac];
temp = temp(1:length(t));
plot(t, temp, 'color', cmap(iTrial, :), 'LineWidth', 4)
% xline(t(150),'r', 'LineWidth', 4)
% xline(t(200),'r', 'LineWidth', 4)
xticks([0:5])
ax = gca;                           
ax.FontSize = 12;
ax.LineWidth = 6;
ax.XTick = [];
ax.YTick = [];
ylim([-1.2 1.2])

subplot(4,1,3)

iTrial = 28;

box on
hold on
temp = [zeros(1,150+(iTrial-1)) ac];
temp = temp(1:length(t));
plot(t, temp, 'color', cmap(iTrial, :), 'LineWidth', 4)
% xline(t(200),'r', 'LineWidth', 4)
% xline(t(250),'r', 'LineWidth', 4)
xticks([0:5])
ax = gca;                           
ax.FontSize = 12;
ax.LineWidth = 6;
ax.XTick = [];
ax.YTick = [];
ylim([-1.2 1.2])

subplot(4,1,4)
iTrial = 45;

box on
hold on
temp = [zeros(1,150+(iTrial-1)) ac];
temp = temp(1:length(t));
plot(t, temp, 'color', cmap(iTrial, :), 'LineWidth', 4)
% xline(t(250),'r', 'LineWidth', 4)
% xline(t(300),'r', 'LineWidth', 4)
xticks([0:5])

ax = gca;                           
ax.FontSize = 16;
ax.LineWidth = 6;
ax.YTick = [];
ax.XTick = [];
ylim([-1.2 1.2])
