close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente5'
    paradigma='GNG'
    
end

     
path=['C:\Users\Ineco\Documents\IEEG\Pacientes\' paciente '\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path paciente '.edf'],channel);

eeglab redraw

%% Open Event Log file

log_cell=open([path paciente '_event_times.mat']);

% Convert into mat 

%%
j=1;
for i=1:size(log_cell.event_time,1)-1
   
    strings.etype=cell2mat(log_cell.event_time(i+1,3));
    strings.apress=cell2mat(log_cell.event_time(i+1,6));
    
    if strcmp(strings.etype,'Go Right') 
        
                   
            log_times(j)=cell2mat(log_cell.event_time(i+1,4))/1000;
            j=j+1;

       
    end
    
    clear strings;
end



%%

micromed_time2=make_photodiodevector(EEG);


%% Look at the marks and decide which is the first one
% 
% plot([log_times(:)';log_times(:)'],[0;150],'g')
% hold on
% plot([micromed_time2;micromed_time2],[-100;0],'r')
% hold on

%% Complete start_micromed and start_log and correct both vectors

start_micromed=58;
ev2delete=1:1:start_micromed-1;
EEG=delete_mark(EEG,ev2delete);
micromed_time=make_photodiodevector(EEG);

micromed_time=micromed_time-micromed_time(1);

%%
start_log=1;
trial_time=log_times(start_log:max(size(log_times)))-log_times(start_log);


%%

trial_time=trial_time+micromed_time(2); %Go Right

%%

% plot([trial_time(:)';trial_time(:)'],[0;150],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on

%% Search for repeated marks

delta=0.1;
ev2delete=find_repeatedmark(micromed_time, delta);


%% Find the indices of the event associated with a defined type

ev2mark=find_mark2remark(micromed_time,trial_time);
ev2mark=[ev2mark 1844];

%% I have to change the mark type

if max(size(trial_time))==max(size(ev2mark))
    
    for i=1:max(size(ev2mark))
        
         EEG = pop_editeventvals(EEG,'changefield',{ev2mark(i) 'type' 'Go Right'});
        
    end
    
end

disp('done');