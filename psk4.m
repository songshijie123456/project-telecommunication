clf
clc
clear
T=1;
M=4;
fc=1/T;
N=500;
delta_T=T/(N-1);
input=[0 1 0 1 1 0 0 0 1 1 0 1 0 0];
input1=reshape(input,2,7);%变成2行7列
t=0:delta_T:T;
for i=1:7
hold on
if input1([1 2],i)==[0;0]
u=cos(2*pi*fc*t);plot(t,u)
elseif input1([1 2],i)==[1;0]
u=cos(2*pi*fc*t+2*pi/M);plot(t,u)
elseif input1([1 2],i)==[1;1]
u=cos(2*pi*fc*t+4*pi/M);plot(t,u)
elseif input1([1 2],i)==[0;1]
u=cos(2*pi*fc*t+6*pi/M);plot(t,u)
end
t=t+T;
end
hold off
