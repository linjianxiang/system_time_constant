
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
[Cxy,F] = mscohere(origin_sine,sine_damping_value);

[Pxy,F] = cpsd(origin_sine,sine_damping_value);

subplot(2,1,1)
plot(F,Cxy)
title('Magnitude-Squared Coherence')

subplot(2,1,2)
plot(F,angle(Pxy))

hold on
plot(F,2*pi*100*tau*ones(size(F)),'--')
hold off

xlabel('Hz')
ylabel('\Theta(f)')
title('Cross Spectrum Phase')
%%
load simout.mat
load xmeas_cdelay.mat
load xmeas_delay.mat
%% using simout.mat (output of TE model)
%load data from simulation 
n_signal = 15;
sig_length = length(xmeas_delay.signals.values(:,1));
signal_delay = zeros(n_signal,sig_length);
signal_cdelay = zeros(n_signal,sig_length);
sig_out = zeros(n_signal,sig_length);
delay_all = zeros(4,n_signal);
for i = 1:n_signal %xmeas 1 2 3 4 7 8 9 10 11 12 14 15 17 23 40
    signal_delay(i,:) = xmeas_delay.signals.values(:,i);
    signal_cdelay(i,:) = xmeas_cdelay.signals.values(:,i);
end
sig_out(1,:) = simout(:,1); %xmeas1
sig_out(2,:) = simout(:,2); %xmeas2
sig_out(3,:) = simout(:,3); %xmeas3
sig_out(4,:) = simout(:,4); %xmeas4
sig_out(5,:) = simout(:,7); %xmeas7
sig_out(6,:) = simout(:,8); %xmeas8
sig_out(7,:) = simout(:,9); %xmeas9
sig_out(8,:) = simout(:,10); %xmeas10
sig_out(9,:) = simout(:,11); %xmeas11
sig_out(10,:) = simout(:,12); %xmeas12
sig_out(11,:) = simout(:,14); %xmeas14
sig_out(12,:) = simout(:,15); %xmeas15
sig_out(13,:) = simout(:,17); %xmeas17
sig_out(14,:) = simout(:,23); %xmeas23
sig_out(15,:) = simout(:,40); %xmeas40
Fs = 100; %(72s 7200 samples => Fs = 100)
for i = 1:n_signal
    [delay_all(1,i),~] = corr_method(signal_delay(i,:),sig_out(i,:));
    [delay_all(2,i),~] = corr_method(signal_cdelay(i,:),sig_out(i,:));
    [delay_all(3,i),~] = csd_method(signal_delay(i,:),sig_out(i,:));
    [delay_all(4,i),~] = csd_method(signal_cdelay(i,:),sig_out(i,:));
end

delay_all