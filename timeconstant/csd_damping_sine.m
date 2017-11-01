function [csd_delay,Cxy,F1,Pxy,F2] = csd_damping_sine(config,origin_sine,sine_noise_value,sine_damping_value);
    
    f = config(2);
    Fs = config(3);
    % CSD method 
    [Cxy,F1] = mscohere(sine_damping_value,sine_noise_value,[],[],[],Fs);
    [Pxy,F2] = cpsd(sine_damping_value,sine_noise_value,[],[],[],Fs);
    
    % find the angle of point with the maximum amplitude 
    [~,index5] = max(Cxy);
    % angle(Pxy(index5))/ (pi*f *2);
    if (angle(Pxy(index5))>0) 
        csd_delay =  (angle(Pxy(index5)))/ (pi*f *2);
    else
        csd_delay =  (pi+angle(Pxy(index5)))/ (pi*f *2);
    end
    % figure
    % subplot(2,1,1)
    % plot(F1,Cxy);
    % title('Magnitude-Squared Coherence')
    % 
    % subplot(2,1,2)
    % plot(F2,angle(Pxy))
    % 
    % hold on
    % plot(F2,2*pi*f*tau*ones(size(F2)),'--')
    % hold off
end