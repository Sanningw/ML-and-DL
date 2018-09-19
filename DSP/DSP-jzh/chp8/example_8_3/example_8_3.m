% ��8��ʵ�� example_8_3.m
% �����Ż���������FIR�˲���ϵ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

fs = 44100;%����Ƶ��
N = 147;%�˲�������

%��ͨ�˲������
wlpe = 2*pi*600/fs;%ͨ������Ƶ��
wlse = 2*pi*1400/fs;%�������Ƶ��

fl = [0,wlpe/pi,wlse/pi,1];%�˲��������ı���Ƶ��
Al = [1,1,0,0];%�����˲���ָ��Ƶ�ʵ��ϵķ�����Ӧ
hl = remez(N-1,fl,Al);%�����ͨ�˲���ϵ�� 
[HL f]=freqz(hl,1,44100,fs);%�����ͨ�˲�����Ƶ��Ӧ

%��ͨ�˲������
whpe = 2*pi*1400/fs;%ͨ������Ƶ��
whse = 2*pi*600/fs;%�������Ƶ��

fh = [0,whse/pi,whpe/pi,1];%�˲��������ı���Ƶ��
Ah = [0,0,1,1];%�����˲���ָ��Ƶ�ʵ��ϵķ�����Ӧ
hh = remez(N-1,fh,Ah);%�����ͨ�˲���ϵ�� 
[HH f]=freqz(hh,1,44100,fs);%�����ͨ�˲�����Ƶ��Ӧ


figure;%��ͼ���˲���ʱ��Ƶ����
subplot(2,2,1);stem(hl);grid;
xlabel('n');ylabel('Impulse response of LPF');
subplot(2,2,2);semilogx(f,20*log10(abs(HL)));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');
subplot(2,2,3);stem(hh);grid;
xlabel('n');ylabel('Impulse response of HPF');
subplot(2,2,4);semilogx(f,20*log10(abs(HH)));grid;
xlabel('Frequency (Hz)');ylabel('Magnitude response (dB)');



