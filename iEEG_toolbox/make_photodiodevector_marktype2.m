function [micromed_time indexes]=make_photodiodevector_marktype2(EEG,marktype)

%
% [micromed_time]=make_photodiodevector_marktype(EEG, marktype)
%
% make_photodiodevector gives the photodiode time vector
% 

%%

micromed_time=[];
indexes=[];
indice=1

for i=1:max(size(EEG.event))
      
    if strcmp(EEG.event(i).type,num2str(marktype))
        
        indexes(indice)=i;
        micromed_time(indice)=EEG.event(i).latency;
        indice=indice+1;

    end
    
end


if  size(micromed_time)>0

    micromed_time=micromed_time/EEG.srate;

end
%%% No tengo que dividir el vector por el srate porque todo
%%% no estoy referenciando al tiempo
