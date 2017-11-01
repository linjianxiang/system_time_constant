%% random value
% origin_value = signal_original{1}.Values.Data;
% delay_value = delay_no_noise{1}.Values.Data;
% noise_value = noise_delay{1}.Values.Data;

origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);
sine_damping_value = (sin_damping{1}.Values.Data(:));
sine_damping_value = sine_damping_value(2:end);


[acor_nonoise,lag_nonoise] = xcorr(sine_delay_value,sine_damping_value);
[acor_noise,lag_noise] = xcorr(sine_noise_value,sine_damping_value);

figure; hold on;

plot(lag_noise,acor_noise);
plot(lag_nonoise,acor_nonoise);

[~,index1] = max(abs(acor_nonoise));
index1 = lag_nonoise(index1)

[~,index2] = max(abs(acor_noise));
index2 = lag_noise(index2)

%% sine xcorr
origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);

[acor_sine,lag_sine] = xcorr(sine_delay_value,origin_sine);
[acor_sine_noise,lag_sine_noise] = xcorr(sine_noise_value,origin_sine);

figure; hold on;

plot(lag_sine_noise,acor_sine_noise);
plot(lag_sine,acor_sine);

[~,index3] = max(acor_sine);
index3 = lag_sine(index3)

[~,index4] = max(acor_sine_noise);
index4 = lag_sine_noise(index4)


%% coherence sine 
figure;
[cxy,fc] = mscohere(sine_noise_value,origin_sine);
plot(fc/pi,cxy);
%random signal
figure;
[cxy1,fc1] = mscohere(noise_value,origin_value);
plot(fc1/pi,cxy1);
%low pass filter
%minimum-order lowpass FIR filter with normalized passband frequency  rad/s, ...
%stopband frequency  rad/s, passband ripple 0.5 dB, and stopband attenuation 
%65 dB.
lpFilt = designfilt('lowpassfir','PassbandFrequency',0.25, ...
        'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65);
y = filter(lpFilt,sine_noise_value);
figure;
[cxy3,fc3] = mscohere(y,origin_sine);
plot(fc3/pi,cxy3)
%% coherence sine  window
origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);

noverlap = 100;
nfft = 200;
[cxy,fc] = mscohere(sine_noise_value,origin_sine,hann(nfft),noverlap,nfft);
figure;
plot(fc/pi,cxy);

%lpf
lpFilt = designfilt('lowpassfir','PassbandFrequency',0.25, ...
        'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65);
y = filter(lpFilt,sine_noise_value);
figure;
[cxy1,fc1] = mscohere(y,origin_sine,hann(nfft),noverlap,nfft);
plot(fc1/pi,cxy1)


%% cross power spectral density
% https://www.mathworks.com/help/signal/ref/cpsd.html
origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);

Fs = 100; %sampling time 1/Fs
tau=0.003 %delay
%cpsd(origin_sine,sine_noise_value,[],[],[],Fs);

[Cxy,F1] = mscohere(origin_sine,sine_noise_value,[],[],[],Fs);
[Pxy,F2] = cpsd(origin_sine,sine_noise_value,[],[],[],Fs);

subplot(2,1,1)
plot(F1,Cxy);
title('Magnitude-Squared Coherence')

subplot(2,1,2)
plot(F2,angle(Pxy))
hold on
plot(F2,2*pi*100*tau*ones(size(F2)),'--')
hold off
[~,index5] = max(Cxy);
%index5 = F1(index5);
angle(Pxy(index5)) / (pi*100 *2)

%% csd window
origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);

tau = 0.003 %delay
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);

[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,[],[],[],Fs);
[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,[],[],[],Fs);

subplot(2,1,1)
plot(F1,Cxy1);
title('Magnitude-Squared Coherence')

subplot(2,1,2)
plot(F2,angle(Pxy1))

hold on
plot(F2,2*pi*100*tau*ones(size(F2)),'--')
hold off

[~,index5] = max(Cxy1);
%index5 = F1(index5);
angle(Pxy1(index5))/ (pi*Fs *2)

%% csd testing

tau = 0.005 %delay
f = 1;
Fs = 1000;

origin_sine = disc_sine{1}.Values.Data(:);
sine_delay_value = sine_delay{1}.Values.Data(:);
sine_noise_value = sine_noise_delay{1}.Values.Data(:);
sine_damping_value = (sin_damping{1}.Values.Data(:));
sine_damping_value = sine_damping_value(2:end);
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(100),50,200,Fs);
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(1000),500,Fs*4,Fs);
%[Cxy1,F1] = mscohere(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);
%[Pxy1,F2] = cpsd(origin_sine,sine_noise_value,bartlett(256),128,2048,Fs);

[Cxy1,F1] = mscohere(sine_damping_value,sine_noise_value,[],[],[],Fs);
[Pxy1,F2] = cpsd(sine_damping_value,sine_noise_value,[],[],[],Fs);


subplot(2,1,1)
plot(F1,Cxy1);
title('Magnitude-Squared Coherence')

subplot(2,1,2)
plot(F2,angle(Pxy1))

hold on
plot(F2,2*pi*f*tau*ones(size(F2)),'--')
hold off
[~,index5] = max(Cxy1);
%[~,index5] = max(Cxy1(1:80));
%index5 = F1(index5);
angle(Pxy1(index5))/ (pi*f *2)
if (angle(Pxy1(index5))>0) 
    (angle(Pxy1(index5))-pi)/ (pi*f *2)
else
    (pi+angle(Pxy1(index5)))/ (pi*f *2)
end

