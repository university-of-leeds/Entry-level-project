clc;close all;clear all;
%���������ڣ���������--------------------
instrhwinfo('Bluetooth');
io = Bluetooth('BT04-A',1);
fopen(io);