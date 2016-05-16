function [micromed_time]=make_dannylogvector(EEG,srate)

%
% [trial_time]=make_dannylogvector(EEG)
%
% Make_dannylogvector gives the lo time vector
% srate is the sampling rate



for i=1:max(size(EEG))
         
    micromed_time(i)=EEG(i).time;
       
end

micromed_time=micromed_time/srate;