function [csd_damp_delay,correlation_damp_delay,csd_multi_delay,correlation_multi_delay] = TC_iteration(config, iteration_n);
    %creat array to store dealy
        csd_damp_array = zeros(1,iteration_n);
        correlation_damp_array = zeros(1,iteration_n);
        csd_multi_array = zeros(1,iteration_n);
        correlation_multi_array = zeros(1,iteration_n);
    %testings
    for i = 1:iteration_n
        seed =  randi([0 1000],1);
        config(8) = seed; %update seed
        % damping sin wave + noise 
        [csd_damp_array(i), correlation_damp_array(i)] = damping_sine(config);
        % multiple sin waves + noise 
        [csd_multi_array(i), correlation_multi_array(i)] = multi_sine(config);
    end
     csd_damp_delay = mean(csd_damp_array)
     correlation_damp_delay = mean(correlation_damp_array)
     csd_multi_delay = mean(csd_multi_array)
     correlation_multi_delay = mean(correlation_multi_array)

end