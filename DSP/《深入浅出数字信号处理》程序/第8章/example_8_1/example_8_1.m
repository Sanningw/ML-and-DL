% 第8章实例 example_8_1.m
% 用窗函数方法计算FIR滤波器系数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

fs = 44100;%采样频率
wc = 2*pi*1000/fs;%截止频率

N = 183;%滤波器长度
hl = fir1(N-1,wc/pi);%计算低通滤波器系数
hh = fir1(N-1,wc/pi,'high',Hamming(N));%计算高通滤波器系数

figure;%绘图，低通和高通滤波器时域波形
subplot(2,1,1);stem(hl);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(2,1,2);stem(hh);grid;
xlabel('n');ylabel('Impulse response of HPF');

save('hl.dat', 'hl', '-ascii');%保存低通滤波器系数
save('hh.dat', 'hh', '-ascii');%保存高通滤波器系数

[HL f]=freqz(hl,1,44100,fs);%计算低通滤波器幅频响应
[HH f]=freqz(hh,1,44100,fs);%计算高通滤波器幅频响应

figure;%绘图，低通和高通滤波器幅频响应
subplot(2,1,1);semilogx(f,20*log10(HL));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(2,1,2);semilogx(f,20*log10(HH));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');


