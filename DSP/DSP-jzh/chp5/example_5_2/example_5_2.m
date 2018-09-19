% ������ʵ�� example_5_2.m
% ��Ʊ�г��ƶ�ƽ����
% ��DFT�������Ծ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clear all;clc;

x = load('stockSH.txt','-ascii');%������������
M = length(x);

L = 10;
h = 1/L*ones(L,1);%���ɻ���ƽ���˲���

m = 0:M-1;
l = 0:L-1;

figure;%��ͼ���������ݺ��˲�����λ�弤��Ӧ
subplot(1,2,1);plot(m,x,'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');
subplot(1,2,2);plot(l,h,'-o');
xlabel('Number of samples');ylabel('Sample Value');
axis([0,L,0,0.16]);grid;

N = M+L-1;
X = fft(x,N);%������������N��DFT
magX = abs(X);
phaX = angle(X);
H = fft(h,N);%�����˲���N��DFT
magH = abs(H);
phaH = angle(H);

n = 0:N-1;
figure;%��ͼ������������ϵͳ��Ƶ��
subplot(2,2,1);plot(n,magX,'-o');grid;
xlabel('Number of samples');ylabel('Amplitude');
subplot(2,2,2);plot(n,phaX,'-o');grid;
xlabel('Number of samples');ylabel('Phase');
subplot(2,2,3);plot(n,magH,'-o');grid;
xlabel('Number of samples');ylabel('Amplitude');
subplot(2,2,4);plot(n,phaH,'-o');grid;
xlabel('Number of samples');ylabel('Phase');

Y = X.*H;%Ƶ�����

y = ifft(Y);%������DFT

n1 = L-1:M-1;
figure;%��ͼ���ƶ�ƽ����
subplot(1,2,1);plot(n,y,'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');
subplot(1,2,2);plot(n1,y(n1+1),'-o');grid;
xlabel('Number of samples');ylabel('Sample Value');







