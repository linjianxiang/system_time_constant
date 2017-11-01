% corr_method 
%input1 configuration:
%input2 delay_signal
%input3 original signal
function [corr_delay,lag_noise,acor_noise] = corr_method(noise_delay_signal,input_signal);
    
    % correlation method 
    %[acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,input_signal);
    [acor_noise,lag_noise] = xcorr(noise_delay_signal,input_signal);

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