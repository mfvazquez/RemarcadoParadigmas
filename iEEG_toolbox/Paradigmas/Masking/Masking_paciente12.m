
clear all
close all
clc


restoredefaultpath
addpath('D:\Fabri\iEEG_toolbox\')
addpath('C:\matlab_toolbox\eeglab11_0_4_3b\')


%%
eeglab

path_file=['D:\Fabri\Pacientes\Paciente12_LB\Masters\Valdas\'];
   
path=[path_file 'Valdas_masking.edf' ];
channel=8;  

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

name='Masking_paciente12.xls';
sheet='hoja1';


path_file=['D:\Fabri\Pacientes\Paciente12_LB\Logs\Masking_intra\'];

% [trial_mark]=make_logmarkvector(path_file,name, sheet, range);

range='C1:C504'; %Se perdió el primer trial

[trial_time(:,1)]=make_logmarkvector(path_file,name, sheet, range);


% [trial_time_temp]=make_logmarkvector(path_file,name, sheet, range);
% oks=1:6:150;
% trial_time=trial_time_temp(oks);

range='E1:E504';
[trial_time(:,2)]=make_logmarkvector(path_file,name, sheet, range);

range='B1:B504';
[trial_marks]=make_logmarkvector(path_file,name, sheet, range);

range='D1:D504';
[trial_resp]=make_logmarkvector(path_file,name, sheet, range);

%%

trial_time(:,1)=(trial_time(:,1)-trial_time(1,1));

trial_time(:,2)=(trial_time(:,2)-trial_time(1,1));
%%
%  
% micromed_time=micromed_time+trial_time(2); 

%%
% 
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time(:,1)';trial_time(:,1)'],[0;100],'b')
hold on   

plot([trial_time(:,2)';trial_time(:,2)'],[0;100],'g')
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
         
         rest=micromed_time-trial_time(i,1);
         mmark=find(abs(rest)<0.07);
         
         if (~isempty(mmark))
             
             
             EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' trial_marks(i)});
             
             
         end
         
         
     end
     
     for i=1:max(size(trial_marks))
         
         rest=micromed_time-trial_time(i,2);
         mmark=find(abs(rest)<0.07);
         
         if (~isempty(mmark))
             
             
             EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' [num2str(trial_marks(i)) '-' num2str(trial_resp(i)) ]});
             
             
         end
         
         
     end

%%

% %% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan8') == 1
        
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

plot([trial_time(:,1)';trial_time(:,1)'],[0;100],'b')
hold on   

plot([trial_time(:,2)';trial_time(:,2)'],[0;100],'g')
hold on   
