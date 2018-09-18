% 第三章实例 example_3_1.m
% 混响系统的分析，包括零极图，单位冲激响应和频率响应
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all;

a = 0.83; b = 0.08; L = 10;%混响系统参数

B = [zeros(1,L),a,-a*b];%传递函数分母多项式
A = [1,-b,zeros(1,L-2),-a*(1-b)];%传递函数分子多项式

zplane(B,A);%分析系统的零极点


N = 256;
x = [1,zeros(1,N-1)];%长度为N的单位冲激函数
h = filter(B,A,x);%计算单位冲激响应
figure;plot(h);

w = [0:0.5:100]*pi/100;
H = freqz(B,A,w);%计算系统的频率响应
magH = abs(H);%计算幅频响应
phaH = angle(H);%计算相频响应
figure;plot(w/pi,magH);figure; plot(w/pi,phaH);



