%% Converts output from Simulink solver into Fieldtrip Datastructure

clear
close all

nExp = 2;
pathData = fullfile(cd, ['out_' num2str(nExp)]);

%% Convert to Fieldtrip

if nExp == 1
    acs = 0:0.5:20;
    nCond = length(acs);
    nSample = 1000;
    dur = 10;
elseif nExp == 2
    dts = 0:10:1000;
    nCond = length(dts)+1;
    nSample = 1000;
    dur = 10;
elseif nExp == 3
    dts = 0:10:1000;
    nCond = length(dts);
    nSample = 1000;
    dur = 10;
end

Fs = nSample/dur;
chanLabels  = {'y1','y2', 'x15-x16', 'x25-x26'};
chanLabels  = {'y1','y2','x15','x16'};

nChannel = length(chanLabels);

data = [];
labels = [];
allP = [];

load(fullfile(['out_' num2str(nExp)']), 'out')
nTrials = length(out)/nCond;

for iCond = 1:nCond

    tempData = zeros(nChannel, nSample, nTrials);
    tempLabels = ones(1, nTrials)*iCond;

    for iTrial = 1:nTrials

        tempData(1,:,iTrial) = out(iTrial+(iCond-1)*nTrials).y1.Data(1:nSample);
        tempData(2,:,iTrial) = out(iTrial+(iCond-1)*nTrials).y2.Data(1:nSample);

        tempData(3,:,iTrial) = out(iTrial+(iCond-1)*nTrials).x15.Data(1:nSample);
        tempData(4,:,iTrial) = out(iTrial+(iCond-1)*nTrials).x16.Data(1:nSample);

%         x15 = out(iTrial+(iCond-1)*nTrials).x15.Data(1:nSample);
%         x16 = out(iTrial+(iCond-1)*nTrials).x16.Data(1:nSample);
%         x25 = out(iTrial+(iCond-1)*nTrials).x25.Data(1:nSample);
%         x26 = out(iTrial+(iCond-1)*nTrials).x26.Data(1:nSample);
% 
%         tempData(3,:,iTrial) = [0; diff(x15 - x16)];
%         tempData(4,:,iTrial) = [0; diff(x25 - x26)];


    end

    data = cat(3,data,tempData);
    labels = [labels tempLabels];    

end

% Create time axis
timeAxis = linspace(0, dur, nSample);

% Make Fieldtrip structure
ftdata = [];
[~,~,total] = size(data);
for i = 1:total
    ftdata.trial{i} = squeeze(data(:, :, i));
    ftdata.time{i} = timeAxis;
end

ftdata.fsample = Fs;
ftdata.label = chanLabels;
ftdata.label = ftdata.label(:);
ftdata.trialinfo = labels';

save(['ftdata_' num2str(nExp)], 'ftdata')

%% Run

if nExp == 1

cfg = [];
cfg.toi        = ftdata.time{1}(101:1000);
cfg.channel    = 'all';
cfg.tapsmofrq  = 2;
cfg.method     = 'mtmfft';
cfg.pad        = 'nextpow2';
cfg.keeptrials = 'yes';
cfg.output     = 'powandcsd';
cfg.foi        = 0:0.5:50;
cfg.calcdof    = 'yes';

freq = ft_freqanalysis(cfg, ftdata);
save(['ftdata_freq_small_' num2str(nExp)]  ,'freq')

cfg = [];
cfg.method = 'coh';
cfg.complex = 'imag';
conn = ft_connectivityanalysis(cfg, freq);

save(['ftdata_conn_small_' num2str(nExp)]  ,'conn')

elseif nExp == 2

cfg = [];
cfg.toi        = ftdata.time{1}(1:1000);
cfg.channel    = 'all';
cfg.tapsmofrq  = 2;
cfg.method     = 'tfr';
cfg.pad        = 'nextpow2';
cfg.keeptrials = 'yes';
cfg.output     = 'powandcsd';
cfg.foi        = 0:0.5:50;
cfg.calcdof    = 'yes';

freq = ft_freqanalysis(cfg, ftdata);

save(['ftdata_freqTFR_' num2str(nExp)]  ,'freq', '-v7.3')

cfg = [];
cfg.toi        = ftdata.time{1}(1:1000);
cfg.channel    = 'all';
cfg.tapsmofrq  = 2;
cfg.method     = 'mtmfft';
cfg.pad        = 'nextpow2';
cfg.keeptrials = 'yes';
cfg.output     = 'powandcsd';
cfg.foi        = 0:0.5:50;
cfg.calcdof    = 'yes';

freq = ft_freqanalysis(cfg, ftdata);

save(['ftdata_freq_' num2str(nExp)]  ,'freq', '-v7.3')

elseif nExp == 3

cfg = [];
cfg.toi        = ftdata.time{1}(500:1000);
cfg.channel    = 'all';
cfg.tapsmofrq  = 2;
cfg.method     = 'mtmfft';
cfg.pad        = 'nextpow2';
cfg.keeptrials = 'yes';
cfg.output     = 'powandcsd';
cfg.foi        = 0:0.5:50;
cfg.calcdof    = 'yes';

freq = ft_freqanalysis(cfg, ftdata);
save(['ftdata_freq_' num2str(nExp)]  ,'freq')

cfg = [];
cfg.method = 'coh';
conn = ft_connectivityanalysis(cfg, freq);
save(['ftdata_conn_' num2str(nExp)]  ,'conn')

end
