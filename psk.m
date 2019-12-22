%clear all；
i=10;
j=5000;
fc=4;%载波频率
fm=i/5;%码元速率
B=2*fm;
t=linspace(0,5,j);
%%%%%%%%%%产生基带信号
a=round(rand(1,i));%随机序列,基带信号
figure(3);
stem(a);
st1=t;
for n=1:10
    if a(n)<1
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=0;
        end
    else
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=1;
        end
    end
end
figure(1);
subplot(411);
plot(t,st1);
title('基带信号st1');
axis([0,5,-1,2]);
%基带信号求反
%由于PSK中的是双极性信号，因此对上面所求单极性信号取反来与之一起构成双极性码
st2=t;               
for k=1:j
    if st1(k)>=1
        st2(k)=0;
    else
        st2(k)=1;
    end
end
subplot(412);
plot(t,st2);
title('基带信号反码st2');
axis([0,5,-1,2]);
st3=st1-st2;
subplot(413);
plot(t,st3);
title('双极性基带信号st3');
axis([0,5,-2,2]);
%载波信号
s1=sin(2*pi*fc*t);
subplot(414);
plot(s1);
title('载波信号s1');
%调制
e_psk=st3.*s1;
figure(2);
subplot(511);
plot(t,e_psk);
title('e_2psk');
noise=rand(1,j);
psk1=e_psk+noise;%加入噪声
subplot(512);
plot(t,psk1);
title('加噪后波形');
%相干解调
psk1=psk1.*s1;%与载波相乘
subplot(513);
plot(t,psk1);
title('与载波s1相乘后波形');
[f,af] = T2F(t,psk1);%%%%%%%%%%%通过低通滤波器
[t,psk1] = lpf(f,af,B);
subplot(514);
plot(t,psk1);
title('低通滤波后波形');
%抽样判决
for m=0:i-1
    if psk1(1,m*500+250)<0
       for j=m*500+1:(m+1)*500
            psk1(1,j)=0;
       end
    else
       for j=m*500+1:(m+1)*500
           psk1(1,j)=1;
       end
    end
end
subplot(515);
plot(t,psk1);
axis([0,5,-1,2]);
title('抽样判决后波形')
ma=mean(e_psk);
an=e_psk/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000


%yyy=[];
yyy= [yyy ymax];
%利用FFT计算信号的频谱并与信号的真实频谱的抽样比较。
%脚本文件T2F.m定义了函数T2F，计算信号的傅立叶变换。
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
