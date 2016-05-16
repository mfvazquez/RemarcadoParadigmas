function [micromed_time]=make_photodiodevector_marktype(EEG,marktype)

%
% [micromed_time]=make_photodiodevector_marktype(EEG, marktype)
%
% make_photodiodevector gives the photodiode time vector
% 

%%
indice=1;

for i=1:max(size(EEG.event))
      
    if strcmp(EEG.event(i).type,marktype)==1
        
        micromed_time(indice)=EEG.event(i).latency;
        indice=indice+1;

    end
    
end

%%% No tengo que dividir el vector por el srate porque todo
%%% no estoy referenciando al tiempo
