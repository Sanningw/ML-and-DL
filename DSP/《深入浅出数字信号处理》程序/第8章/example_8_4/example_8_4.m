% 第八章实例 example_8_4.m
% 音频信号的噪声消除
% 包括FIR滤波器的系数计算
% 窗函数方法
% 音频信号通过所设计的滤波器
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

[s,fs,B] = wavread('music.wav');% 读取音频信号

Ts = 1/fs;%采样周期
M = length(s);%音频信号长度

m = 0:M-1;
sigma = mean(s.*s);%噪声方差
v = sqrt(sigma)*randn([M,1]);%噪声生成
x = s+v;%受宽带噪声干扰的音频信号
f=[0:M/2]*fs/M;
X = fft(x);
magX = abs(X);%受噪声污染音频信号的频谱

figure;%绘图，受噪声污染信号的时域和频域波形
subplot(2,1,1);plot(m,x);
xlabel('Number of samples');ylabel('Sample value x(n)');
axis([0 M+100 -1.5 1.5]);grid;
subplot(2,1,2); semilogx(f,magX(1:M/2+1));
xlabel('Frequency (Hz)'); ylabel('Amplitude |X(f)| ');
axis([0 max(f)+100*fs/M 0 2500]);grid;

% 窗函数方法计算滤波器系数
wc=2*pi*2000/fs;%截止频率
Nwin = 147;%滤波器长度
hwin = fir1(Nwin-1,wc/pi);%计算低通滤波器系数;
[Hwin f1]=freqz(hwin,1,44100,fs);%计算低通滤波器频率响应
magHwin = abs(Hwin);%幅频响应
phaHwin = angle(Hwin);%相频响应
phaHwin = 180*unwrap(phaHwin)/pi;
nwin = 0:Nwin-1;

figure;%绘图，低通滤波器特性
subplot(3,1,1);stem(nwin,hwin);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(3,1,2);semilogx(f1,20*log10(magHwin));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(3,1,3);plot(f1,phaHwin);grid;
xlabel('Frequency (Hz)');ylabel('Phase response (degree)');


% 滤波之后的信号
y = filter(Hwin,1,x);%滤波
Y = fft(y);
magY = abs(Y);%滤波后信号的频谱

figure;%绘图，滤波后信号的时域和频域波形
subplot(2,1,1); plot(m,y);
xlabel('Number of samples');ylabel('Sample value y(n)');grid;
subplot(2,1,2); semilogx(f,magY(1:M/2+1));
xlabel('Frequency (Hz)'); ylabel('Amplitude |Y(f)| ');grid;


