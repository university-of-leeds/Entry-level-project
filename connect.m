clc;close all;clear all;
%打开蓝牙串口，建立连接--------------------
instrhwinfo('Bluetooth');
io = Bluetooth('BT04-A',1);
fopen(io);