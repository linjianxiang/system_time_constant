% delay = corr_method(zIn)
%zIn = [outSig, inSig];

function [corr_delay,lag_noise,acor_noise] = corr_method(zIn);
    noise_delay_signal = zIn(1,:);
    input_signal = zIn(2,:);
    % correlation method 
    %[acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,input_signal);
    [acor_noise,lag_noise] = xcorr(noise_delay_signal,input_signal);

    % find the number of delay 
    [~,index2] = max(acor_noise);
    corr_delay = lag_noise(index2);
%     [~,index1] = max(acor_nonoise);
%     delay = lag_nonoise(index1)

    corr_delay = corr_delay; %Fs = 1
%       figure; hold on;
%       plot(lag_noise,acor_noise);

end