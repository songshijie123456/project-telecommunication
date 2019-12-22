
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
Fs=40;                                 %ϵͳ����Ƶ��
Fd=1;                                  %������
N=Fs/Fd;                               %���ݳ���
df=10;                                 %Ƶ�ʼ�϶
numSymb=25;                          %���з������Ϣ�������
M=2;                                  %������
SNRpBit=60;                           %�����
SNR=SNRpBit/log2(M);                  %�����ת��
seed=[12345 54321]; 
numPlot=25;                            %����25�������������
x=randsrc(numSymb,1,[0:M-1]);            %����25�������������
y=dmod(x,Fc,Fd,Fs,'fsk',M,df);             %����FSK����
numModPlot=numPlot*Fs;                %ʱ������ʾ�ĳ���
t=[0:numModPlot-1]./Fs;                  %ʱ�����������������Ӧ
figure(1)
stairs(x);                               %��ʾ�������������
axis([0 25 -0.5 1.5]);                     %���ú������귶Χ
title('�������������')                   %��ͼ������
xlabel('Time');                           %����x��Ϊʱ����
ylabel('Amplitude');                      %����y���ʾ����
figure(2)
plot(t,y(1:length(t)),'b-');                    %��ʾ�ڶ���ͼ
axis([min(t) max(t) -1.5 1.5]);               %���ú������귶Χ
title('���ƺ���ź�')                  %��ͼ������
figure(3)
z1=ddemod(y,Fc,Fd,Fs,'fsk',M,df);              %��ɽ��
stairs(z1);                                  %��ʾ��ɽ������ź�
axis([min(t) max(t) -0.5 1.5]);               %���ú������귶Χ
title('��ɽ������ź�')                     %��ͼ������
xlabel('Time');                              %����x��Ϊʱ����
ylabel('Amplitude');                          %����y���ʾ����    
L=length(z1);                               %��ɽ������źų���
m=fft(z1,L);                           %����ɽ������и���Ҷ�任
f=(0:(L-1))*Fs/L-Fs/2;                       %Ƶ��ʸ��
figure(4);                                  %��ʾͼ��5
plot(f,abs(m));                              %��ʾ�ѵ��źŵ�Ƶ��ͼ
xlabel('f');                                  %����x��ΪƵ����
ylabel('����');                               %����y���ʾ����
title('��ɽ������ź�Ƶ��ͼ');               %��ͼ������


