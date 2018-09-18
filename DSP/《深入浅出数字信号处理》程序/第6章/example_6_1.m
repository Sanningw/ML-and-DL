% 第六章实例 example_6_1.m
% 大点数FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

N = 16*1024;%FFT点数

n = 0:N-1;
x = exp(j*0.25*pi.*n)+5*randn(1,N);%输入，被噪声污染的单频复正弦信号

for n1 = 1:N/2   %对输入信号进行组合
    x0(n1) = x(n1)+x(n1+N/2);
    Twi = exp(-j*2*pi/N*(n1-1));
    x1(n1) = (x(n1)-x(n1+N/2))*Twi;
end

n2 = 0:N/2-1;
figure;%绘图，组合后的x0和x1
subplot(1,2,1);plot(n2,real(x0));
xlabel('Number of samples');ylabel('Sample value');
axis([0 N/2+100 -30 30]);grid;
subplot(1,2,2);plot(n2,real(x1));
xlabel('Number of samples');ylabel('Sample value');
axis([0 N/2+100 -30 30]);grid;

X0 = fft(x0);%N/2点的FFT
X1 = fft(x1);%N/2点的FFT

for n1 = 1:N/2  %X0为偶数部分，X1为奇数部分
    Xk(2*n1-1) = X0(n1);
    Xk(2*n1) = X1(n1);
end

Xd = fft(x);%直接计算N点FFT
error = Xk-Xd;%结果误差

figure;%绘图，误差幅度
plot(n,abs(error));
xlabel('Number of samples');ylabel('Error value');grid;
    
