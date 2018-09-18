% ������ʵ�� example_4_2.m
% �״���
% �����״����ݵķ���
% ��Ѽ��ϵͳ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clear all;

c0 = 3e8;%����
fs = 40e6;ts = 1/fs;%����Ƶ�ʺͲ�������
fc = 10e6;%�״���ƵƵ��
tr = 1e-4;%�����ظ�����
M = 400;
tao = M*ts;%������
D = 1500;d = D*ts;%�ӳ�ʱ��
R = 0.5*c0*d;%Ŀ�����
A = 0.01;%˥��ϵ��

t = 0:ts:tr;
N = length(t);
rect1 = [ones(1,M),zeros(1,N-M)];
st = rect1.*cos(2*pi*fc.*t);%�����źţ���Ƶ

rect2 = [zeros(1,D),ones(1,M),zeros(1,N-M-D)];
s = A*rect2.*cos(2*pi*fc.*(t-d));%�ز��źţ���Ƶ
v = A/2*randn(1,N);%�ز�����
x = s+v;%�״�ز�

figure;%��ͼ��������Ƶ�źŵ�ʱ���Ƶ����
subplot(2,1,1);plot(st);
xlabel('Number of samples');ylabel('Transmitted signal');grid;
subplot(2,1,2); plot(x);
xlabel('Number of samples');ylabel('Received signal');grid;

y = xcorr(x,st);%��ѽ���ϵͳ�����

figure;
m = -(N-1):(N-1);plot(m,y);
xlabel('Delay Samples');ylabel('Correlation Output');grid;

