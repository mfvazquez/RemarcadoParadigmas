clear all
close all


addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\')
eeglab

path='D:\_INECO\Pacientes\Paciente10_Repossini\Masters\Interocepcion\20141201_Repossini_Interocepcion.edf'


ev_channel=64;
[EEG]=import_edf(path,ev_channel);
eeglab redraw


%%

path='D:\_INECO\Pacientes\Paciente10_Repossini\Logs\Intero\'
name='florenciaRepossini.xls'
sheet='florenciaRepossini'
range='C5:C772'

trial_time=make_logtimevector2(path,name, sheet, range);
trial_time=(trial_time-trial_time(1))/1000;

%%
% 
% mark_vector=[1 2];
% EEG=delete_mark(EEG,mark_vector);
% eeglab redraw

[micromed_time]=make_photodiodevector(EEG);
m1=micromed_time(1);
micromed_time=micromed_time-micromed_time(1);
%%

trial_time=trial_time+micromed_time(7);

%%


plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   


%%  

delta=0.3;
ev2delete=find_repeatedmark(micromed_time, delta);
EEG=delete_mark(EEG,ev2delete);

[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);

%%

ECG=open('D:\_INECO\Pacientes\Paciente10_Repossini\Logs\Intero\florencia.mat');

%% Deteccion de inicio y fin de bloque

[vector_se]=find(ECG.data(:,1)>0.07);
lenght=max(size(vector_se));

for i=1:lenght-1
   
    diff(i)=vector_se(i+1)-vector_se(i);
    
end

indices=vector_se(find(diff>5000)+1);
start_end_vect=[vector_se(1) indices']; %vector de tiempos de inicio y fin de bloque
                                        %falta el inicio del primer bloque

%% Change init - fin marks into EEG signal

EEG = pop_editeventvals(EEG,'changefield',{6 'type' 'inb1'});
EEG = pop_editeventvals(EEG,'changefield',{136 'type' 'finb1'});

EEG = pop_editeventvals(EEG,'changefield',{137 'type' 'inb2'});
EEG = pop_editeventvals(EEG,'changefield',{255 'type' 'finb2'});

EEG = pop_editeventvals(EEG,'changefield',{256 'type' 'inb3'});
EEG = pop_editeventvals(EEG,'changefield',{364 'type' 'finb3'});

EEG = pop_editeventvals(EEG,'changefield',{366 'type' 'inb4'});
EEG = pop_editeventvals(EEG,'changefield',{469 'type' 'finb4'});

EEG = pop_editeventvals(EEG,'changefield',{470 'type' 'inb5'});
EEG = pop_editeventvals(EEG,'changefield',{526 'type' 'finb5'});

EEG = pop_editeventvals(EEG,'changefield',{527 'type' 'inb6'});
EEG = pop_editeventvals(EEG,'changefield',{643 'type' 'finb6'});

EEG = pop_editeventvals(EEG,'changefield',{644 'type' 'inb7'});
EEG = pop_editeventvals(EEG,'changefield',{781 'type' 'finb7'});


%%

srate=200;
filt_long=200;

band=[1 80];

b = firws(filt_long, band / (srate/2));
ekgfilt= firfiltdcpadded(b, ECG.data(:,2), 0);  % Causal Filter

x=0:1:size(ekgfilt,1)-1;
y=0:200/1024:size(ekgfilt,1)-1;
ecgresampl=interp1(x,ekgfilt,y);
ecgsoundresampl=interp1(x,ECG.data(:,1),y);

%%

data_reshaped=[zeros(1,8*1024+150) ecgsoundresampl];
EEG.data(64,:)=500*data_reshaped(1:size(EEG.data,2));

%%

data_reshaped=[zeros(1,8*1024+150) ecgresampl];
EEG.data(64,:)=500*data_reshaped(1:size(EEG.data,2));
