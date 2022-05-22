%%

clear all
close all

nExp = 2;

model = 'nmm_ac';

%%

%%%%%%%%%%%%%%%%
if nExp == 1

    acs = [0:0.5:20];
    load_system(model)

    N = 100;
    c = 0;

    for ac = 1:length(acs)

        freq = ['2*pi*' num2str(acs(ac))];

        for idx = 1:N

            c = c + 1;

            in(c) = Simulink.SimulationInput(model);
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Amplitude', '2');
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Frequency', freq);
            in(c) = in(c).setBlockParameter([model '/Delay2'],  'DelayLength', '0');
            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Amplitude', '2');
            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Frequency', freq);
            in(c) = in(c).setBlockParameter([model '/Delay3'],  'DelayLength', '0');

        end

    end

    out = parsim(in, 'ShowProgress', 'on', 'TransferBaseWorkspaceVariables', 'on');


    %%%%%%%%%%%%%%%%
elseif nExp == 2

    dts = 500:10:1500;
    load_system(model)
    P = fn_get_params_simu(nExp, 1);
    c = 0;
    N = 1;

    for dt = 1:length(dts)

        for idx = 1:N

            c = c + 1;

            in(c) = Simulink.SimulationInput(model);
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Amplitude', '10');
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Frequency', '2*pi*4.5');
            in(c) = in(c).setBlockParameter([model '/Delay2'],  'DelayLength', num2str(dts(dt)));
            in(c) = in(c).setBlockParameter([model '/u1'],  'Seed', '1');

            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Amplitude', '10');
            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Frequency', '2*pi*4.5');
            in(c) = in(c).setBlockParameter([model '/Delay3'],  'DelayLength', num2str(dts(dt)));
            in(c) = in(c).setBlockParameter([model '/u2'],  'Seed', '1');

        end

    end

    c = c + 1;
    in(c) = Simulink.SimulationInput(model);
    in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Amplitude', '0');
    in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Frequency', '2*pi*4');
    in(c) = in(c).setBlockParameter([model '/Delay2'],  'DelayLength', num2str(dts(dt)));
    in(c) = in(c).setBlockParameter([model '/u1'],  'Seed', '1');

    in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Amplitude', '0');
    in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Frequency', '2*pi*4');
    in(c) = in(c).setBlockParameter([model '/Delay3'],  'DelayLength', num2str(dts(dt)));
    in(c) = in(c).setBlockParameter([model '/u2'],  'Seed', '1');

    out = parsim(in, 'ShowProgress', 'on', 'TransferBaseWorkspaceVariables', 'on');


    %%%%%%%%%%%%%%%%
elseif nExp == 3

    load_system(model)

    dts = 0:10:1000;
    P = fn_get_params_simu(nExp, 1);
    c = 0;
    load_system(model)
    N = 10;

    for dt = 1:length(dts)

        for idx = 1:N

            c = c + 1;

            in(c) = Simulink.SimulationInput(model);
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Amplitude', '2');
            in(c) = in(c).setBlockParameter([model '/Sine Wave'],  'Frequency', '2*pi*4');
            in(c) = in(c).setBlockParameter([model '/Delay2'],  'DelayLength', '0');

            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Amplitude', '2');
            in(c) = in(c).setBlockParameter([model '/Sine Wave1'],  'Frequency', '2*pi*4');
            in(c) = in(c).setBlockParameter([model '/Delay3'],  'DelayLength', num2str(dts(dt)));

        end
    end

    out = parsim(in, 'ShowProgress', 'on', 'TransferBaseWorkspaceVariables', 'on');

end

save(fullfile(['out_' num2str(nExp)']), 'out')
