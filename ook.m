
% t=0:0.01:23;
% y1=0.5*(square(t)+1);
% x=cos(3*pi*t);
% y2=x.*y1;
% y3=fft(y2);
% subplot(3,1,1);plot(t,y1);
% subplot(3,1,2);plot(t,y3);
% subplot(3,1,3);plot(t,y2);
clear
clc
Fc=10;                                 
Fs=40;                                 %系统采样频率
Fd=1;                                  %码速率
N=Fs/Fd;                               %数据长度
df=10;                                 %频率间隙
numSymb=25;                          %进行仿真的信息代码个数
M=2;                                  %进制数
SNRpBit=60;                           %信噪比
SNR=SNRpBit/log2(M);                  %信噪比转换
seed=[12345 54321]; 
numPlot=25;                            %产生25个二进制随机码
x=randsrc(numSymb,1,[0:M-1]);            %产生25个二进制随机码
y=dmod(x,Fc,Fd,Fs,'fsk',M,df);             %进行FSK调制
numModPlot=numPlot*Fs;                %时间轴显示的长度
t=[0:numModPlot-1]./Fs;                  %时间轴与数字序列轴对应
figure(1)
stairs(x);                               %显示二进制随机序列
axis([0 25 -0.5 1.5]);                     %设置横纵坐标范围
title('二进制随机序列')                   %将图形命名
xlabel('Time');                           %定义x轴为时间轴
ylabel('Amplitude');                      %定义y轴表示幅度
figure(2)
plot(t,y(1:length(t)),'b-');                    %显示第二个图
axis([min(t) max(t) -1.5 1.5]);               %设置横纵坐标范围
title('调制后的信号')                  %将图形命名
figure(3)
z1=ddemod(y,Fc,Fd,Fs,'fsk',M,df);              %相干解调
stairs(z1);                                  %显示相干解调后的信号
axis([min(t) max(t) -0.5 1.5]);               %设置横纵坐标范围
title('相干解调后的信号')                     %将图形命名
xlabel('Time');                              %定义x轴为时间轴
ylabel('Amplitude');                          %定义y轴表示幅度    
L=length(z1);                               %相干解调后的信号长度
m=fft(z1,L);                           %对相干解调后进行傅立叶变换
f=(0:(L-1))*Fs/L-Fs/2;                       %频率矢量
figure(4);                                  %显示图形5
plot(f,abs(m));                              %显示已调信号的频谱图
xlabel('f');                                  %定义x轴为频率轴
ylabel('幅度');                               %定义y轴表示幅度
title('相干解调后的信号频谱图');               %将图形命名


