% ������ʵ�� example_6_1.m
% �����FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

N = 16*1024;%FFT����

n = 0:N-1;
x = exp(j*0.25*pi.*n)+5*randn(1,N);%���룬��������Ⱦ�ĵ�Ƶ�������ź�

for n1 = 1:N/2   %�������źŽ������
    x0(n1) = x(n1)+x(n1+N/2);
    Twi = exp(-j*2*pi/N*(n1-1));
    x1(n1) = (x(n1)-x(n1+N/2))*Twi;
end

n2 = 0:N/2-1;
figure;%��ͼ����Ϻ��x0��x1
subplot(1,2,1);plot(n2,real(x0));
xlabel('Number of samples');ylabel('Sample value');
axis([0 N/2+100 -30 30]);grid;
subplot(1,2,2);plot(n2,real(x1));
xlabel('Number of samples');ylabel('Sample value');
axis([0 N/2+100 -30 30]);grid;

X0 = fft(x0);%N/2���FFT
X1 = fft(x1);%N/2���FFT

for n1 = 1:N/2  %X0Ϊż�����֣�X1Ϊ��������
    Xk(2*n1-1) = X0(n1);
    Xk(2*n1) = X1(n1);
end

Xd = fft(x);%ֱ�Ӽ���N��FFT
error = Xk-Xd;%������

figure;%��ͼ��������
plot(n,abs(error));
xlabel('Number of samples');ylabel('Error value');grid;
    
