clc
clear all
close all
ts = 0.001;
fs = 1/ts;
N = 200;
k = 0:N-1;
t = k*ts;
% 原始信号
f1 = 10;
f2 = 70;
% a = cos(2*pi*f1*t);       % 包络1
a = 2 + exp(0.2*f1*t);     % 包络2
% a = 1./(1+t.^2*50);       % 包络3
m = sin(2*pi*f2*t);         % 调制信号
y = a.*m;  % 信号调制
figure
subplot(241)
plot(t, a)
title('包络')
subplot(242)
plot(t, m)
title('调制信号')
subplot(243)
plot(t, y)
title('调制结果')
% 包络分析
% 结论：Hilbert变换可以有效提取包络、高频调制信号的频率等
yh = hilbert(y);
aabs = abs(yh);                 % 包络的绝对值
aangle = unwrap(angle(yh));     % 包络的相位
af = diff(aangle)/2/pi;         % 包络的瞬时频率，差分代替微分计算
% NFFT = 2^nextpow2(N);
NFFT = 2^nextpow2(1024*4);      % 改善栅栏效应
f = fs*linspace(0,1,NFFT);
YH = fft(yh, NFFT)/N;           % Hilbert变换复信号的频谱
A = fft(aabs, NFFT)/N;          % 包络的频谱
subplot(245)
plot(t, aabs,'r', t, a)
title('包络的绝对值')
legend('包络分析结果', '真实包络')
subplot(246)
plot(t, aangle)
title('调制信号的相位')
subplot(247)
plot(t(1:end-1), af*fs)
title('调制信号的瞬时频率')
subplot(244)
plot(f,abs(YH))
title('原始信号的Hilbert谱')
xlabel('频率f (Hz)')
ylabel('|YH(f)|')
subplot(248)
plot(f,abs(A))
title('包络的频谱')
xlabel('频率f (Hz)')
ylabel('|A(f)|')