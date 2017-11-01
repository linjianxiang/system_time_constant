function [corr_delay,lag_noise,acor_noise] = corr_multi_sine(config,origin_sine,sine_delay_value,sine_noise_value,sine_damping_value);
   
    
    f = config(2);
    Fs = config(3);
% correlation method 
    %[acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,sine_damping_value);
    [acor_noise,lag_noise] = xcorr(sine_noise_value,sine_damping_value);

    % find the number of delay 
    [~,index2] = max(acor_noise);
    corr_delay = lag_noise(index2);
%     [~,index1] = max(acor_nonoise);
%     delay = lag_nonoise(index1)

    corr_delay = corr_delay /1000;
    % figure; hold on;
    % plot(lag_noise,acor_noise);
    % plot(lag_nonoise,acor_nonoise);
end