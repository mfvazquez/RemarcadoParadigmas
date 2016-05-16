%%% OJO, en el paciente 4 se perdió el trial 1

clear all
close all
clc

%%
eeglab

path_file=['D:\_INECO\Pacientes\Paciente10_Repossini\Masters\EFP\'];
   
path=[path_file '20141128_Repossini_Empatia.edf' ]
channel=64;  

EEG=import_edf(path,channel);

eeglab redraw
  
ev2delete=[1];
 
EEG=delete_mark(EEG,ev2delete)

eeglab redraw

%%

micromed_time=make_photodiodevector(EEG);

%  micromed_time(1)=[];

micromed_time=micromed_time-micromed_time(1,1);

%%

name='20141128_Repossini_EFP_9.xls';
sheet='hoja1'


path_file=['D:\_INECO\Pacientes\Paciente10_Repossini\Logs\EFP\'];

% [trial_mark]=make_logmarkvector(path_file,name, sheet, range);

range='A2:A26' %Se perdió el primer trial

[trial_time]=make_logmarkvector(path_file,name, sheet, range);



% [trial_time_temp]=make_logmarkvector(path_file,name, sheet, range);
% oks=1:6:150;
% trial_time=trial_time_temp(oks);

range='C2:C26'
[trial_marks]=make_logmarkvector(path_file,name, sheet, range);

range='E2:E26' %Se perdió el primer trial

[trial_marks_gold]=make_logmarkvector(path_file,name, sheet, range);

%%

trial_time=(trial_time-trial_time(1))/1000;


%%
%  
% micromed_time=micromed_time+trial_time(2); 

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time';trial_time'],[0;100],'b')
hold on   
 
 
 %%

%  EEG=delete_mark(EEG,[1 2]);
%  eeglab redraw;
%  EEG=delete_mark(EEG,ev2delete);
%  eeglab redraw;
 
 %%
 
%  micromed_time=make_photodiodevector(EEG);
%  micromed_time=micromed_time-micromed_time(1,1);
%  
 
 %%


for i=1:max(size(trial_marks))
   

        rest=micromed_time-trial_time(i); 
        mmark=find(abs(rest)<0.05)
        
        if ~isempty(mmark)
    
            if trial_marks_gold(i)==1

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'int'});

            elseif  trial_marks_gold(i)==2

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'acc'});

            elseif trial_marks_gold(i)==3

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'neu'});

            end

            
            
        end
        

    
    
end

%%

% %% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan64') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end


%%

clear micromed_time
figure
micromed_time=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1,1);

% micromed_time=micromed_time+trial_time(2); 


plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time';trial_time'],[0;100],'b')
hold on   
