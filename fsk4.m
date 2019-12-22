% clear;
% clc;
i=50;%基带信号码元数
j=5000;
a1=round(rand(1,i));%产生随机序列
t=linspace(0,5,j);
f1=10;%载波1频率
f2=5;%载波2频率
fm=i/5;%基带信号频率
%产生基带信号
st1=t;
a=reshape(a1,2,25);
i=25;
for n=1:25
     if (a([1 2],n)==[0;0])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=1;
        end
     elseif(a([1 2],n)==[0;1])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=2;
        end
     elseif(a([1 2],n)==[1;0])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=3;
        end
     elseif(a([1 2],n)==[1;1])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=4;
        end
       end
    subplot(3,1,1);

end
st2=t;
plot(t,st1);
%s1=cos(2*pi*f1*t+st1.*t*f1*pi/8);
s1=cos(15*2*pi*st1.*t*15);
subplot(3,1,2);
plot(t,s1);axis([0 1.5 -6 6]);
y1=fft(st1);
subplot(3,1,3);
bar(abs(fftshift(y1)));
ma=mean(s1);
an=s1/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000;
%yyy=[];
yyy=[yyy ymax];




