input = input_signal.signals.values;
output1 = output_signal1.signals.values;
%[corr_delay,lag_noise,acor_noise] = corr_method(output,input);
%plot
out_n = 1;
tau = 0.005;
% use find delay for all simout
[m,n] = size(simout);
delay = zeros(1,n);
angle_csd = zeros(1,n);
for i = 1:n
    output = simout(:,i);
    if i ==1 
        [delay(i),lag_noise,acor_noise] = corr_method(output,input);
        [angle_csd(i),Cxy,F1,Pxy,F2] = csd_method(output,input);
        a = lag_noise;b = acor_noise;c=Cxy;d=Pxy;e=F1;f=F2;
        lag_noise = zeros(n,length(lag_noise));
        acor_noise = zeros(n,length(acor_noise));
        Cxy = zeros(n,length(Cxy));
        Pxy = zeros(n,length(Pxy));
        F1 = zeros(n,length(F1));
        F2 = zeros(n,length(F2));
        lag_noise(1,:)=a;acor_noise(1,:)=b;Cxy(1,:)=c;Pxy(1,:)=d;F1(1,:)=e;F2(1,:)=f;
    else
        [delay(i),lag_noise(i,:),acor_noise(i,:)] = corr_method(output,input);
        [angle_csd(i),Cxy(i,:),F1(i,:),Pxy(i,:),F2(i,:)] = csd_method(output,input);     
    end
        
end

% 
% figure;
% subplot(2,1,1); plot(F1(out_n,:),Cxy(out_n,:));
% title('Magnitude-Squared Coherence')     
% subplot(2,1,2); plot(F2(out_n,:),angle(Pxy(out_n,:)));  
% hold on; plot(F2(out_n,:),2*pi*f*tau*ones(size(F2(out_n,:))),'--')
% hold off
% figure; hold on;
% plot(lag_noise(out_n,:),acor_noise(out_n,:));
% hold off;
