% ��8��ʵ�� example_8_1.m
% �ô�������������FIR�˲���ϵ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

fs = 44100;%����Ƶ��
wc = 2*pi*1000/fs;%��ֹƵ��

N = 183;%�˲�������
hl = fir1(N-1,wc/pi);%�����ͨ�˲���ϵ��
hh = fir1(N-1,wc/pi,'high',Hamming(N));%�����ͨ�˲���ϵ��

figure;%��ͼ����ͨ�͸�ͨ�˲���ʱ����
subplot(2,1,1);stem(hl);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(2,1,2);stem(hh);grid;
xlabel('n');ylabel('Impulse response of HPF');

save('hl.dat', 'hl', '-ascii');%�����ͨ�˲���ϵ��
save('hh.dat', 'hh', '-ascii');%�����ͨ�˲���ϵ��

[HL f]=freqz(hl,1,44100,fs);%�����ͨ�˲�����Ƶ��Ӧ
[HH f]=freqz(hh,1,44100,fs);%�����ͨ�˲�����Ƶ��Ӧ

figure;%��ͼ����ͨ�͸�ͨ�˲�����Ƶ��Ӧ
subplot(2,1,1);semilogx(f,20*log10(HL));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(2,1,2);semilogx(f,20*log10(HH));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');


