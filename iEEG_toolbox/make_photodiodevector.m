function [micromed_time]=make_photodiodevector(EEG)

%
% [trial_time]=make_photodiodevector(EEG)
%
% make_photodiodevector gives the photodiode time vector
% srate is the sampling rate

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/EEG.srate;