function filter_data=filter1(fs,data,locutoff,hicutoff)
%线性FIR数字滤波器
%trans=0.15;%部分宽度的过渡区
nyq=fs*0.5;
min_filtorder=15;%最小滤波长度
if locutoff>0,
    filtorder =3* fix(fs/locutoff);%fix()表示取整数
elseif hicutoff>0,
    filtorder = 3*fix(fs/hicutoff);
end 

if filtorder < min_filtorder
    filtorder = min_filtorder;
end

b=fir1(filtorder,[locutoff, hicutoff]./nyq);
filter_data=filtfilt(b,1,data);%零相位数字滤波器

% nfft=1024;
% spec=abs(fft(filter_data,nfft));
%  f=0:fs/nfft:100/(fs/nfft);
%  figure
%  plot(f,spec(1:length(f)))


 