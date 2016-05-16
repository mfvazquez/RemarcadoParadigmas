
clear all
close all
clc

restoredefaultpath
addpath('D:\FLOR\iEEG_toolbox\')
addpath('C:\Toolbox\eeglab11_0_4_3b\')


%%
eeglab

path_file=['D:\FLOR\Pacientes\Paciente13_RM\Masters\Adolf_FWTask\'];
   
path=[path_file 'RamiroMilliaFWT.edf' ];
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
% micromed_time=micromed_time(1,5:end);

%%

path=['D:\FLOR\Pacientes\Paciente13_RM\Logs Millia Ramiro\FWT\'];
time_file=[path 'log_times.mat'];
load (time_file);

stimuli_time=cell2mat(times(1,:)); %Levanto el tiempo de los estímulos

response_time=cell2mat(times(2,:)); %Levanto el tiempo de las respuestas

%%

marks_file1=[path 'log.mat'];
marks_file2=[path 'log2.mat'];

load (marks_file1);
stimuli_marks1=cellfun(@cell2mat,respMat(3,:), 'UniformOutput', false);
response_marks1=respMat(4,:);

load (marks_file2);
stimuli_marks2=cellfun(@cell2mat,respMat2(3,:), 'UniformOutput', false);
response_marks2=respMat2(4,:);

stimuli_marks=[stimuli_marks1 stimuli_marks2];
response_marks=[response_marks1 response_marks2];

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([stimuli_time;stimuli_time],[0;100],'b')
hold on   
 
plot([response_time;response_time],[0;100],'g')
hold on   
 %%

for i=1:max(size(stimuli_time))
   
        rest=micromed_time-stimuli_time(i); 
        mmark=find(abs(rest)<0.07);
        
        if ~isempty(mmark)
    
         
                EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' stimuli_marks{i}});
         
                        
        end
        
end

for j=1:max(size(response_time))
   
        rest=micromed_time-response_time(j); 
        mmark=find(abs(rest)<0.15);
        
        if ~isempty(mmark) & ~isempty(response_marks{j})
    
                EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' response_marks{j}});
         
                        
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

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([stimuli_time;stimuli_time],[0;100],'b')
hold on   
 
plot([response_time;response_time],[0;100],'g')
hold on   