%% sine_delay generate  %sin_delay = sin_delay = [origin_sine,sine_noise_delay,sine_noise_damping];
    % configuration
    T = 10; %simulation time
    f = 15;
    Fs = 1000;
    noise_amplitude = 1e-5;
    ramp_slope = -0.3;

    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('sine_wave_decay');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_noise_delay = sine_noise_delay{1}.Values.Data(:);
    sine_noise_damping = (sin_damping{1}.Values.Data(:));
    sine_noise_damping = sine_noise_damping(2:end);
    zIn = [sine_noise_delay,origin_sine];
    