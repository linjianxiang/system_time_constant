%MAR testbench 
%initialization
% n = 10;
% X = 1:n;
% Y=2:(n+1);
% 


% X = sig_out(1,:);
% Y = signal_delay(1,:);


%X = origin_sine';
X = sine_damping_value';
%Y = sine_delay_value'; %delay damp
Y = sine_noise_value'; %noised damp
p_fpe = 1;
p_mdl = 1;

%
%n = length(X); %too much calculation
n = 20;
%MAR calculation
for p = 1:(n-2)
   [A,X_bar,E,C] = MAR_test(X,Y,p);
   
   %model order selection
   %using FPE
   e_fpe = FPE(X_bar,n,p);
   if p == 1
       best_fpe = e_fpe;
   elseif e_fpe < best_fpe
       best_fpe = e_fpe;
       p_fpe = p;
   end
   %using MDL
   e_mdl = MDL(X_bar,n,p);
   if p == 1
       best_mdl = e_mdl;
   elseif e_mdl < best_mdl
       best_mdl = e_mdl;
       p_mdl = p;
   end
end
p_fpe
p_mdl
 [A,X_bar,E,C] = MAR_test(X,Y,p_fpe);
 A_mean = A-mean(A);
% L = 1001;  %let 1000 samples/s 1s
 L = 7201;
 A_f = 1+fft(A_mean,L);
 P2 = abs(A_f/L); %amplitude 2side
 P1 = P2(1:L/2+1);
 P1(2:end-1) = 2*P1(2:end-1); %single side
 f = 100*(0:(L/2))/L;
% plot(f,P1);
 
 %% try to use x_bar and X
 Fs = 100;
 [csd_delay,~] = csd_method(X_bar,X(p_fpe+1:end)',Fs);
 [corr_delay,~] = corr_method(X_bar,X(p_fpe+1:end)');