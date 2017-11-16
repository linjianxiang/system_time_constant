%csd method
%input1 configuration:
%input2 delay_signal
%input3 original signal
%f frequency
%Fs sampling frequency
%output delay,~
function [csd_delay,Cxy,F1,Pxy,F2] = csd_method(noise_delay_signal,input_signal,Fs,f);
    input_signal = input_signal - mean(input_signal);
    noise_delay_signal = noise_delay_signal - mean(noise_delay_signal);
    switch nargin
        case 4
             % CSD method    
                 [Cxy,F1] = mscohere(input_signal,noise_delay_signal,[],[],[],Fs);
                 [Pxy,F2] = cpsd(input_signal,noise_delay_signal,[],[],[],Fs);
            %     
             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
             % delay calculation
                %angle(Pxy(index))/ (pi*f *2);
                if (angle(Pxy(index))>0) 
                    csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
                else
                      csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
                end
        case 3 %return angle
              % CSD method    
                 [Cxy,F1] = mscohere(input_signal,noise_delay_signal,[],[],[],Fs);
                 [Pxy,F2] = cpsd(input_signal,noise_delay_signal,[],[],[],Fs);
% %               %calculate frequency using fft    
% %                   output_0mean = noise_delay_signal - mean(noise_delay_signal);
% %                   input_0mean = input_signal - mean(input_signal);
% %                   L = length(input_0mean);
% %                   output_fft = fft(input_0mean);
% %                   P2 = abs(output_fft/L);
% %                   P1 = P2(1:L/2+1);
% %                   P1(2:end-1) = 2*P1(2:end-1);
% %                   f_fft = Fs*(0:(L/2))/L;
% %                   [~,index] = max(P1);
% %                   f = f_fft(index)
% %                  subplot(3,1,1); plot(f_fft,P1);
% %                 subplot(3,1,2); plot(F1,Cxy);
% %                 title('Magnitude-Squared Coherence')           
% %                 subplot(3,1,3); plot(F2,angle(Pxy))
% %                 hold on
% %                 plot(F2,2*pi*f*tau1*ones(size(F2)),'--');
% %                %plot(F2,2*pi*f*tau2*ones(size(F2)),'--');
% %                 hold off
            %find frequency from mscohere plot
                [pks,locs] = findpeaks(Cxy);
                [~,index] = max(Cxy);
                f = F1(index);
                if (f ~= 0)    
                    f
                else
                    [peak_n, index_n] = nth_largest(pks,locs,3);
                    f = F1(index_n)
                end
             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
                 if (angle(Pxy(index))>0) 
                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
                 else
                       csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
                 end
                tau1 = 0.01; tau2 = 1;
                figure;
                subplot(2,1,1); plot(F1,Cxy);
                title('Magnitude-Squared Coherence')           
                subplot(2,1,2); plot(F2,angle(Pxy))
                hold on
                plot(F2,2*pi*f*tau1*ones(size(F2)),'--');
                hold off
        otherwise 
                Fs = 1000; %defual Fs = 1000
            %calculate frequency    
                  output_0mean = noise_delay_signal - mean(noise_delay_signal);
                  input_0mean = input_signal - mean(input_signal);
                  L = length(input_0mean);
                  output_fft = fft(input_0mean);
                  P2 = abs(output_fft/L);
                  P1 = P2(1:L/2+1);
                  P1(2:end-1) = 2*P1(2:end-1);
                  f_fft = Fs*(0:(L/2))/L;
                  [~,index] = max(P1);
                  f = f_fft(index);
             % CSD method    
                 [Cxy,F1] = mscohere(input_0mean,noise_delay_signal);
                 [Pxy,F2] = cpsd(input_0mean,noise_delay_signal);    
             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
                 if (angle(Pxy(index))>0) 
                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
                 else
                       csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
                 end
            
    end
end