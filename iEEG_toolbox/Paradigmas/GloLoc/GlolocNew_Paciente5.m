%%


close all
clear all
clc

%% Enter Patient info. Ask if we  are using the default patient (just
%  in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No' | automatic=='NO' | automatic=='no'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente5'
    paradigma='Gloloc_Sequence'
    
end
%%
     
path=['C:\Users\Ineco\Documents\IEEG\Pacientes\' paciente '\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;


EEG=import_edf([path paciente '.edf'],channel); %Paciente5

eeglab redraw



%%


for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/EEG.srate;
% micromed_time=micromed_time-micromed_time(3); Paciente 5 Visual
micromed_time=micromed_time-micromed_time(1);



name=[paciente '_' paradigma '.xls']
sheet=[paciente '_' paradigma]
% range= ['C1:C3379'] Paciente 5 Visual
range= ['C1:C1352']


[trial_time_full.times]=read_xls(path,name, sheet, range);

range= ['B1:B1352']

[trial_time_full.type]=read_xls2(path,name, sheet, range);



trial_type=cell2mat(trial_time_full.type);
trial_time=trial_time_full.times;
ev2clear=find(trial_time<trial_time(1));
trial_time(ev2clear)=trial_time(ev2clear)*10;
trial_time=(trial_time-trial_time(1))/10;

%%

%Paciente 5 Sequence

trial_time(1:3)=[];
micromed_time=micromed_time+trial_time(2);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')


%%
% 
% ev2delete=find_repeatedmark(micromed_time, 0.04); %acepto un error de 40ms
% EEG=delete_mark(EEG,ev2delete);
% eeglab redraw
% 
% 
%  
% %%
% 
% 
% 
% for i=1:max(size(EEG.event))
%          
%     micromed_time(i)=EEG.event(i).latency;
%        
% end
% 
% micromed_time=micromed_time/EEG.srate;
% %micromed_time=micromed_time-micromed_time(3); Paciente 5 Visual
% 
% micromed_time=micromed_time-micromed_time(1);
 
%% Remark

for i=1:max(size(trial_time))


        rest=micromed_time-trial_time(i);
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            tipo=num2str(cell2mat(trial_time_full.type(i)));
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            i
        end    
        
end
%% 

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan2') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end


%%

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1)+trial_time(2);

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

