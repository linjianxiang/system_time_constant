%%
iteration = 10;
%% random noise open loop
delay = zeros(7,1);
delay_sum = zeros(7,1); 
delayall = zeros(3,7); % 5delay 15delay and 50 delay
for i = 1:iteration
        tau = 5; %delay
        open_noise_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(1,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 15; %delay
        open_noise_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(2,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 50; %delay
        open_noise_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(3,:) = delay_sum/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);
delay_rdnoise_open = delayall;
%% sin + damping +noise
delay = zeros(7,1);
delay_sum = zeros(7,1); 
delayall = zeros(3,7); % 5delay 15delay and 50 delay
for i = 1:iteration
        tau = 5; %delay
        sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        %delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(1,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 15; %delay
        sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
       % delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(2,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 50; %delay
        sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
      %  delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(3,:) = delay_sum/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);
delay_sindamp = delayall;
%% multi sin damp + noise
delay = zeros(7,1);
delay_sum = zeros(7,1); 
delayall = zeros(3,7); % 5delay 15delay and 50 delay
for i = 1:iteration
        tau = 5; %delay
        multi_sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(1,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 15; %delay
        multi_sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(2,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 50; %delay
        multi_sin_damp_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(3,:) = delay_sum/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);
delay_multisin_damp = delayall;

%% TE data
delay_all = zeros(7,14);
delayc_all = zeros(7,14);
Ts_te = 1;
n_signal = 14;
tau = 50;
%TE_dg
for i = 1:n_signal
    
    zIn = [signal_delay(i,:)',sig_out(i,:)'];
    [delay_all(1,i),~] =corr_method(zIn');
    [delay_all(2,i),~] = csd_method(zIn');
    [delay_all(3,i)] =  oestructd(zIn);
    [delay_all(4,i)] = arxstructd(zIn);
    [delay_all(5,i)] = met1structd(zIn,Ts_te);
    [delay_all(6,i),~] = csd_method(zIn',1,1);
    [delay_all(7,i),~] = csd_method(zIn',1,2);

    
end
for i = 1:n_signal
    zIn = [signal_cdelay(i,:)',sig_out(i,:)'];
%     [delayc_all(1,i),~] =corr_method(zIn');
%     [delayc_all(2,i),~] = csd_method(zIn');
%     [delayc_all(3,i)] =  oestructd(zIn);
%     [delayc_all(4,i)] = arxstructd(zIn); 
     [delayc_all(5,i)] = met1structd(zIn,Ts_te);
%     [delayc_all(6,i),~] = csd_method(zIn',1,1);
%     [delayc_all(7,i),~] = csd_method(zIn',1,2);
end
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delay_all);
disp(delayc_all);
delay_te = delay_all;
delay_tec = delayc_all;
%% Discrete-time transfer function generator
Fs = 100;
Ts = 1/Fs;
G_1b = tf([1],[10 11 1],'InputDelay', 9);
G_1b_d = 0.5*c2d(G_1b,Ts,'foh');   % slow second order system
G_2b = tf([1],[0.1 1.1 1],'InputDelay', 9);
G_2b_d = 0.5*c2d(G_2b,Ts,'foh');   % slow second order system

% figure; hold on;
% step(G_1b,'-',G_1b_d,'--')
% hold off

%% open loop --- step input
delay = zeros(7,1);
delay_sum1 = zeros(7,1);
delay_sum2 = zeros(7,1);
delay_sum3 = zeros(7,1);
delayall = zeros(3,7); 
tau = 5;
for i = 1:iteration
         open_loop_step_dg
        % delay computation
        [delay(1),~] = corr_method(zIn1');
        [delay(2),~] = csd_method(zIn1');
        delay(3) = oestructd(zIn1);
        delay(4) = arxstructd(zIn1);
        delay(5)= met1structd(zIn1);
        [delay(6),~] = csd_method(zIn1',1,1);
        [delay(7),~] = csd_method(zIn1',1,2);
        delay_sum1 = delay_sum1+delay;

        % delay computation
        [delay(1),~] = corr_method(zIn2');
        [delay(2),~] = csd_method(zIn2');
        delay(3) = oestructd(zIn2);
        delay(4) = arxstructd(zIn2);
        delay(5)= met1structd(zIn2);
        [delay(6),~] = csd_method(zIn2',1,1);
        [delay(7),~] = csd_method(zIn2',1,2);
        delay_sum2 = delay_sum2+delay;

        % delay computation
        [delay(1),~] = corr_method(zIn3');
        [delay(2),~] = csd_method(zIn3');
        delay(3) = oestructd(zIn3);
        delay(4) = arxstructd(zIn3);
        delay(5)= met1structd(zIn3);
        [delay(6),~] = csd_method(zIn3',1,1);
        [delay(7),~] = csd_method(zIn3',1,2);
        delay_sum3 = delay_sum3+delay;
end

delayall(1,:) = delay_sum1/iteration;
delayall(2,:) = delay_sum2/iteration;
delayall(3,:) = delay_sum3/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);

delay_step_op = delayall;

%% close loop --- step input
delay = zeros(7,1);
delay_sum1 = zeros(7,1);
delay_sum2 = zeros(7,1);
delay_sum3 = zeros(7,1);
delayall = zeros(3,7); 
tau = 5;
for i = 1:iteration
         close_loop_step_dg
        % delay computation
        [delay(1),~] = corr_method(zIn1');
        [delay(2),~] = csd_method(zIn1');
        delay(3) = oestructd(zIn1);
        delay(4) = arxstructd(zIn1);
        delay(5)= met1structd(zIn1);
        [delay(6),~] = csd_method(zIn1',1,1);
        [delay(7),~] = csd_method(zIn1',1,2);
        delay_sum1 = delay_sum1+delay;

        % delay computation
        [delay(1),~] = corr_method(zIn2');
        [delay(2),~] = csd_method(zIn2');
        delay(3) = oestructd(zIn2);
        delay(4) = arxstructd(zIn2);
        delay(5)= met1structd(zIn2);
        [delay(6),~] = csd_method(zIn2',1,1);
        [delay(7),~] = csd_method(zIn2',1,2);
        delay_sum2 = delay_sum2+delay;

        % delay computation
        [delay(1),~] = corr_method(zIn3');
        [delay(2),~] = csd_method(zIn3');
        delay(3) = oestructd(zIn3);
        delay(4) = arxstructd(zIn3);
        delay(5)= met1structd(zIn3);
        [delay(6),~] = csd_method(zIn3',1,1);
        [delay(7),~] = csd_method(zIn3',1,2);
        delay_sum3 = delay_sum3+delay;
end

delayall(1,:) = delay_sum1/iteration;
delayall(2,:) = delay_sum2/iteration;
delayall(3,:) = delay_sum3/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);
delay_step_close = delayall;

%% close loop transfer function 2

delay = zeros(7,1);
delay_sum = zeros(7,1); 
delayall = zeros(3,7); % 5delay 15delay and 50 delay
for i = 1:iteration
        tau = 5; %delay
        close_loop_tf2_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(1,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 15; %delay
        close_loop_tf2_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(2,:) = delay_sum/iteration;
for i = 1:iteration
        tau = 50; %delay
        close_loop_tf2_dg
        % delay computation
        [delay(1),~] = corr_method(zIn');
        [delay(2),~] = csd_method(zIn');
        delay(3) = oestructd(zIn);
        delay(4) = arxstructd(zIn);
        delay(5)= met1structd(zIn);
        [delay(6),~] = csd_method(zIn',1,1);
        [delay(7),~] = csd_method(zIn',1,2);
        delay_sum = delay_sum+delay;
end
delayall(3,:) = delay_sum/iteration;
disp('   1.corr    2.csd     3.oes     4.arx      5.met1    6.csd1    7.csd2')
disp(delayall);
delay_close_loop_tf2 = delayall;
