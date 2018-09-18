% �ڰ���ʵ�� example_8_4.m
% ��Ƶ�źŵ���������
% ����FIR�˲�����ϵ������
% ����������
% ��Ƶ�ź�ͨ������Ƶ��˲���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

[s,fs,B] = wavread('music.wav');% ��ȡ��Ƶ�ź�

Ts = 1/fs;%��������
M = length(s);%��Ƶ�źų���

m = 0:M-1;
sigma = mean(s.*s);%��������
v = sqrt(sigma)*randn([M,1]);%��������
x = s+v;%�ܿ���������ŵ���Ƶ�ź�
f=[0:M/2]*fs/M;
X = fft(x);
magX = abs(X);%��������Ⱦ��Ƶ�źŵ�Ƶ��

figure;%��ͼ����������Ⱦ�źŵ�ʱ���Ƶ����
subplot(2,1,1);plot(m,x);
xlabel('Number of samples');ylabel('Sample value x(n)');
axis([0 M+100 -1.5 1.5]);grid;
subplot(2,1,2); semilogx(f,magX(1:M/2+1));
xlabel('Frequency (Hz)'); ylabel('Amplitude |X(f)| ');
axis([0 max(f)+100*fs/M 0 2500]);grid;

% ���������������˲���ϵ��
wc=2*pi*2000/fs;%��ֹƵ��
Nwin = 147;%�˲�������
hwin = fir1(Nwin-1,wc/pi);%�����ͨ�˲���ϵ��;
[Hwin f1]=freqz(hwin,1,44100,fs);%�����ͨ�˲���Ƶ����Ӧ
magHwin = abs(Hwin);%��Ƶ��Ӧ
phaHwin = angle(Hwin);%��Ƶ��Ӧ
phaHwin = 180*unwrap(phaHwin)/pi;
nwin = 0:Nwin-1;

figure;%��ͼ����ͨ�˲�������
subplot(3,1,1);stem(nwin,hwin);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(3,1,2);semilogx(f1,20*log10(magHwin));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(3,1,3);plot(f1,phaHwin);grid;
xlabel('Frequency (Hz)');ylabel('Phase response (degree)');


% �˲�֮����ź�
y = filter(Hwin,1,x);%�˲�
Y = fft(y);
magY = abs(Y);%�˲����źŵ�Ƶ��

figure;%��ͼ���˲����źŵ�ʱ���Ƶ����
subplot(2,1,1); plot(m,y);
xlabel('Number of samples');ylabel('Sample value y(n)');grid;
subplot(2,1,2); semilogx(f,magY(1:M/2+1));
xlabel('Frequency (Hz)'); ylabel('Amplitude |Y(f)| ');grid;


