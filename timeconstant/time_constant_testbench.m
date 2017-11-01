% configuration
    T = 2; %simulation time
    tau = 0.005 %delay
    f = 5;
    Fs = 1000;
    iteration_n = 2;
    %1e-7 max noise ~= 0.03 %1e-8 max noise ~= 0.01
    %1e-6 max noise ~= 0.1; 1e-5 max noise ~= 0.3 ; 1e-4 max noise ~=1
    noise_amplitude = 1e-5;
    ramp_slope = -1;
    plot_switch = 0; %1 on; 0 off
    seed =  randi([0 1000],1);
    config = [T,f,Fs,noise_amplitude,ramp_slope,tau,plot_switch,seed];
    
     %frequency and amplitude config for sin waves
    f1 = f;
    f2 = f1 * 1.5;
    f3 = f1 * 1.75;
    f4 = f1 * 2;
    sin_amplitude1 = 1;
    sin_amplitude2 = 0.75;
    sin_amplitude3 = 0.5;
    sin_amplitude4 = 0.25;
%run iteration
    [csd_damp_delay,correlation_damp_delay,csd_multi_delay,correlation_multi_delay] = TC_iteration(config, iteration_n);