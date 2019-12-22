
%clear;
i=10;%�����ź���Ԫ��
j=5000;
a=round(rand(1,i));%�����������
t=linspace(0,5,j);
f1=10;%�ز�1Ƶ��
f2=5;%�ز�2Ƶ��
fm=i/5;%�����ź�Ƶ��
%���������ź�
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
st2=t;
%�����ź���
for n=1:j
    if st1(n)>=1
        st2(n)=0;
    else
        st2(n)=1;
    end
end
figure(1);
subplot(411);
plot(t,st1);
title('�����ź�st1');
axis([0,5,-1,2]);
subplot(412);
plot(t,st2);
title('�����źŷ���st2');
axis([0,5,-1,2]);
%�ز��ź�
s1=cos(2*pi*f1*t);
s2=cos(2*pi*f2*t);
subplot(413),plot(s1);
title('�ز��ź�s1');
subplot(414),plot(s2);
title('�ز��ź�s2');
%����
F1=st1.*s1;%�����ز�1
F2=st2.*s2;%�����ز�2
figure(2);
subplot(411);
plot(t,F1);
title('F1=s1*st1');
subplot(412);
plot(t,F2);
title('F2=s2*st2');
e_fsk=F1+F2;
subplot(413);
plot(t,e_fsk);
title('2FSK�ź�')%���ط��������ź���������Ԫ֮����λ��һ������
nosie=rand(1,j);
fsk1=e_fsk+nosie;
subplot(414);
plot(t,fsk1);
title('���������ź�')
%��ɽ��
st1=fsk1.*s1;%���ز�1���
[f,sf1] = T2F(t,st1);%ͨ����ͨ�˲���
[t,st1] = lpf(f,sf1,2*fm);
figure(3);
subplot(311);
plot(t,st1);
title('��s1��˺���');
st2=fsk1.*s2;%���ز�2���
[f,sf2] = T2F(t,st2);%ͨ����ͨ�˲���
[t,st2] = lpf(f,sf2,2*fm);
subplot(312);
plot(t,st2);
title('��s2��˺���');
%�����о�
for m=0:i-1
    if st1(1,m*500+250)<st2(1,m*500+250)
       for j=m*500+1:(m+1)*500
           at(1,j)=0;
       end
    else
       for j=m*500+1:(m+1)*500
           at(1,j)=1;
       end
    end
end
subplot(313);
plot(t,at);
axis([0,5,-1,2]);
title('�����о�����')
ma=mean(e_fsk);
an=e_fsk/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000
%yyy=[];
yyy=[yyy ymax];

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

