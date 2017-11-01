%csd method
%input1 configuration:
%input2 delay_signal
%input3 original signal
%f frequency
%Fs sampling frequency
function [csd_delay,Cxy,F1,Pxy,F2] = csd_method(noise_delay_signal,input_signal,f,Fs);
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
                      csd_delay =  angle_sum + (pi+angle(Pxy(index)))/ (pi*f *2);
                end
        case 2 %return angle
                         % CSD method    
                 [Cxy,F1] = mscohere(input_signal,noise_delay_signal);
                 [Pxy,F2] = cpsd(input_signal,noise_delay_signal);
            %     
             % find the angle of point with the maximum amplitude 
                [~,index] = max(Cxy);
             
                csd_delay = angle(Pxy(index));
%                 if (angle(Pxy(index))>0) 
%                     csd_delay =  (angle(Pxy(index)))/ (pi*f *2);
%                 else
%                       csd_delay =  angle_sum + (pi+angle(Pxy(index)))/ (pi*f *2);
%                 end
        otherwise
            
    end
end