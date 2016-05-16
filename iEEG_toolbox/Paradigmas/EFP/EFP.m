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
micromed_time(1)=[];
micromed_time=micromed_time-micromed_time(1,1);

%% Eliminar marcas repetidas

delta=3;
ev2delete=find_repeatedmark(micromed_time, delta)
micromed_time(ev2delete)=[];

%%

% micromed_time=make_photodiodevector(EEG);
% micromed_time=micromed_time-micromed_time(1,1);

% %%
diff=diff_invector(micromed_time)

%%

name='EFP_Paciente6.xls';
sheet='hoja1'


path_file=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente6_LizandroAusello\Logs\EFP\'];

% [trial_mark]=make_logmarkvector(path_file,name, sheet, range);

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

trial_time=trial_time+micromed_time(2)+12;
 

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([trial_time';trial_time'],[0;100],'b')
hold on   


 
 
 %%

 EEG=delete_mark(EEG,[1 2]);
 eeglab redraw;
 EEG=delete_mark(EEG,ev2delete);
 eeglab redraw;
 
 %%
 
 micromed_time=make_photodiodevector(EEG);
 micromed_time=micromed_time-micromed_time(1,1);
 
 
 %%


for i=1:max(size(trial_marks))
   
    if trial_marks(i)==1
    
        EEG = pop_editeventvals(EEG,'changefield',{2*i-1 'type' 'int'});
    
    elseif  trial_marks(i)==2
        
        EEG = pop_editeventvals(EEG,'changefield',{2*i-1 'type' 'acc'});
        
    elseif trial_marks(i)==3
        
        EEG = pop_editeventvals(EEG,'changefield',{2*i-1 'type' 'neu'});
    
    end
    
end



%%

% diff2=diff_invector(trial_time)


%%

%micromed_time=micromed_time+trial_time(2)

