
close all
clear all
eeglab

cd C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia2_\Danny_VSTM\  
path='C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia2_\Danny_VSTM\VSTM_Paciente2.edf'
channel=64;

EEG=import_edf(path,channel);

eeglab redraw

%%

  [micromed_time]=make_photodiodevector(EEG);
  
  %%
 
   
  triggers=open('Subject_2_triggers.mat')
  trial_time=make_dannylogvector(triggers.triggers,1);
  
 
  
  %% referencio todo al inicio

micromed_time=micromed_time- micromed_time(1,1);
trial_time=trial_time-trial_time(1,1);
    
 %%
    
plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

%%

diff=diff_marcas(micromed_time,trial_time);
plot(diff)

%%

diff2=diff_invector(micromed_time);
ev2delete=find(diff2<0.1);
ev2delete=ev2delete+1;
EEG=delete_mark(EEG,ev2delete);
eeglab redraw

%%

[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time- micromed_time(1,1);
     
plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

%%

EEG=remark_danny(EEG,triggers.triggers)
eeglab redraw

