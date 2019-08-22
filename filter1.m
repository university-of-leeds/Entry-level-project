function filter_data=filter1(fs,data,locutoff,hicutoff)
%����FIR�����˲���
%trans=0.15;%���ֿ�ȵĹ�����
nyq=fs*0.5;
min_filtorder=15;%��С�˲�����
if locutoff>0,
    filtorder =3* fix(fs/locutoff);%fix()��ʾȡ����
elseif hicutoff>0,
    filtorder = 3*fix(fs/hicutoff);
end 

if filtorder < min_filtorder
    filtorder = min_filtorder;
end

b=fir1(filtorder,[locutoff, hicutoff]./nyq);
filter_data=filtfilt(b,1,data);%����λ�����˲���

% nfft=1024;
% spec=abs(fft(filter_data,nfft));
%  f=0:fs/nfft:100/(fs/nfft);
%  figure
%  plot(f,spec(1:length(f)))


 