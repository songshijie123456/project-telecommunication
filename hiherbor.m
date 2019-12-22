clc
clear all
close all
ts = 0.001;
fs = 1/ts;
N = 200;
k = 0:N-1;
t = k*ts;
% ԭʼ�ź�
f1 = 10;
f2 = 70;
% a = cos(2*pi*f1*t);       % ����1
a = 2 + exp(0.2*f1*t);     % ����2
% a = 1./(1+t.^2*50);       % ����3
m = sin(2*pi*f2*t);         % �����ź�
y = a.*m;  % �źŵ���
figure
subplot(241)
plot(t, a)
title('����')
subplot(242)
plot(t, m)
title('�����ź�')
subplot(243)
plot(t, y)
title('���ƽ��')
% �������
% ���ۣ�Hilbert�任������Ч��ȡ���硢��Ƶ�����źŵ�Ƶ�ʵ�
yh = hilbert(y);
aabs = abs(yh);                 % ����ľ���ֵ
aangle = unwrap(angle(yh));     % �������λ
af = diff(aangle)/2/pi;         % �����˲ʱƵ�ʣ���ִ���΢�ּ���
% NFFT = 2^nextpow2(N);
NFFT = 2^nextpow2(1024*4);      % ����դ��ЧӦ
f = fs*linspace(0,1,NFFT);
YH = fft(yh, NFFT)/N;           % Hilbert�任���źŵ�Ƶ��
A = fft(aabs, NFFT)/N;          % �����Ƶ��
subplot(245)
plot(t, aabs,'r', t, a)
title('����ľ���ֵ')
legend('����������', '��ʵ����')
subplot(246)
plot(t, aangle)
title('�����źŵ���λ')
subplot(247)
plot(t(1:end-1), af*fs)
title('�����źŵ�˲ʱƵ��')
subplot(244)
plot(f,abs(YH))
title('ԭʼ�źŵ�Hilbert��')
xlabel('Ƶ��f (Hz)')
ylabel('|YH(f)|')
subplot(248)
plot(f,abs(A))
title('�����Ƶ��')
xlabel('Ƶ��f (Hz)')
ylabel('|A(f)|')