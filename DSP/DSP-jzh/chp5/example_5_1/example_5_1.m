% 第五章实例 example_5_1.m
% 连续波雷达测速
% 包括连续波雷达回波数据仿真
% 利用DFT分析回波频谱，得到目标速度值
% 多目标情况下的速度分辨率
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;


c0 = 3e8;%光速
fs = 0.25e6;ts = 1/fs;%采样频率和采样周期
f0 = 10e9;%雷达载频
lumbda = c0/f0;%雷达工作波长
T = 4e-3;%回波持续时间
R = 8e3;%目标距离
v1 = 300;%目标速度
fd1 = 2*v1/lumbda;%多普勒频率
v2 = 306;
fd2 = 2*v2/lumbda;%多普勒频率
v3 = 360;
fd3 = 2*v3/lumbda;%多普勒频率
A = 0.01;%衰减系数

t = 0:ts:T-ts;
N = length(t);
s1 = A*exp(j*(2*pi*fd1.*t-4*pi*R/lumbda));%单目标回波信号，零中频
s2 = A*(exp(j*(2*pi*fd1.*t-4*pi*R/lumbda))...
    +exp(j*(2*pi*fd2.*t-4*pi*R/lumbda))...
    +exp(j*(2*pi*fd3.*t-4*pi*R/lumbda)));%多目标回波信号，零中频
vr = A/0.5*randn(1,N);%回波噪声实部
vi = A/0.5*randn(1,N);%回波噪声虚部
x1 = s1+vr+j*vi;%单目标雷达回波
x2 = s2+vr+j*vi;%多目标雷达回波


X1 = fft(x1);%计算DFT
magX1 = abs(X1)/max(abs(X1));%幅度
phaX1 = angle(X1);%相位

X2 = fft(x2);%计算DFT
magX2 = abs(X2)/max(abs(X2));%幅度
phaX2 = angle(X2);%相位

w_ham = hamming(N);w_ham = w_ham.';
X2w = fft(x2.*w_ham);%加海明窗，计算DFT
magX2w = abs(X2w)/max(abs(X2w));%幅度
phaX2w = angle(X2w);%相位

n = 0:N-1
figure;
subplot(1,2,1),plot(n,real(x1));
xlabel('Number of samples');ylabel('Received signal');grid;
subplot(1,2,2),plot(n,20*log10(magX1));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;

figure;plot(n,20*log10(magX2));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;

figure;plot(n,20*log10(magX2w));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;




