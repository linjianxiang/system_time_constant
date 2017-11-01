clc;clear all;close all;
%% Simulation for Continuous Stired Tank system
% Bahador Rashidi Feb 2017
%%
tf=25;
T=0.01;
N=ceil(tf/T);

%% Parameters


V=1;
ro=10^6;
ro_c=10^6;
E_R=8330.1;
Cp=1;
CPc=1;
b=0.5;
K0_initial=10^10;
a=1.678*10^6;
Delta_H=-1.3*10^7;
% F=1; %???

%% Initial Conditions
T=zeros(1,N)+368.25;
x1d=zeros(1,N);
Ca=zeros(1,N)+0.8;
x2d=zeros(1,N);
Fc=zeros(1,N)+15;
Fa=zeros(1,N)+0.1;
Fs=zeros(1,N)+0.9;
Tc=zeros(1,N)+365;
T0=zeros(1,N)+370;
Caa=zeros(1,N)+19.1;
Cas=zeros(1,N)+0.1;



a1=zeros(1,N);
a2=zeros(1,N);

time=[0,1*T,2*T,3*T];
int_e=zeros(1,N);
error=zeros(1,N);

D5=zeros(1,N);
D6=zeros(1,N);
D7=zeros(1,N);
D8=zeros(1,N);
D9=zeros(1,N);

e=normrnd(0,1,7,N);
mt=normrnd(0,1,9,N);

%%
i=1;
Ca0(i)=(Caa(i)*Fa(i) + Cas(i)*Fs(i))/(Fa(i)+Fs(i));
K0(i)=(1-i*(10^-4))*K0_initial;
x1d(1)=(1/(V*ro*Cp))* ( ro*Cp*(Fa(i)+Fs(i))*(T0(i)-T(i)) - (T(i)-Tc(i))*(a2(i)*a*Fc(i)^(b+1))/(Fc(i)+(a2(i)*a*Fc(i)^b)/(2*ro_c*(CPc))) + (-Delta_H)*V*a1(i)*K0_initial*exp((-E_R/T(i)))*Ca(i) );
x2d(i)=((Fa(i)+Fs(i))/V)*Ca0(i) - ((Fa(i)+Fs(i))/V)*Ca(i) - K0(i)*exp((-E_R/T(i)))*Ca(i);
i=2;
Ca0(i)=(Caa(i)*Fa(i) + Cas(i)*Fs(i))/(Fa(i)+Fs(i));
K0(i)=(1-i*(10^-4))*K0_initial;
x1d(2)=(1/(V*ro*Cp))* ( ro*Cp*Fa(i)*(T0(i)-T(i)) - (T(i)-Tc(i))*(a2(i)*a*Fc(i)^(b+1))/(Fc(i)+(a2(i)*a*Fc(i)^b)/(2*ro_c(CPc))) + (-Delta_H)*V*a1(i)*K0_initial*exp((-E_R/T(i))) *Ca(i));
x2d(i)=(Fa(i)/V)*Ca0(i) - (Fa(i)/V)*Ca(i) - K0(i)*exp((-E_R/T(i)))*Ca(i);


