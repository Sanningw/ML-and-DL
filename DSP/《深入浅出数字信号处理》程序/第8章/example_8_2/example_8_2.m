% ��8��ʵ�� example_8_2.m
% ��Ƶ�ʲ�����������FIR�˲���ϵ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;

N = 81;%�˲�������
f = [0,0.45,0.5,1];%�����˲����ı���Ƶ��
A = [0,1,0,0];%ָ��Ƶ�ʵ��ϵķ�����Ӧ
h = fir2(N-1,f,A);%����ʵ���˲���ϵ��

[H,w]=freqz(h,1);%����ʵ���˲���Ƶ����Ӧ

figure;
subplot(3,1,1);plot(f,A);grid;%��ͼ�������˲����ķ�Ƶ��Ӧ
xlabel('Normalized Frequency');ylabel('Magnitude response');
subplot(3,1,2);stem(h);grid;%��ͼ��ʵ���˲���ʱ����
xlabel('n');ylabel('Impulse response of Filter');
subplot(3,1,3);plot(w/pi,abs(H));grid;%��ͼ��ʵ���˲�����Ƶ��Ӧ
xlabel('Normalized Frequency');ylabel('Magnitude response');



