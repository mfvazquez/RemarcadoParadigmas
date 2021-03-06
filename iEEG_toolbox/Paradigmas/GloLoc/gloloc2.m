clear all
close all
clc

eeglab

% EEGLAB history file generated on the 28-May-2013
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig('C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\GloLoc\GloLoc_3_Paciente2_Sequence_Bloque1.edf');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = pop_chanevent(EEG, 64,'oper','X>1000','edge','leading','edgelen',0,'delchan','off','nbtype',1);
EEG = eeg_checkset( EEG );

eeglab redraw;

%%

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(2);

%%

cd  'C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\GloLoc'

trial_time=xlsread('SEQUENCE_1.xls','Hoja1');

for i=1:max(size(trial_time))
   
    if trial_time(i,1)>10000
        
        trial_time(i,1)=trial_time(i,1)/1000;
        
    end
       
end

trial_time=trial_time-trial_time(1);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%%

%Borro pulsos que estan de mas
% EEG = pop_editeventvals(EEG,'delete',7);
% EEG = pop_editeventvals(EEG,'delete',6);
% EEG = pop_editeventvals(EEG,'delete',5);
% EEG = pop_editeventvals(EEG,'delete',4);
% EEG = pop_editeventvals(EEG,'delete',3);
% EEG = pop_editeventvals(EEG,'delete',2);
% EEG = pop_editeventvals(EEG,'delete',1);
% 
% eeglab redraw;

%%
% 
% clear micromed_time;
% 
% for i=1:max(size(EEG.event))
%          
%     micromed_time(i)=EEG.event(i).latency;
%        
% end
% 
% micromed_time=micromed_time/512;
% micromed_time=micromed_time-micromed_time(2);



%%


for i=1:max(size(micromed_time))-1
   
    t_diff(i)=micromed_time(i+1)-micromed_time(i);
    
end


%%

vector=[find(t_diff<0.8) find(t_diff>2)];
vector_s=sort(vector,'descend');

for i=1:max(size(vector_s))
   
  EEG = pop_editeventvals(EEG,'delete',vector_s(i));  
    
end

eeglab redraw

%%


clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);

%%

micromed_time=micromed_time+trial_time(4);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

