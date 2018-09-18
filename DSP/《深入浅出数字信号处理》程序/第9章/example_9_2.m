% �ھ���ʵ�� example_9_2.m
% ˫���Ա任�������ͨ�˲���ϵ��
% �Ƚ�˫���Ա任����弤���䷨�Ľ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all;clc;

fs = 44100;%����Ƶ��
Ts = 1/fs;%�������

fpe = 4500; %ģ���ͨͨ������Ƶ��
fse = 7500; %ģ���ͨ�������Ƶ��
wpe = 2*fpe/fs; %ģ���ͨͨ�����޹�һ����Ƶ��
wse = 2*fse/fs; %ģ���ͨ������޹�һ����Ƶ��
Ap = 1; %ͨ������
As = 15; %���˥��

%������˹ģ���ͨԭ���˲������
[N,wn]=buttord(wpe,wse,Ap ,As,'s');
[z,p,k]=buttap(N); %ģ���ͨԭ���㡢����ϵ��
[b1,a1]=zp2tf(z,p,k); %�㡢����ϵ��ת��Ϊ���ݺ���

%������˹ģ���ͨԭ���˲���Ƶ����Ӧ
f1 = 0:0.01:10-0.01;
[H1,w1]=freqs(b1,a1,f1);
magH1=abs(H1);

figure;%ģ���ͨԭ���˲�����Ƶ��������
subplot(2,2,1);semilogx(w1,magH1,'Linewidth',2);grid;
xlabel('Normalized angle frequency (rad/s)'); ylabel('Magnitude response');

%Ԥ���䴦��
wape = 2/Ts*tan(Ts/2*2*pi*fpe);%��ͨ�˲���ͨ������Ƶ��
wase = 2/Ts*tan(Ts/2*2*pi*fse);%��ͨ�˲���ͨ������Ƶ��
bw = wase-wape;%Ԥ���䴦��֮��Ĵ���
omegac = sqrt(wape*wase);

% ��ģ���ͨԭ�ͱ任Ϊģ���ͨ�˲���
[b2,a2]=lp2bp(b1,a1,omegac,bw); %ģ���ͨ�˲�����ϵ��

%������˹ģ���ͨ�˲���Ƶ����Ӧ
f2 = [0:1:fs/2]*2*pi;
[H2,w2]= freqs(b2,a2,f2);
magH2 =abs(H2);

%ģ���ͨ�˲�����Ƶ��������
subplot(2,2,2);plot(w2/2/pi,magH2,'Linewidth',2);grid;
xlabel('Frequency (Hz)'); ylabel('Magnitude response');

% ˫���Ա任��������ɢ�����
[bz,az] = bilinear(b2,a2,fs); %���ִ�ͨ�˲�����ϵ��

%������˹�����ִ�ͨ�˲���Ƶ����Ӧ
[H,f] =  freqz(bz,az,44100,fs);
magH = abs(H);
phaH = 180*unwrap(angle(H))/pi;

subplot(2,2,3);plot(f,magH,'Linewidth',2); grid;%���ִ�ͨ�˲�����Ƶ��������
xlabel('Frequency (Hz)'); ylabel('Magnitude response');
subplot(2,2,4);plot(f,phaH,'Linewidth',2); grid;%���ִ�ͨ�˲�����Ƶ��������
xlabel('Frequency (Hz)'); ylabel('Phase response (degree) ');

% �弤���䷨�����˲���ϵ��
fw = fse-fpe; %ģ���ͨ�˲�������
bw = 2*pi*fw; %ģ���ͨ�˲��������Ƶ��
omegac = 2*pi*sqrt(fse*fpe);
[b2inv,a2inv]=lp2bp(b1,a1,omegac,bw); %ģ���ͨ�˲�����ϵ��
[bzinv,azinv] = impinvar(b2inv,a2inv,fs); %���ִ�ͨ�˲�����ϵ��
[Hinv,f] =  freqz(bzinv,azinv,44100,fs);
magHinv = abs(Hinv);
phaHinv = 180*unwrap(angle(Hinv))/pi;

figure;%��ͼ���Ƚ����ַ����ķ�����Ӧ
semilogx(f,20*log10(magH),'-','Linewidth',2);
grid;hold on;
semilogx(f,20*log10(magHinv),'--','Linewidth',2);
hold off;legend('˫���Ա任��','�弤���䷨');
xlabel('Frequency (Hz)'); ylabel('Magnitude response(dB)');






