%open noise data gen
    T = 5; %simulation time
%     tau = 5; %delay
    Fs = 1000;
    noise_amplitude = 1;
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('open_noise');
    Data_output = output{1}.Values.Data;
    Data_input = input{1}.Values.Data;
    zIn = [Data_output,Data_input];