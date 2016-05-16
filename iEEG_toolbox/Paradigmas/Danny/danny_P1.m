
close all
clear all
eeglab

% Patient 2

% cd C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia2_\Danny_VSTM\  
% path='C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia2_\Danny_VSTM\VSTM_Paciente2.edf'
% channel=64;

% Patient 1

cd C:\Users\Ineco\Documents\IEEG\Pacientes\Sebastian\Dia_1\Danny\  
path='C:\Users\Ineco\Documents\IEEG\Pacientes\Sebastian\Dia_1\Danny\bloque1.edf'
channel=2;

EEG=import_edf(path,channel);

eeglab redraw

%%

  micromed_time=make_photodiodevector(EEG);
  
  %%
 
   
%   triggers=open('Subject_2_triggers.mat')
  triggers=open('Subject_1_triggers.mat')
  trial_time2=make_dannylogvector(triggers.triggers,1);
  trial_time=trial_time2(229:max(size(trial_time2)));
 
  
  %% referencio todo al inicio

micromed_time=micromed_time- micromed_time(1,1);
trial_time=trial_time-trial_time(1,1);


 %%
    
plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

%%
ev2erase=find_extramarks(micromed_time,trial_time);

%%

EEG=delete_mark(EEG,ev2erase);
eeglab redraw

%% Erase extra marks undetected by automatice detector

ev2erase=[370 371];
EEG=delete_mark(EEG,ev2erase);
eeglab redraw

%%

[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time- micromed_time(1,1);
     
plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

%%

trig=triggers.triggers(229:max(size(triggers.triggers)));
%%

EEG=remark_danny(EEG,trig)
eeglab redraw

