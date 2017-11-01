%% csd --- damping sine wave + noise 

% configuration
T = 3; %simulation time
tau = 0.005 %delay
f = 5;
Fs = 1000;
iteration_n = 1;
noise_amplitude = 1e-5;
ramp_slope = -1;
angle_sum = 0;

% might be useful for plotting
angle_array = zeros(1,iteration_n);
Cxy_sum = 0;
Pxy_sum = 0;
F1_sum = 0;
F2_sum = 0;
for i=1:iteration_n
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('sine_wave_decay');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
    
    % CSD method 
    [Cxy,F1] = mscohere(sine_damping_value,sine_noise_value,[],[],[],Fs);
    [Pxy,F2] = cpsd(sine_damping_value,sine_noise_value,[],[],[],Fs);
    
    % find the angle of point with the maximum amplitude 
    [~,index5] = max(Cxy);
    angle(Pxy(index5))/ (pi*f *2);
    if (angle(Pxy(index5))>0) 
        angle_sum = angle_sum + (angle(Pxy(index5)))/ (pi*f *2);
        angle_array(i) =  (angle(Pxy(index5)))/ (pi*f *2);
    else
         angle_sum = angle_sum + (pi+angle(Pxy(index5)))/ (pi*f *2);
          angle_array(i) =  angle_sum + (pi+angle(Pxy(index5)))/ (pi*f *2);
    end
    
end

% average the delay csd --- damping sine wave + noise 
delay1 = angle_sum/iteration_n

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

%% correlation damping sine wave + noise 

% configuration
%T = 1; %simulation time
% tau = 0.005 %delay
% f = 10;
% Fs = 1000;
% iteration_n = 15;
% noise_amplitude = 0.01;
% ramp_slope = -1;
delay_sum = 0;
delay_array = zeros(1,iteration_n);

for i=1:iteration_n
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('sine_wave_decay');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    
    % correlation method 
    [acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,sine_damping_value);
    [acor_noise,lag_noise] = xcorr(sine_noise_value,sine_damping_value);

    % find the number of delay 
    [~,index2] = max(acor_noise);
    index2 = lag_noise(index2);
    delay_sum = delay_sum +index2;
    delay_array(i) = index2;
%     [~,index1] = max(acor_nonoise);
%     index1 = lag_nonoise(index1)
end

delay2 = (delay_sum / iteration_n)/1000
% figure; hold on;
% plot(lag_noise,acor_noise);
% plot(lag_nonoise,acor_nonoise);

%%  csd multiple_sin --- damping sine wave + noise 

% configuration
% T = 1; %simulation time
% tau = 0.005 %delay
f1 = f;
f2 = f1 * 1.5;
f3 = f1 * 1.75;
f4 = f1 * 2;
% Fs = 1000;
% iteration_n = 10;
% noise_amplitude = 0.005;
% ramp_slope = -1;
angle_sum = 0;
sin_amplitude1 = 1;
sin_amplitude2 = 0.75;
sin_amplitude3 = 0.5;
sin_amplitude4 = 0.25;
% might be useful for plotting
angle_array = zeros(1,iteration_n);
Cxy_sum = 0;
Pxy_sum = 0;
F1_sum = 0;
F2_sum = 0;
for i=1:iteration_n
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('multiple_sin');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
    %[Cxy,F1] = mscohere(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
    %[Pxy,F2] = cpsd(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
    
    % CSD method 
    [Cxy,F1] = mscohere(sine_damping_value,sine_noise_value,[],[],[],Fs);
    [Pxy,F2] = cpsd(sine_damping_value,sine_noise_value,[],[],[],Fs);
    
    % find the angle of point with the maximum amplitude 
    [~,index5] = max(Cxy);
    angle(Pxy(index5))/ (pi*f *2);
    if (angle(Pxy(index5))>0) 
        angle_sum = angle_sum + (angle(Pxy(index5)))/ (pi*f *2);
        angle_array(i) =  (angle(Pxy(index5)))/ (pi*f *2);
    else
         angle_sum = angle_sum + (pi+angle(Pxy(index5)))/ (pi*f *2);
          angle_array(i) =  angle_sum + (pi+angle(Pxy(index5)))/ (pi*f *2);
    end
    
end

% average the angle
delay3 = angle_sum/iteration_n

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


%%  csd multiple_sin ---correlation damping

% configuration
% T = 1; %simulation time
% tau = 0.005 %delay
% f1 = 10;
% f2 = f1 * 1.5;
% f3 = f1 * 1.75;
% f4 = f1 * 2;
% Fs = 1000;
% iteration_n = 10;
% noise_amplitude = 0.005;
% ramp_slope = -1;
% angle_sum = 0;
% sin_amplitude1 = 1;
% sin_amplitude2 = 0.75;
% sin_amplitude3 = 0.5;
% sin_amplitude4 = 0.25;

delay_sum = 0;
delay_array = zeros(1,iteration_n);

for i=1:iteration_n
    % random seed generator
    seed =  randi([0 1000],1);
    % run simulation
    sim('multiple_sin');
    % extract simulation data
    origin_sine = disc_sine{1}.Values.Data(:);
    sine_delay_value = sine_delay{1}.Values.Data(:);
    sine_noise_value = sine_noise_delay{1}.Values.Data(:);
    sine_damping_value = (sin_damping{1}.Values.Data(:));
    sine_damping_value = sine_damping_value(2:end);
    
    % correlation method 
    [acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,sine_damping_value);
    [acor_noise,lag_noise] = xcorr(sine_noise_value,sine_damping_value);

    % find the number of delay 
    [~,index2] = max(acor_noise);
    index2 = lag_noise(index2);
    delay_sum = delay_sum +index2;
    delay_array(i) = index2;
%     [~,index1] = max(acor_nonoise);
%     index1 = lag_nonoise(index1)
end

delay4 = (delay_sum / iteration_n)/1000
% figure; hold on;
% plot(lag_noise,acor_noise);
% plot(lag_nonoise,acor_nonoise);

%% write 
FID = fopen('delay_value.txt', 'a');
%delay1 csd --- damping sine wave + noise 
%delay2 correlation damping sine wave + noise 
%delay3 csd multiple_sin --- damping sine wave + noise 
%delay4 csd multiple_sin ---correlation damping
delay = [delay1,delay2,delay3,delay4]
fwrite(FID,mat2str(delay));
fclose(FID);