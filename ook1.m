% close all
% clear;
% clc;
i=10;%10����Ԫ
j=5000;
t=linspace(0,5,j);%0-5֮�����5000������ʸ�������ֳ�5000 
fc=10;%�ز�Ƶ��
fm=i/5;%��Ԫ����
%���������ź�
x=(rand(1,i));%rand����������0-1֮�����������1-10��
figure(2)
plot(x)
a=round(x);%������У�roundȡ��ӽ�С��������
figure(3)
stem(a)%���״ͼ
st=t;
for n=1:10                      %���ɻ����ź�Ҳ�������0��1���
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
title('�����ź�st');
%�ز�
s1=cos(2*pi*fc*t);
subplot(422);
plot(s1);
title('�ز��ź�s1');
%����
e_2ask=st.*s1;
subplot(423);
plot(t,e_2ask);
title('�ѵ��ź�');
noise =rand(1,j);
e_2ask=e_2ask+noise;%��������
subplot(424);
plot(t,e_2ask);
title('�����������ź�');
%��ɽ��
at=e_2ask.*cos(2*pi*fc*t);
at=at-mean(at);%��Ϊ�ǵ����Բ��Σ�����ֱ��������Ӧȥ��
subplot(425);
plot(t,at);
title('���ز���˺��ź�');
[f,af] = T2F(t,at);%ͨ����ͨ�˲���
[t,at] = lpf(f,af,2*fm);
subplot(426);
plot(t,at);
title('��ɽ������');
%�����о�
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
title('�����о�����')
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
hf = zeros(1,length(f));%ȫ�����
bf = [-floor( B/df ): floor( B/df )] + floor( length(f)/2 );
hf(bf)=1;
yf=hf.*sf;
[t,st]=F2T(f,yf);
st = real(st);
end
%�ű��ļ�F2T.m�����˺���F2T�������źŵķ�����Ҷ�任��
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

