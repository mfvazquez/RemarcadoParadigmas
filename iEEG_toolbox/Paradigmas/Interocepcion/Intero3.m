
[micromed_time]=make_photodiodevector(EEG);
m1=micromed_time(1);
micromed_time=micromed_time-micromed_time(1);

%%

delta=0.2;
ev2delete=find_repeatedmark(micromed_time, delta)

%%

EEG=delete_mark(EEG,ev2delete)


eeglab redraw

%%

ECG=open('C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\Intero\PROTOCOLO_INTRACRANEAL\Lunes_15_julio\nicolas-all-intero.mat');



%% Deteccion de inicio y fin de bloque

[vector_se]=find(ECG.data(:,2)>0.07);
lenght=max(size(vector_se));

for i=1:lenght-1
   
    diff(i)=vector_se(i+1)-vector_se(i);
    
end

indices=vector_se(find(diff>5000)+1);
start_end_vect=[1 vector_se(1) indices']; %vector de tiempos de inicio y fin de bloque
                                        %falta el inicio del primer bloque
                                        

%%

i=7
clear a
a=ECG.data(start_end_vect(13):start_end_vect(14),2)';
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
EEG = pop_importdata('dataformat','array','nbchan',0,'data','a','setname','ecg','srate',200,'pnts',0,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 1024);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
eeglab redraw;

ECGr2.bloque7=EEG.data;
