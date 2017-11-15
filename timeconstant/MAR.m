%function MAR
    % init damping sine simulation value
    % configuration
    T = 3; %simulation time
    tau = 0.005 %delay
    f = 5;
    Fs = 1000;
    noise_amplitude = 1e-1;
    ramp_slope = -1;
    angle_sum = 0;

    seed =  randi([0 1000],1);
    % run simulation
    sim('sine_wave_decay');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    [Cxy,F] = mscohere(origin_sine,sine_damping_value);

    [Pxy,F] = cpsd(origin_sine,sine_damping_value);
   %% 
    %create default VAR(p) model
    Mdl = varm(2,4);
    %EstMdl_sindelay = estimate(Mdl,sine_delay_value);
    EstMdl_sindamp = estimate(Mdl,[origin_sine,sine_delay_value])

%end