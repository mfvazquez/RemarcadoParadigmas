
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
EEG=import_edf(edf_file,CHANNEL);
eeglab redraw

%% Leo los tiempos de las marcas del fotodiodo

micromed_time=make_photodiodevector(EEG);
ev2delete=[1 2 110 length(micromed_time)];
EEG=delete_mark(EEG,ev2delete);
micromed_time=make_photodiodevector(EEG);
micromed_time = micromed_time - micromed_time(1);


%% ---------------- LOG ---------------------------------------------------

log_file=fullfile('log', 'Fanny', '14_D1', '114RandomSequenceBlock1.mat');
load(log_file);
stimTrigSentTime = stimTrigSentTime(stimTrigSentTime~=0);
stimTrigSentTime = stimTrigSentTime - stimTrigSentTime(1,1);
stimTrigSentTime = stimTrigSentTime + micromed_time(1,3);

%%
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   
plot([stimTrigSentTime';stimTrigSentTime'],[0;100],'b')

 %%

for i=1:max(size(stimTrigSentTime))
  
        rest=micromed_time-stimTrigSentTime(i); 
        mmark=find(abs(rest)<0.05);
        
        if ~isempty(mmark)
            
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'Stim'});
                        
        end
        
end

for i = 1:10

    mmark_random = 1+12*(i-1);
    
    EEG = pop_editeventvals(EEG,'changefield',{mmark_random 'type' 'Random'});
    EEG = pop_editeventvals(EEG,'changefield',{mmark_random+1 'type' 'Move'});
    
end


%% Agrego las respuestas
shift = 0;
n = 0;
for i = 1:length(EEG.event)
    i
    if strcmp(EEG.event(i+shift).type, 'Stim')
        n = n+1
        if (reactionTime(n) ~= 0)
            event_time = EEG.event(i+shift).latency/EEG.srate
            value = event_time + reactionTime(n)
            EEG = pop_editeventvals(EEG,'add',{i+shift value});
            EEG = pop_editeventvals(EEG,'changefield',{i+1+shift 'type' 'Reaction'});
            shift = shift + 1
        end
    end
end

%% GUARDO EL SET

set_path = fullfile('..','ConMarcas','Fanny','Paciente14');

EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','MI_d1_Random.set','filepath',set_path);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

