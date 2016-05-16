
file='S2shapeonlysingleproberightok.set'
path='C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\9_VWM_Mario\Single_BW\'

EEG = pop_loadset('filename',file,'filepath',path);
EEG = eeg_checkset( EEG );



for i=1:max(size(EEG.event))
   
     EEG = pop_editeventvals(EEG,'changefield',{i 'type' 232});
    
end

EEG = pop_saveset( EEG, 'filename',file,'filepath',path);
EEG = eeg_checkset( EEG );
