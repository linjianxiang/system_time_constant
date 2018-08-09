sin_delay_input = sin_delay(:,1);
sin_delay_output = sin_delay(:,2);
zIn_sin_delay = [sin_delay_output,sin_delay_input];




dtEst_oe = oestructd(zIn_sin_delay);
dtEst_arx = arxstructd(zIn_sin_delay);
Ts = 1/1000;
dtEst_met1 = met1structd(sin_delay_input, sin_delay_output, Ts); %met1structd(inSig, outSig, Ts)


%%
%p24_imp(sin_delay_output); 
[csd_delay,~] = csd_method(sin_delay_output,sin_delay_input)
[coor_delay,~] = corr_method(sin_delay_output,sin_delay_input)

%% te data test 15sets of data
delay_all = zeros(3,15);
delayc_all = zeros(3,15);
Ts_te = 1/Fs;
n_signal = 14;
for i = 1:n_signal

    zIn = [sig_out(i,:)',signal_delay(i,:)'];
    [delay_all(1,i)] =  oestructd(zIn);
    [delay_all(2,i)] = arxstructd(zIn);
    [delay_all(3,i)] = met1structd(signal_delay(i,:)', sig_out(i,:)', Ts_te);

    
end
for i = 1:n_signal

    zIn = [sig_out(i,:)',signal_cdelay(i,:)'];
    [delayc_all(1,i)] =  oestructd(zIn);
    [delayc_all(2,i)] = arxstructd(zIn);
    %[delayc_all(3,i)] = met1structd(signal_cdelay(i,:)', sig_out(i,:)', Ts_te);

end

%% close loop
zIn_close = [close_output,close_input];
close_oe = oestructd(zIn_close);
close_arx = arxstructd(zIn_close);
Ts = 1/10;
close_met1 = met1structd(close_input, close_output, Ts); %met1structd(inSig, outSig, Ts)
[csd_delay,~] = csd_method(close_output,close_input)
[coor_delay,~] = corr_method(close_output,close_input)

