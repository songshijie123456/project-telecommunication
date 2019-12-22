%clear all��
i=10;
j=5000;
fc=4;%�ز�Ƶ��
fm=i/5;%��Ԫ����
B=2*fm;
t=linspace(0,5,j);
%%%%%%%%%%���������ź�
a=round(rand(1,i));%�������,�����ź�
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
title('�����ź�st1');
axis([0,5,-1,2]);
%�����ź���
%����PSK�е���˫�����źţ���˶��������󵥼����ź�ȡ������֮һ�𹹳�˫������
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
title('�����źŷ���st2');
axis([0,5,-1,2]);
st3=st1-st2;
subplot(413);
plot(t,st3);
title('˫���Ի����ź�st3');
axis([0,5,-2,2]);
%�ز��ź�
s1=sin(2*pi*fc*t);
subplot(414);
plot(s1);
title('�ز��ź�s1');
%����
e_psk=st3.*s1;
figure(2);
subplot(511);
plot(t,e_psk);
title('e_2psk');
noise=rand(1,j);
psk1=e_psk+noise;%��������
subplot(512);
plot(t,psk1);
title('�������');
%��ɽ��
psk1=psk1.*s1;%���ز����
subplot(513);
plot(t,psk1);
title('���ز�s1��˺���');
[f,af] = T2F(t,psk1);%%%%%%%%%%%ͨ����ͨ�˲���
[t,psk1] = lpf(f,af,B);
subplot(514);
plot(t,psk1);
title('��ͨ�˲�����');
%�����о�
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
title('�����о�����')
ma=mean(e_psk);
an=e_psk/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000


%yyy=[];
yyy= [yyy ymax];
%����FFT�����źŵ�Ƶ�ײ����źŵ���ʵƵ�׵ĳ����Ƚϡ�
%�ű��ļ�T2F.m�����˺���T2F�������źŵĸ���Ҷ�任��
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
