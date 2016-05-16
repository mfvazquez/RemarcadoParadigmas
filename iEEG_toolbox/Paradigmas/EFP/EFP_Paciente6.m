%%% OJO, en el paciente 4 se perdió el trial 1
clear all
close all
clc
%%
% 
% automatic= input('Quiere el paciente por deafult? (si/no)','s')
% 
% if automatic=='No'
% 
%     paciente= input('Ingrese el nombre del paciente:','s')
%     paradigma=input('Ingrese el paradigma a trabajar:','s')
% 
% else
%     
%     paciente='Paciente5_Maurobis'
%     paradigma='EFP'
%     
% end
% 
% 
% path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];
% 

%%
eeglab


path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente6_LizandroAusello\Masters\EFP\'];

% Patient 4
   
path=[path_file 'E4P.edf' ]
channel=2;

EEG=import_edf(path,channel);

eeglab redraw

%%

micromed_time=make_photodiodevector(EEG);
% micromed_time(1)=[];
micromed_time=micromed_time-micromed_time(1,1);

%%

name='EFP_Paciente6_2.xls';
sheet='hoja1'


path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente6_LizandroAusello\Logs\EFP\'];

range='C2:C26'

[trial_mark]=make_logmarkvector(path_file,name, sheet, range);

range='A2:A26' %Se perdió el primer trial

[trial_time]=make_logmarkvector(path_file,name, sheet, range);


% [trial_time_temp]=make_logmarkvector(path_file,name, sheet, range);
% oks=1:6:150;
% trial_time=trial_time_temp(oks);

range='B2:B26'
[trial_marks]=make_logmarkvector(path_file,name, sheet, range);

%%

trial_time=(trial_time-trial_time(1))/1000;

%%

% trial_time=trial_time+micromed_time(2)+12;
micromed_time=micromed_time+trial_time(2);

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time';trial_time'],[0;100],'b')
hold on   
 
 
%%


for i=1:max(size(trial_mark))
   
    i
        rest=micromed_time-trial_time(i); 
        mmark=find(abs(rest)<0.1)
        
        if ~isempty(mmark)
    
            if trial_mark(i)==1

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'int'});

            elseif  trial_mark(i)==2

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'acc'});

            elseif trial_mark(i)==3

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'neu'});

            end

            
            
        end
        

    
    
end

%%

% %% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan2') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end


%%

figure
clear micromed_time
micromed_time=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1,1);

micromed_time=micromed_time+trial_time(2); 

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time';trial_time'],[0;100],'b')
hold on   

