% close all
% clear;
% clc;
i=10;%10个码元
j=5000;
t=linspace(0,5,j);%0-5之间产生5000个点行矢量，即分成5000 
fc=10;%载波频率
fm=i/5;%码元速率
%产生基带信号
x=(rand(1,i));%rand函数产生在0-1之间随机数，共1-10个
figure(2)
plot(x)
a=round(x);%随机序列，round取最接近小数的整数
figure(3)
stem(a)%火柴梗状图
st=t;
for n=1:10                      %生成基带信号也就是随机0，1组合
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n
            st(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st(m)=1;
        end
    end
end     
figure(1);
subplot(421);
plot(t,st);
axis([0,5,-1,2]);
title('基带信号st');
%载波
s1=cos(2*pi*fc*t);
subplot(422);
plot(s1);
title('载波信号s1');
%调制
e_2ask=st.*s1;
subplot(423);
plot(t,e_2ask);
title('已调信号');
noise =rand(1,j);
e_2ask=e_2ask+noise;%加入噪声
subplot(424);
plot(t,e_2ask);
title('加入噪声的信号');
%相干解调
at=e_2ask.*cos(2*pi*fc*t);
at=at-mean(at);%因为是单极性波形，还有直流分量，应去掉
subplot(425);
plot(t,at);
title('与载波相乘后信号');
[f,af] = T2F(t,at);%通过低通滤波器
[t,at] = lpf(f,af,2*fm);
subplot(426);
plot(t,at);
title('相干解调后波形');
%抽样判决
for m=0:i-1
    if at(1,m*500+250)+0.5<0.5
       for j=m*500+1:(m+1)*500
           at(1,j)=0;
       end
    else
       for j=m*500+1:(m+1)*500
           at(1,j)=1;
       end
    end
end
subplot(427);
plot(t,at);
axis([0,5,-1,2]);
title('抽样判决后波形')
ma=mean(e_2ask);
an=e_2ask/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000
ooks=[]
ooks=[ooks ymax];
function [f,sf]= T2F(t,st)
dt = t(2)-t(1);
T=t(end);
df = 1/T;
N = length(st);
f=-N/2*df:df:N/2*df-df;
    sf = fft(st);
sf = T/N*fftshift(sf);
end
function [t,st]=lpf(f,sf,B)
df = f(2)-f(1);
T = 1/df;
hf = zeros(1,length(f));%全零矩阵
bf = [-floor( B/df ): floor( B/df )] + floor( length(f)/2 );
hf(bf)=1;
yf=hf.*sf;
[t,st]=F2T(f,yf);
st = real(st);
end
%脚本文件F2T.m定义了函数F2T，计算信号的反傅立叶变换。
function [t,st]=F2T(f,sf)
%This function calculate the time signal using ifft function for the input
%signal's spectrum
 df = f(2)-f(1);
Fmx = ( f(end)-f(1) +df);
dt = 1/Fmx;
N = length(sf);
T = dt*N;
%t=-T/2:dt:T/2-dt;
t = 0:dt:T-dt;
sff = fftshift(sf);
st = Fmx*ifft(sff);
end

