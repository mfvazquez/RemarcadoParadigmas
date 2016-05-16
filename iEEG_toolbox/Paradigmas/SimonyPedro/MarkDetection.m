
% clear all
% close all
% 
% eeglab
% 
% path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\SimonyPedro\dia1\Simon\Paciente4_simon.edf'
% 
% ev_channel=56;
% [EEG]=import_edf(path,ev_channel);
% eeglab redraw

%% borro las primeras marcas que estan de mas

mark_vector=[1:1:22];
EEG=delete_mark(EEG,mark_vector);
eeglab redraw

mark_vector=[1:1:164];
EEG=delete_mark(EEG,mark_vector);
eeglab redraw

[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);

%%

path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\SimonyPedro\dia1\Simon\'
name='peirone.xls'
sheet='peirone'
range='i2:i161'

trial_time2(:,1)=make_logtimevector2(path,name, sheet, range);

range='j2:j161'

trial_time2(:,2)=make_logtimevector2(path,name, sheet, range);

range='h2:h161'

trial_time2(:,3)=make_logtimevector2(path,name, sheet, range);

[trial_time]=merge_trialtime(trial_time2);

trial_time=trial_time-trial_time(1);

%%

plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   


%%  

 delta=0.07;
 ev2erase=find_extramarks2(micromed_time,trial_time,delta);
 
 EEG=delete_mark(EEG,ev2erase);
 eeglab redraw

%%


[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);

 

%% 

 insert=insert_missingmarks(micromed_time, trial_time);
 insert=insert-1;
 insertar=trial_time(insert)+EEG.event(1).latency/EEG.srate;

%%

for i=11:max(size(insert))
   
      EEG = pop_editeventvals(EEG,'insert',{insert(i) [] [] []},'changefield',{insert(i) 'type' 1},'changefield',{insert(i) 'latency' ''},'changefield',{insert(i) 'latency' insertar(i)});
     
    
end

eeglab redraw
 













