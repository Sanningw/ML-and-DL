% ������ʵ�� example_4_1.m
% ���ַ�Ƶ����������
% ������Ƶ����λ�弤��Ӧ����Ƶ��Ӧ
% ������Ƶ�ź�ͨ����Ƶ�������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;

fs = 44100; %����Ƶ��

hL = load('hl.dat');%��ȡ��Ƶ����ͨϵͳ��λ�弤��Ӧ
hH = load('hh.dat');%��ȡ��Ƶ����ͨϵͳ��λ�弤��Ӧ


figure;%��ͼ����Ƶ����ͨ�͸�ͨϵͳ��λ�弤��Ӧ
subplot(2,1,1);stem(hL);grid;xlabel('n');ylabel('Impulse response of LPF');
subplot(2,1,2);stem(hH);grid;xlabel('n');ylabel('Impulse response of HPF');

[HL f]=freqz(hL,1,44100,fs);%�����Ƶ����ͨϵͳƵ����Ӧ
[HH f]=freqz(hH,1,44100,fs);%�����Ƶ����ͨϵͳƵ����Ӧ

figure;%��ͼ����Ƶ����ͨ�͸�ͨϵͳ��Ƶ��Ӧ
subplot(2,1,1);semilogx(f,20*log10(abs(HL)));grid
axis([1  45000 -200 20]);
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(2,1,2);semilogx(f,20*log10(abs(HH)));grid
axis([1  45000 -200 20]);
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');

xt = wavread('we.wav');%��ȡ��Ƶ�ź�
x = xt(:,1);%��ȡ���е�һ������

N=length(x);
f1=[0:N/2]*fs/N;
magX=2*abs(fft(x))/N;magX(1)=magX(1)/2;%����������Ƶ�źŵ�Ƶ��

figure;%��ͼ��������Ƶ�źŵ�ʱ���Ƶ����
subplot(2,1,1);plot(x);
axis([1  N -0.1 0.15]);
xlabel('Number of samples');ylabel('Sample value');grid;
subplot(2,1,2); semilogx(f1,magX(1:N/2+1));
axis([1  N/2+1 0 0.003]);
xlabel('Frequency (Hz)'); ylabel('Amplitude |X(f)| ');grid;

yH=filter(hH,1,x);%��Ƶ�ź�ͨ����Ƶ����ͨϵͳ
yL=filter(hL,1,x);%��Ƶ�ź�ͨ����Ƶ����ͨϵͳ
magYH=2*abs(fft(yH))/N;magYH(1)=magYH(1)/2;%������ͨϵͳ����źŵ�Ƶ��
magYL=2*abs(fft(yL))/N;magYL(1)=magYL(1)/2;%������ͨϵͳ����źŵ�Ƶ��

figure;%��ͼ����ͨϵͳ�����ʱ���Ƶ���Σ���ͨϵͳ�����ʱ���Ƶ����
subplot(2,2,1); plot(yL);
axis([1  N -0.1 0.15]);
xlabel('Number of samples');ylabel('Sample value');grid;
subplot(2,2,2);semilogx(f1,magYL(1:N/2+1));
axis([1  N/2+1 0 0.003]);
xlabel('Frequency (Hz)'); ylabel('Amplitude |YL(f)| ');grid;
subplot(2,2,3); plot(yH);
axis([1  N -0.1 0.15]);
xlabel('Number of samples');ylabel('Sample value');grid;
subplot(2,2,4);semilogx(f1,magYH(1:N/2+1));
axis([1  N/2+1 0 0.003]);
xlabel('Frequency (Hz)'); ylabel('Amplitude |YH(f)| ');grid;
