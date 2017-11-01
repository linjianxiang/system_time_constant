input = input_signal.signals.values;
output = output_signal.signals.values;

[delay,~,~] = corr_method(output,input);