% clc
% clear
%t = -0.04:1.e-4:0.04;

Ta = 0.01;
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
            st1(m)=0;
        end
     elseif(a([1 2],n)==[0;1])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=1;
        end
     elseif(a([1 2],n)==[1;0])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=2;
        end
     elseif(a([1 2],n)==[1;1])
        for m=j/i*(n-1)+1:j/i*n
            st1(m)=3;
        end
       end
   subplot(3,1,1);

end
mu1 = 1 - abs((st1+Ta)/Ta);


mu2 = 1 - abs((st1-Ta)/Ta);


m2 = mu1-mu2;

m1 = sinc(2*st1/Ta) + 2*sinc(2*st1/Ta+1) + sinc(2*st1/Ta-1);
f = 400;                        % Frquency of carrier wave

c1 = cos(2*f*pi*st1);
c2 = cos(2*f*pi*st1 - pi/2);

% ========== %
% MODULATION %
% ========== %
qam =  2*m1.*c1 + 2*m2.*c2;                                   
subplot(3,1,1);plot(t,qam);
ma=mean(qam);
an=qam/ma;
dft=fft(an-1);
ymax=max(dft.*dft)/5000;

yyy=[yyy ymax]; 

