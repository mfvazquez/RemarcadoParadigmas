%% Genera la lista de canales completa en formato CSV
% 
% paciente= input('Ingrese el nombre del paciente:','s')
% paradigma=input('Ingrese el paradigma a trabajar:','s')
% 
% path_set=[pwd '\' paciente '\SETs\']; %carpeta en la que están los scripts
%      
% 
% 
% eeglab
% EEG = pop_loadset('filename',[paciente '_' paradigma '.set'] ,'filepath', path_set);
% EEG = eeg_checkset( EEG );
% eeglab redraw
% 
 fid=fopen('channels.csv','w')

%%
for j=1:max(size(EEG.chanlocs))

    variable=EEG.chanlocs(j).labels
    fwrite(fid,variable);
    fwrite(fid,',');

end


fclose(fid);