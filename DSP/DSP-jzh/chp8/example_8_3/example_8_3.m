% 第8章实例 example_8_3.m
% 用最优化方法计算FIR滤波器系数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

fs = 44100;%采样频率
N = 147;%滤波器长度

%低通滤波器设计
wlpe = 2*pi*600/fs;%通带边沿频率
wlse = 2*pi*1400/fs;%阻带边沿频率

fl = [0,wlpe/pi,wlse/pi,1];%滤波器给定的边沿频率
Al = [1,1,0,0];%理想滤波器指定频率点上的幅度响应
hl = remez(N-1,fl,Al);%计算低通滤波器系数 
[HL f]=freqz(hl,1,44100,fs);%计算低通滤波器幅频响应

%高通滤波器设计
whpe = 2*pi*1400/fs;%通带边沿频率
whse = 2*pi*600/fs;%阻带边沿频率

fh = [0,whse/pi,whpe/pi,1];%滤波器给定的边沿频率
Ah = [0,0,1,1];%理想滤波器指定频率点上的幅度响应
hh = remez(N-1,fh,Ah);%计算高通滤波器系数 
[HH f]=freqz(hh,1,44100,fs);%计算高通滤波器幅频响应


figure;%绘图，滤波器时域及频域波形
subplot(2,2,1);stem(hl);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(2,2,2);semilogx(f,20*log10(abs(HL)));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(2,2,3);stem(hh);grid;
xlabel('n');ylabel('Impulse response of HPF');
subplot(2,2,4);semilogx(f,20*log10(abs(HH)));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');



