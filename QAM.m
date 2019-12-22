                                % =============================== %
                                % QUADRATURE AMPLITUDE MODULATION %
                                % =============================== %
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
t = -0.04:1.e-4:0.04;
t1 = -0.02:1.e-4:0;
t2 = 0:1.e-4:0.02;
Ta = 0.01;

mu1 = 1 - abs((t1+Ta)/Ta);
mu1 = [zeros([1 200]),mu1,zeros([1 400])];
mu2 = 1 - abs((t2-Ta)/Ta);
mu2 = [zeros([1 400]),mu2,zeros([1 200])];

m2 = mu1 - mu2;

m1 = sinc(2*t/Ta) + 2*sinc(2*t/Ta+1) + sinc(2*t/Ta-1);

f = 400;                        % Frquency of carrier wave

c1 = cos(2*f*pi*t);
c2 = cos(2*f*pi*t - pi/2);

% ========== %
% MODULATION %
% ========== %
qam =  2*m1.*c1 + 2*m2.*c2;                                   

% ==================================== %
% De-Modulation By Synchoronous Method %
% ==================================== %
dem1 = qam.*c1;
dem2 = qam.*c2;

% ====================
% Filtering Using LPF
% ====================
a = fir1(50,10*1.e-4);
b = 1;

rec1 = filter(a,b,dem1);
rec2 = filter(a,b,dem2);

% ================================
% Frequency Responce by fft method
% ================================
fl = length(t);
fl = 2^ceil(log2(fl));
f = (-fl/2:fl/2-1)/(fl*1.e-4);
m1F = fftshift(fft(m1,fl));                             % Frequency Responce of Message Signal - 1 
m2F = fftshift(fft(m2,fl));                             % Frequency Responce of Message Signal - 2
qamF = fftshift(fft(qam,fl));                           % Frequency Responce of QAM
rec1F = fftshift(fft(rec1,fl));                         % Frequency Responce of Recovered Message Signal - 1
rec2F = fftshift(fft(rec2,fl));                         % Frequency Responce of Recovered Message Signal - 2

% =============================
% Ploting signal in time domain
% =============================
figure(1);

subplot(3,2,1);
plot(t,m1);
title('Message 1');
xlabel('{\it t} (sec)');
ylabel('m-1(t)');
grid;

subplot(3,2,2);
plot(t,m2);
title('Message 2');
xlabel('{\it t} (sec)');
ylabel('m-2(t)');
grid;

subplot(3,2,[3 4]);
plot(t,qam);
title('QAM');
xlabel('{\it t} (sec)');
ylabel('QAM');
grid;

subplot(3,2,5);
plot(t,rec1);
xlabel('{\it t} (sec)');
ylabel('m-1(t)');
title('Recovered Signal 1');
grid;

subplot(3,2,6);
plot(t,rec2);
xlabel('{\it t} (sec)');
ylabel('m-2(t)');
title('Recovered Signal 2');
grid;

% ================================
% Ploting Freq Responce of Signals
% ================================

figure(2);
subplot(3,2,1);
plot(f,abs(m1F));
title('Freq Responce of Message Signal 1');
xlabel('f(Hz)');
ylabel('M-1(f)');
grid;
axis([-600 600 0 200]);

subplot(3,2,2);                                         % Ploting Freq Responce of Signals
plot(f,abs(m2F));
title('Freq Responce of Message Signal 1');
xlabel('f(Hz)');
ylabel('M-2(f)');
grid;
axis([-600 600 0 200]);


subplot(3,2,[3 4]);
plot(f,abs(qamF));
title('Freq Responce of QAM');
xlabel('f(Hz)');
ylabel('QAM(f)');
grid;
axis([-600 600 0 400]);

subplot(3,2,5);
plot(f,abs(rec1F));
title('Freq Responce of Recoverd Signal');
xlabel('f(Hz)');
ylabel('M-1(f)');
grid;
axis([-600 600 0 200]);

subplot(3,2,6);
plot(f,abs(rec2F));
title('Freq Responce of Recoverd Signal');
xlabel('f(Hz)');
ylabel('M-2(f)');
grid;
axis([-600 600 0 200]);


% ==================================== %
% PROGRAMMED BY SHEIKH MUKHTAR HUSSAIN %
%     IN CASE OF ANY PROBLEM CONTACT   %
%       mh_shiningstar@hotmail.com     %
% ==================================== %