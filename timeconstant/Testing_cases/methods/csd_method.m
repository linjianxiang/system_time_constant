%delay =csd_method(zIn,Fs,nth);
%zIn = [output,input]
%Fs,nth are optional
%Fs = SamplingFrequency
% if 3 or 2 inputs nth_largest method
% if 1 input fft method
function [csd_delay,Cxy,F1,Pxy,F2] = csd_method(zIn,Fs,nth);
    noise_delay_signal = zIn(1,:);
    input_signal = zIn(2,:);
    switch nargin
        case 3
               input_signal = input_signal - mean(input_signal);
              noise_delay_signal = noise_delay_signal - mean(noise_delay_signal);
                 [Cxy,F1] = mscohere(input_signal,noise_delay_signal,[],[],[],Fs);
                 [Pxy,F2] = cpsd(input_signal,noise_delay_signal,[],[],[],Fs);
                [pks,locs] = findpeaks(Cxy);
                [~,index] = max(Cxy);
                if (isnan(Cxy))
                    csd_delay = 0;
                    return;
                end
                f = F1(index);
                if (f ~= 0 )    
                    f;
                else
                    [peak_n, index_n] = nth_largest(pks,locs,nth);
                    f = F1(index_n);
                end
             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
                 if (angle(Pxy(index))>0) 
                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
                 else
                       csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
                 end
            
%              % CSD method    
%                  [Cxy,F1] = mscohere(input_signal,noise_delay_signal,[],[],[],Fs);
%                  [Pxy,F2] = cpsd(input_signal,noise_delay_signal,[],[],[],Fs);
%             %     
%              % find the angle of point with the maximum amplitude 
%                 [~,index] = max(Cxy);
%              % delay calculation
%                 %angle(Pxy(index))/ (pi*f *2);
%                 if (angle(Pxy(index))>0) 
%                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
%                 else
%                       csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
%                 end
        case 2 %return angle
              % CSD method    
              input_signal = input_signal - mean(input_signal);
              noise_delay_signal = noise_delay_signal - mean(noise_delay_signal);
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
                    [peak_n, index_n] = nth_largest(pks,locs,2);
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
%                 figure;
%                 subplot(2,1,1); plot(F1,Cxy);
%                 title('Magnitude-Squared Coherence')           
%                 subplot(2,1,2); plot(F2,angle(Pxy))
%                 hold on
%                 plot(F2,2*pi*f*tau1*ones(size(F2)),'--');
%                 hold off
        otherwise 
%                 Fs = 1;
%                input_signal = input_signal - mean(input_signal);
%               noise_delay_signal = noise_delay_signal - mean(noise_delay_signal);
%                  [Cxy,F1] = mscohere(input_signal,noise_delay_signal,[],[],[],Fs);
%                  [Pxy,F2] = cpsd(input_signal,noise_delay_signal,[],[],[],Fs);
%                 [pks,locs] = findpeaks(Cxy);
%                 [~,index] = max(Cxy);
%                 f = F1(index);
%                 if (f ~= 0)    
%                     f;
%                 else
%                     [peak_n, index_n] = nth_largest(pks,locs,1);
%                     f = F1(index_n);
%                 end
%              % find the angle of point with the maximum amplitude 
%                 [~,index] = max(Cxy);
%                  if (angle(Pxy(index))>0) 
%                      csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
%                  else
%                        csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
%                  end

%                                 figure;
%                 subplot(2,1,1); plot(F1,Cxy);
%                 title('Magnitude-Squared Coherence')           
%                 subplot(2,1,2); plot(F2,angle(Pxy))
%                 hold off
%                    f

                Fs = 1; %defual Fs = 1000
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
%                  [Cxy,F1] = mscohere(input_0mean,output_0mean);
%                  [Pxy,F2] = cpsd(input_0mean,output_0mean);    

             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
                 if (angle(Pxy(index))>0) 
                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
                 else
                       csd_delay = (pi+angle(Pxy(index)))/ (pi*f *2);
                 end
            
    end
end