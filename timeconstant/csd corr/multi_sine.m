function [csd_delay, corr_delay] = multi_sine(config);
 %configuration 
    T = config(1);
    f = config(2);
    Fs = config(3);
    noise_amplitude = config(4);
    ramp_slope = config(5);
    tau = config(6);
    plot_switch = config(7);
    seed = config(8);
 %simulate  
    sim('multiple_sin');
 % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    %run csd method 
            disp('multi sine');
        [csd_delay,Cxy,F1,Pxy,F2]  = csd_method(sine_noise_value,sine_damping_value,Fs);
    %run corr method
        [corr_delay,lag_noise,acor_noise] = corr_method(sine_noise_value,sine_damping_value);
    %plot
    if plot_switch == 1
        figure;
        subplot(2,1,1); plot(F1,Cxy);
        title('Magnitude-Squared Coherence')     
        subplot(2,1,2); plot(F2,angle(Pxy));  
        hold on; plot(F2,2*pi*f*tau*ones(size(F2)),'--')
        hold off
        figure; hold on;
        plot(lag_noise,acor_noise);
        hold off;
    end
end