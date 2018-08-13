% %% sine_delay generate  %sin_delay = sin_delay = [origin_sine,sine_noise_delay,sine_noise_damping];
%     % configuration
%     T = 3; %simulation time
%     tau = 0.005; %delay
%     f = 5;
%     Fs = 1000;
%     iteration_n = 1;
%     noise_amplitude = 1e-5;
%     ramp_slope = -1;
%     angle_sum = 0;
% 
%     % random seed generator
%     seed =  randi([0 1000],1);
%     % run simulation
%     sim('sine_wave_decay');
%     % extract simulation data
%     origin_sine = disc_sine{1}.Values.Data(:);
%     sine_delay_value = sine_delay{1}.Values.Data(:);
%     sine_noise_delay = sine_noise_delay{1}.Values.Data(:);
%     sine_noise_damping = (sin_damping{1}.Values.Data(:));
%     sine_noise_damping = sine_noise_damping(2:end);
%     sin_delay = [origin_sine,sine_noise_delay,sine_noise_damping];
%     
%  %% multiple damping sin
%      f1 = f;
%     f2 = f1 * 1.5;
%     f3 = f1 * 1.75;
%     f4 = f1 * 2;
%     % Fs = 1000;
%     % iteration_n = 10;
%     % noise_amplitude = 0.005;
%     % ramp_slope = -1;
%     angle_sum = 0;
%     sin_amplitude1 = 1;
%     sin_amplitude2 = 0.75;
%     sin_amplitude3 = 0.5;
%     sin_amplitude4 = 0.25;
%     % random seed generator
%     seed =  randi([0 1000],1);
%     % run simulation
%     sim('multiple_sin');
%     % extract simulation data
%     origin_sine = disc_sine{1}.Values.Data(:);
%     sine_delay_value = sine_delay{1}.Values.Data(:);
%     sine_noise_delay = sine_noise_delay{1}.Values.Data(:);
%     sine_noise_damping = (sin_damping{1}.Values.Data(:));
%     sine_noise_damping = sine_noise_damping(2:end);
%     sin_delay=[origin_sine,sine_noise_delay,sine_noise_damping];
%     
 %% load TE model data
% load simout.mat
% load xmeas_cdelay.mat
% load xmeas_delay.mat
Fs = 100;
sim('MultiLoop_mode1');
sig_length = length(xmeas_delay.signals.values(:,1));
signal_delay = zeros(n_signal,sig_length);
signal_cdelay = zeros(n_signal,sig_length);
sig_out = zeros(n_signal,sig_length);

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
 %(72s 7200 samples => Fs = 100)

% %% load close-loop 
% sim('closeLoop');
% close_input= closeloop_input{1}.Values.Data;
% close_output= closeloop_output{1}.Values.Data;
