function [data_pxx f]=my_fft(data,srate)

% pwelch aproximation
%
%

set_w=srate;%window
set_ov=0;%overlap
set_nfft=srate;%nfft

[Pxx,f] = pwelch(data(1:100*srate,1),set_w,set_ov,set_nfft,srate);
data_pxx=zeros(length(f),size(data,2));

for k=1:size(data,2)
    
    [Pxx,f] = pwelch(data(1:100*srate,k),set_w,set_ov,set_nfft,srate);
    data_pxx(:,k)=Pxx;
    
end
