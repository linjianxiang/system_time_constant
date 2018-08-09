

T = 20;
seed =  randi([0 1000],1);
Fs = 1000;
Ts = 1/Fs;
sim('close_loop_tf2');
input = closeloop_input_tf2{1}.Values.Data;
output = closeloop_output_tf2{1}.Values.Data;
zIn = [output,input];