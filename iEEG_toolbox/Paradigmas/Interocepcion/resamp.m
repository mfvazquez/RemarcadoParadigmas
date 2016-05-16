function [ntimes,y]=resamp(x,times,freq,nfreq)

%Function
% [ntimes,y]=resamp(x,times,freq,nfreq)
%
%Purpose
%  resamples a non-even sampled vector 
%
%Synopsis
% function resamp(x,times,freq,nfreq)
%
%Description
%  resamples a non-even sampled series vector (RR, QT, KL, ...) with occurrence
%  times vector 'times' referred to a 'freq' sampling frequency into an even-sampled
%  vector with sampling frequency 'nfreq' Hz. It outputs the new even-sampled vector
%  and the time occurrences. It also works with an input matrix (L,no_leads).
%
% Copyright (c), Jose Garcia, Zaragoza University, Spain 1997-08-08
%--------------------------------------------------------------------------------

% ----- series resampling at nfreq Hz ----------------------------------------
[L,no_leads]=size(x);
ntimes=(1:freq/nfreq:times(L))';
y=zeros(length(ntimes),no_leads);
y=interp1(times,x,ntimes,'linear','extrap');
%y=interp1q(times,x,ntimes);
aux=isnan(y);
%y(aux)=0;
 
 
