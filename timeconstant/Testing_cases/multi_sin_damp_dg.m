        % configuration
    T = 3; %simulation time
    f = 5;
    Fs = 1000;
    noise_amplitude = 1e-5;
    ramp_slope = -1;
    % random seed generator
    seed =  randi([0 1000],1);
    f1 = f;
    f2 = f1 * 1.5;
    f3 = f1 * 1.75;
    f4 = f1 * 2;

    sin_amplitude1 = 1;
    sin_amplitude2 = 0.75;
    sin_amplitude3 = 0.5;
    sin_amplitude4 = 0.25;
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('multiple_sin');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_delay = sine_noise_delay{1}.Values.Data(:);
    sine_noise_damping = (sin_damping{1}.Values.Data(:));
    sine_noise_damping = sine_noise_damping(2:end);
    zIn = [sine_noise_delay,origin_sine];