for i=2:N
    
    time(i)=(i-1)*T;
    
    if i>2
    T(i)=T(i-1) + 3*T/2*x1d(i-1) -T/2*x1d(i-2); % T
    Ca(i)=Ca(i-1) + 3*T/2*x2d(i-1) -T/2*x2d(i-2); % Ca
    end
    
    D5(i)=0.9*D5(i) + ((0.19*0.01)^0.5)*e(1,i);
    D6(i)=0.9*D6(i) + ((0.475*0.1)^0.5)*e(2,i);
    D7(i)=0.9*D7(i) + ((0.475*0.1)^0.5)*e(3,i);
    D8(i)=0.9*D8(i) + ((0.475*0.1)^0.5)*e(4,i);
    D9(i)=0.5*D9(i) + ((1.875*0.001)^0.5)*e(5,i);
    
    a1(i)=0.9*a1(i-1)+ e(6,i)*(0.19*0.01)^(0.5);
    a2(i)=0.95*a2(i-1)+ e(7,i)*(0.0975*0.01)^(0.5);

    T(i) =  T(i) + ((4*10^(-4))^0.5)*mt(1,i); 
    Ca(i) =  Ca(i) + ((2.5*10^(-5))^0.5)*mt(2,i); 
    Fc(i) =  Fc(i) + ((1*10^(-2))^0.5)*mt(3,i); % Fc   %feed concentration?
    Fa(i) =  Fa(i) + ((4*10^(-6))^0.5)*mt(4,i); % Fa
    
    Fs(i) = Fs(i) + ((4*10^(-6))^0.5)*mt(5,i) + D5(i); % Fs
    Tc(i) = Tc(i) + ((2.5*10^(-3))^0.5)*mt(6,i) + D6(i); % Tc 
    T0(i) = T0(i) + ((2.5*10^(-3))^0.5)*mt(7,i) + D7(i); % T0
    Caa(i) = Caa(i) + ((1*10^(-2))^0.5)*mt(8,i) + D8(i); % Caa
    Cas(i) = Cas(i) + ((2.5*10^(-5))^0.5)*mt(9,i) + D9(i); % Cas
    
   
    
    %% FAult introduction to the system
    
    if i>2000
    Tc(i) = Tc(i)+2;
    end
% %     
%     if i>2000
%         T0(i) = T0(i) + 5;
%     end

%       if i>2000
%         Fa(i) = Fa(i) + 0.09;
%         Fs(i) = Fs(i) - 0.09;
%     end
        
    
    %% Controller
    error(i)=T(i)-368.25;
    if i>2
    int_e(i)=int_e(i-1) + 3*T/2*error(i-1) - T/2*error(i-2);
    end
    KP=5;
    KI=2.5;
    controller_input(i) = KP*error(i)+ KI*int_e(i);
     
    Fc(i) =Fc(i)+ controller_input(i);
    if (Fc(i)<=0.001)
    Fc(i)=0.001;
    end

    
    %% Dynamic Relations
     Ca0(i)=(Caa(i) * Fa(i) + Cas(i) * Fs(i)) / (Fa(i) + Fs(i));
    
    K0(i)=(1-i*(3*10^-4))*K0_initial;
   
    x1d(i)=(1/(V*ro*Cp))* ( ro*Cp*(Fa(i)+Fs(i))*(T0(i)-T(i))...
        - (T(i)-Tc(i))*((1+a2(i))*a*Fc(i)^(b+1))/(Fc(i)+((1+a2(i))...
        *a*Fc(i)^b)/(2*ro_c*(CPc))) + (-Delta_H)*V*(1+a1(i))...
        *K0(i)*exp((-E_R/T(i)))*Ca(i) );
    
    x2d(i)=((Fa(i)+Fs(i))/V)*Ca0(i) - ((Fa(i)+Fs(i))/V)*Ca(i) - K0(i)*exp((-E_R/T(i)))*Ca(i);

    X(:,i)=[Fc(i);Fa(i);Fs(i);Tc(i);T0(i);Caa(i);Cas(i)];
    Y(:,i)=[T(i);Ca(i)];
end
X=X(:,10:end)-[15;0.1;0.9;365;370;19.1;0.1]*ones(1,size(X,2)-9);
Y=Y(:,10:end)-[368.25;0.8]*ones(1,size(Y,2)-9);
%%
figure()
plot(X(1,:))
legend('T T Outlet Temprature')
figure()
plot(X(2,:))
legend('Ca Flow of A')
figure()
plot(X(3,:))%;hold on;plot(time,controller_input)
legend('Fc Fc','controller_input')
figure()
plot(X(4,:))
legend('Fa FA')
figure()
plot(X(5,:))
legend('Fs Fs')
figure()
plot(X(6,:))
legend('Tc Tc')
figure()
plot(X(7,:))
legend('T0 To')
figure()

