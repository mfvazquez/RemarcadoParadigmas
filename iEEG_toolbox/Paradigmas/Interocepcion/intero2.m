
clear all
close all

eeglab

path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\Intero\Paciente4_Intero.edf'

ev_channel=56;
[EEG]=import_edf(path,ev_channel);
eeglab redraw


%% 


path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\Intero\'
name='nicolas_2.xls'
sheet='nicolas_2'
range='C2:C1261'

trial_time=make_logtimevector2(path,name, sheet, range);
trial_time=trial_time-trial_time(1);

%%

mark_vector=[1 2];
EEG=delete_mark(EEG,mark_vector);
eeglab redraw

[micromed_time]=make_photodiodevector(EEG);
m1=micromed_time(1);
micromed_time=micromed_time-micromed_time(1);

%%


plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   


%%  

delta=0.3;
ev2delete=find_repeatedmark(micromed_time, delta);
EEG=delete_mark(EEG,ev2delete);

%%


[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);


%% Change init - fin marks into EEG signal

EEG = pop_editeventvals(EEG,'changefield',{218 'type' 'finb1'});
EEG = pop_editeventvals(EEG,'changefield',{286 'type' 'finb2'});
EEG = pop_editeventvals(EEG,'changefield',{287 'type' 'inb3'});
EEG = pop_editeventvals(EEG,'changefield',{545 'type' 'finb3'});
EEG = pop_editeventvals(EEG,'changefield',{546 'type' 'inb4'});
EEG = pop_editeventvals(EEG,'changefield',{805 'type' 'finb4'});
EEG = pop_editeventvals(EEG,'changefield',{806 'type' 'inb5'});
EEG = pop_editeventvals(EEG,'changefield',{1059 'type' 'finb5'});
EEG = pop_editeventvals(EEG,'changefield',{1060 'type' 'inb6'});
EEG = pop_editeventvals(EEG,'changefield',{1329 'type' 'finb6'});
EEG = pop_editeventvals(EEG,'changefield',{1330 'type' 'inb7'});
EEG = pop_editeventvals(EEG,'changefield',{1608 'type' 'finb7'});


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
                                        
for i=1:ceil(max(size(start_end_vect))/2)
    
    startv(i)=start_end_vect(2*i);
    endv(i)=start_end_vect(2*i-1);

end


%%

ECGr.bloque7=ECG.data(start_end_vect(12):start_end_vect(13),1);
ECGr.bloque6=ECG.data(start_end_vect(10):start_end_vect(11),1);
ECGr.bloque5=ECG.data(start_end_vect(8):start_end_vect(9),1);
ECGr.bloque4=ECG.data(start_end_vect(6):start_end_vect(7),1);
ECGr.bloque3=ECG.data(start_end_vect(4):start_end_vect(5),1);
ECGr.bloque2=ECG.data(start_end_vect(2):start_end_vect(3),1);
ECGr.bloque1=ECG.data(1:start_end_vect(1),1);

%%

i=7
clear a
a=ECG.data(start_end_vect(13):start_end_vect(14),1)';
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
EEG = pop_importdata('dataformat','array','nbchan',0,'data','a','setname','ecg','srate',200,'pnts',0,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 1024);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
eeglab redraw;

ECGr.bloque7=EEG.data;

%%

