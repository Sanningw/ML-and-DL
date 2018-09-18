% 第8章实例 example_8_2.m
% 用频率采样方法计算FIR滤波器系数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

N = 81;%滤波器长度
f = [0,0.45,0.5,1];%期望滤波器的边沿频率
A = [0,1,0,0];%指定频率点上的幅度响应
h = fir2(N-1,f,A);%计算实际滤波器系数

[H,w]=freqz(h,1);%计算实际滤波器频率响应

figure;
subplot(3,1,1);plot(f,A);grid;%绘图，期望滤波器的幅频响应
xlabel('Normalized Frequency');ylabel('Magnitude response');
subplot(3,1,2);stem(h);grid;%绘图，实际滤波器时域波形
xlabel('n');ylabel('Impulse response of Filter');
subplot(3,1,3);plot(w/pi,abs(H));grid;%绘图，实际滤波器幅频响应
xlabel('Normalized Frequency');ylabel('Magnitude response');



