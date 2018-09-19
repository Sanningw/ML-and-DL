% 第五章实例 example_5_2.m
% 股票市场移动平均线
% 用DFT计算线性卷积
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clear all;clc;

x = load('stockSH.txt','-ascii');%导入输入数据
M = length(x);

L = 10;
h = 1/L*ones(L,1);%生成滑动平均滤波器

m = 0:M-1;
l = 0:L-1;

figure;%绘图，输入数据和滤波器单位冲激响应
subplot(1,2,1);plot(m,x,'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');
subplot(1,2,2);plot(l,h,'-o');
xlabel('Number of samples');ylabel('Sample Value');
axis([0,L,0,0.16]);grid;

N = M+L-1;
X = fft(x,N);%计算输入数据N点DFT
magX = abs(X);
phaX = angle(X);
H = fft(h,N);%计算滤波器N点DFT
magH = abs(H);
phaH = angle(H);

n = 0:N-1;
figure;%绘图，补零后输入和系统的频谱
subplot(2,2,1);plot(n,magX,'-o');grid;
xlabel('Number of samples');ylabel('Amplitude');
subplot(2,2,2);plot(n,phaX,'-o');grid;
xlabel('Number of samples');ylabel('Phase');
subplot(2,2,3);plot(n,magH,'-o');grid;
xlabel('Number of samples');ylabel('Amplitude');
subplot(2,2,4);plot(n,phaH,'-o');grid;
xlabel('Number of samples');ylabel('Phase');

Y = X.*H;%频域相乘

y = ifft(Y);%计算逆DFT

n1 = L-1:M-1;
figure;%绘图，移动平均线
subplot(1,2,1);plot(n,y,'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');
subplot(1,2,2);plot(n1,y(n1+1),'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');







