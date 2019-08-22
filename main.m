% clear; close all; clc;
%% Create data client object
ipAddress = 'localhost'; % Data server IP address
serverPort = 8712; % Data server port
nChan = 9; % Number of channels, including EEG data channels plus 1 event channel
sampleRate = 1000; % Sampling rate
bufferSize = 5; % Data buffer size, in seconds
dataClient = DataClient(ipAddress, serverPort, nChan, sampleRate, bufferSize); % Create client object
dataClient.Open;

%% 数据存储
fs=1000;
pause(5);
data = dataClient.GetBufferData; % Get data from buffer
sound(sin(0.1*pi*(1:1000)));
a=data(1:8,:);
% save('right2.mat','a');
for i=1:8
    a(i,:)=filter1(fs,a(i,:),4,20);
end
%% CCA构造

N=length(a(1,:));
f1=6.7;f2=10;f3=12;f4=15;

template=zeros(8,N);
t=1/fs:1/fs:N/fs;
template(1,:)=cos(2*pi*f1*t);
template(2,:)=sin(2*pi*f1*t);

template(3,:)=cos(2*pi*f2*t);
template(4,:)=sin(2*pi*f2*t);

template(5,:)=cos(2*pi*f3*t);
template(6,:)=sin(2*pi*f3*t);

template(7,:)=cos(2*pi*f4*t);
template(8,:)=sin(2*pi*f4*t);
template=template';
[A1,B1,R1,U1,V1] = canoncorr(a',template(:,1:2));
[A2,B2,R2,U2,V2] = canoncorr(a',template(:,3:4));
[A3,B3,R3,U3,V3] = canoncorr(a',template(:,5:6));
[A4,B4,R4,U4,V4] = canoncorr(a',template(:,7:8));
if (R1(1,1)>R2(1,1))&&(R1(1,1)>R3(1,1))&&(R1(1,1)>R4(1,1))
    fwrite(io,'$1#','char');%前进
elseif (R2(1,1)>R1(1,1))&&(R2(1,1)>R3(1,1))&&(R2(1,1)>R4(1,1))
    fwrite(io,'$2#','char');%后退
elseif (R3(1,1)>R1(1,1))&&(R3(1,1)>R2(1,1))&&(R3(1,1)>R4(1,1))
    fwrite(io,'$3#','char');%左转
elseif (R4(1,1)>R1(1,1))&&(R4(1,1)>R2(1,1))&&(R4(1,1)>R3(1,1))
    fwrite(io,'$4#','char');%右转
end