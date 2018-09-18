% 第四章实例 example_4_2.m
% 雷达测距
% 包括雷达数据的仿真
% 最佳检测系统的输出
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clear all;

c0 = 3e8;%光速
fs = 40e6;ts = 1/fs;%采样频率和采样周期
fc = 10e6;%雷达中频频率
tr = 1e-4;%脉冲重复周期
M = 400;
tao = M*ts;%脉冲宽度
D = 1500;d = D*ts;%延迟时间
R = 0.5*c0*d;%目标距离
A = 0.01;%衰减系数

t = 0:ts:tr;
N = length(t);
rect1 = [ones(1,M),zeros(1,N-M)];
st = rect1.*cos(2*pi*fc.*t);%发射信号，中频

rect2 = [zeros(1,D),ones(1,M),zeros(1,N-M-D)];
s = A*rect2.*cos(2*pi*fc.*(t-d));%回波信号，中频
v = A/2*randn(1,N);%回波噪声
x = s+v;%雷达回波

figure;%绘图，输入音频信号的时域和频域波形
subplot(2,1,1);plot(st);
xlabel('Number of samples');ylabel('Transmitted signal');grid;
subplot(2,1,2); plot(x);
xlabel('Number of samples');ylabel('Received signal');grid;

y = xcorr(x,st);%最佳接收系统的输出

figure;
m = -(N-1):(N-1);plot(m,y);
xlabel('Delay Samples');ylabel('Correlation Output');grid;

