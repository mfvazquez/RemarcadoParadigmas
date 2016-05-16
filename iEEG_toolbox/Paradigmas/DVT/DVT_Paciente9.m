
clear all
close all
clc

%%
eeglab

path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente9_AlfredoFarinelli\Masters\DVT\'];
   
path=[path_file '20141102_Farinelli_DVT_2_PI.edf' ]
channel=65;  

EEG=import_edf(path,channel);

eeglab redraw
  
% ev2delete=[1:6];
%  
% EEG=delete_mark(EEG,ev2delete)

eeglab redraw

%% Leo los tiempos de las marcas del fotodiodo

micromed_time=make_photodiodevector(EEG);
% 
% micromed_time(1:164)=[];

micromed_time=micromed_time-micromed_time(1,1);

%%

name='20141031_Farinelli_DVT_1.xls';
sheet='hoja1'


path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente9_AlfredoFarinelli\Logs\DVT\'];

% [trial_mark]=make_logmarkvector(path_file,name, sheet, range);

range='C2:C181' %Se perdió el primer trial

[trial_time]=make_logmarkvector(path_file,name, sheet, range);


% [trial_time_temp]=make_logmarkvector(path_file,name, sheet, range);
% oks=1:6:150;
% trial_time=trial_time_temp(oks);

range='F2:F181'
[trial_marks]=make_logmarkvector(path_file,name, sheet, range);

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
    
          
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' trial_marks(i)});
         
                        
        end
        
    
    
end

%%

% %% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan65') == 1
        
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
