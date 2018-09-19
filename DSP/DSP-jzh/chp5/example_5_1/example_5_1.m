% ������ʵ�� example_5_1.m
% �������״����
% �����������״�ز����ݷ���
% ����DFT�����ز�Ƶ�ף��õ�Ŀ���ٶ�ֵ
% ��Ŀ������µ��ٶȷֱ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;clc;


c0 = 3e8;%����
fs = 0.25e6;ts = 1/fs;%����Ƶ�ʺͲ�������
f0 = 10e9;%�״���Ƶ
lumbda = c0/f0;%�״﹤������
T = 4e-3;%�ز�����ʱ��
R = 8e3;%Ŀ�����
v1 = 300;%Ŀ���ٶ�
fd1 = 2*v1/lumbda;%������Ƶ��
v2 = 306;
fd2 = 2*v2/lumbda;%������Ƶ��
v3 = 360;
fd3 = 2*v3/lumbda;%������Ƶ��
A = 0.01;%˥��ϵ��

t = 0:ts:T-ts;
N = length(t);
s1 = A*exp(j*(2*pi*fd1.*t-4*pi*R/lumbda));%��Ŀ��ز��źţ�����Ƶ
s2 = A*(exp(j*(2*pi*fd1.*t-4*pi*R/lumbda))...
    +exp(j*(2*pi*fd2.*t-4*pi*R/lumbda))...
    +exp(j*(2*pi*fd3.*t-4*pi*R/lumbda)));%��Ŀ��ز��źţ�����Ƶ
vr = A/0.5*randn(1,N);%�ز�����ʵ��
vi = A/0.5*randn(1,N);%�ز������鲿
x1 = s1+vr+j*vi;%��Ŀ���״�ز�
x2 = s2+vr+j*vi;%��Ŀ���״�ز�


X1 = fft(x1);%����DFT
magX1 = abs(X1)/max(abs(X1));%����
phaX1 = angle(X1);%��λ

X2 = fft(x2);%����DFT
magX2 = abs(X2)/max(abs(X2));%����
phaX2 = angle(X2);%��λ

w_ham = hamming(N);w_ham = w_ham.';
X2w = fft(x2.*w_ham);%�Ӻ�����������DFT
magX2w = abs(X2w)/max(abs(X2w));%����
phaX2w = angle(X2w);%��λ

n = 0:N-1
figure;
subplot(1,2,1),plot(n,real(x1));
xlabel('Number of samples');ylabel('Received signal');grid;
subplot(1,2,2),plot(n,20*log10(magX1));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;

figure;plot(n,20*log10(magX2));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;

figure;plot(n,20*log10(magX2w));
xlabel('Number of samples');ylabel('Amplitude |X(k)|');grid;




