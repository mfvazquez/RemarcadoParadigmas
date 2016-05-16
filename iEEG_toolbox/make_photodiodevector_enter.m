function [micromed_time real_index]=make_photodiodevector_enter(EEG)

%
% [trial_time]=make_photodiodevector(EEG)
%
% make_photodiodevector gives the photodiode time vector
% srate is the sampling rate

u=1;

for i=1:max(size(EEG.event))
    
    if EEG.event(i).type == '100'
    
        micromed_time(u)=EEG.event(i).latency;
        real_index(u)=i;
        u=u+1;
   
    end
end

micromed_time=micromed_time/EEG.srate;