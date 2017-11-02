load simout.mat
%% init damping sine simulation value
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

% apply fft
L = length(sine_damping_value);
output_fft = fft(sine_damping_value);
P2 = abs(output_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
%plot(f,P1)

%find frequency
[~,index] = max(P1);
f(index)

%% using simout.mat (output of TE model)
%let Fs = 1000
Fs = 1000;
signal2 = simout(:,2);
signal2_delay = xmeas2_3_delay.signals.values(:,1);
signal2_cdelay = xmeas2_3_cdelay.signals.values(:,1);
singal3 = simout(:,3);

%corr_method 
[delay,~] = corr_method(signal2_delay,signal2);
[delayc,~] = corr_method(signal2_cdelay,signal2);


L = length(signal2);
output_fft = fft(signal2);
P2 = abs(output_fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
%plot(f,P1)

%find frequency
[~,index] = max(P1);
freq = f(index)

%
[csd_delay,~] = csd_method(signal2_delay,signal2,Fs,freq);
[csd_cdelay,~] = csd_method(signal2_cdelay,signal2,Fs,freq);
