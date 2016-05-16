
clear all
close all
clc

eeglab_path = fullfile('..','..','toolbox','eeglab12_0_2_6b');
addpath(eeglab_path);
addpath('iEEG_toolbox');

% ---------------- MARCAS ------------------------------------------------

%%
eeglab

CHANNEL = 45;

edf_file = fullfile('..','Paciente14_Fagioli','MI_d1_Random.edf');
% EEG = pop_biosig(edf_file);
EEG=import_edf(edf_file,CHANNEL);

eeglab redraw
  
% ev2delete=[1:6];
%  
% EEG=delete_mark(EEG,ev2delete)

eeglab redraw

%% Leo los tiempos de las marcas del fotodiodo

micromed_time=make_photodiodevector(EEG);
% 
micromed_time=micromed_time(1, 2:end);
micromed_time=micromed_time - micromed_time(1,4);

% ---------------- LOG ---------------------------------------------------

log_file=fullfile('log', 'Fanny', '14_D1', '114RandomSequenceBlock1.mat');
load(log_file);

stimTrigSentTime = stimTrigSentTime(stimTrigSentTime~=0);
stimTrigSentTime = stimTrigSentTime - stimTrigSentTime(1,1);



%% Primera prueba

% stimuli_time=stimTrigSentTime+0.15; %0.183
% stimuli_time=stimuli_time(1:720, 1);
% tr=keyPressTime+0.15;
% tr=keyPressTime(1:720, 1);

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   
plot([stimTrigSentTime';stimTrigSentTime'],[0;100],'b')

% hold on
% plot([tr';tr'],[0;100],'g')
%    

%%

% %% Elimino las marcas que est�n de m�s

EEG=pop_editeventvals(EEG,'delete',[1 2 3 4]);
        
 %%

for i=1:max(size(stimuli_time))
  
        rest=micromed_time-stimuli_time(i); 
        mmark=find(abs(rest)<0.05);
        
        if ~isempty(mmark)
            
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'S'});
                        
        end
        
end

%%

% %% Elimino las marcas que est�n de m�s

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan8') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end

%% Agrego las respuestas

i=1;

tr=tr-stimuli_time(1,1);

a=length(EEG.event)+length(tr);

while i<a

    b=find(tr>(EEG.event(i).latency-EEG.event(1).latency)/EEG.srate & tr<(EEG.event(i+1).latency-EEG.event(1).latency)/EEG.srate);
        
    for j=1:length(b)
        EEG = pop_editeventvals(EEG,'append',{i [] [] []},'changefield',{i+1 'latency'  EEG.event(1).latency/EEG.srate+tr(b(j))},'changefield',{i+1 'type' 'R'});
        i=i+1;
    end
    i=i+1;
end
%%

clear micromed_time
figure
micromed_time=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1,1);

stimuli_time=stimuli_time-stimuli_time(1,1);

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([stimuli_time';stimuli_time'],[0;100],'b')
hold on   