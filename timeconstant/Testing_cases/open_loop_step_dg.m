%open loop
Fs = 100;
Ts = 1/Fs;
seed =  randi([0 1000],1);
T = 20;
noise_amp = 1.0000e-06;
sim('open_loop_step');
Output1 = open_step_output1{1}.Values.Data;
Input =  open_step_input{1}.Values.Data;
Input = Input(4:end);
Output2 = open_step_output2{1}.Values.Data;

Output3 = open_step_output3{1}.Values.Data;

zIn1 = [Output1,Input];
zIn2 = [Output2,Input];
zIn3 = [Output3,Input];

save 'openloop_data1.mat' zIn1
save 'openloop_data2.mat' zIn2
save 'openloop_data3.mat' zIn3
% zIn1 = [Output1(2:end),Input];
% zIn2 = [Output2(2:end),Input];
% zIn3 = [Output3(2:end),Input];