close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
%  in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No' | automatic=='NO' | automatic=='no'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente6_LizandroAusello'
    paradigma='Ultimatum'
    archivo='Ultimatum'
    
end

     
path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;


EEG=import_edf([path  archivo '.edf'],channel); %Paciente5_2

% EEG=import_edf([path paciente '.edf'],channel); Paciente 5

eeglab redraw

%% Read Log File

% Paciente 5
% name=[paciente '_' paradigma '.xls']
% sheet=[paciente '_' paradigma]
% range= ['G15:G259']
% path_log=[path 'logfiles\'];

path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Logs\' paradigma '\'];

name=['UG_task_MOD_AI_P1d2_blink.xls']
sheet=['UG_task_MOD_AI_P1d2_blink']
range= ['E6:E634']
path_log=[path];

[trial_time_full.times]=read_xls(path_log,name, sheet, range);

range= ['D6:D634']
trial_time_full.type=read_xls2(path_log,name, sheet, range);



% range= ['E11:E202']
% trial_time_full.RT=read_xls(path_log,name, sheet, range);


%%

trial_time=trial_time_full.times;
trial_time=trial_time-trial_time(1);
trial_time=trial_time/10;



%trial_time(185:max(size(trial_time)))=[]; Paciente 5

%%

%%Paciente5
% [micromed_time]=make_photodiodevector(EEG);
% delta=0.2;
% ev2delete=find_repeatedmark(micromed_time, delta);
% micromed_time(ev2delete)=[];
% micromed_time(1:6)=[];
% micromed_time=micromed_time-micromed_time(1);
% 
% EEG=delete_mark(EEG,[1:6 ev2delete]);
% [micromed_time]=make_photodiodevector(EEG);
% micromed_time=micromed_time-micromed_time(1);

%Paciente5_2

[micromed_time]=make_photodiodevector(EEG);
delta=0.2;
ev2delete=find_repeatedmark(micromed_time, delta);
micromed_time(ev2delete)=[];
micromed_time(1)=[];
micromed_time=micromed_time-micromed_time(1);

EEG=delete_mark(EEG,[1 ev2delete]);
%%

[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1)+trial_time(21);


%%

plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on

%PARECE QUE EL EDF ESTA PARTIDO EN 2

%% Remark Process


for i=1:max(size(trial_time))

    j=1;
    while(j<max(size(EEG.event)))
        
        marca=EEG.event(j).latency/EEG.srate-EEG.event(1).latency/EEG.srate;
        
        diff=abs(marca-trial_time(i))
        
        if(diff<0.2)
           
            tipo=num2str(cell2mat(trial_time_full.type(i)));
            EEG = pop_editeventvals(EEG,'changefield',{j 'type' tipo});
            j
         j=1000;   
        else
            
            j=j+1;
            
        end
        
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

%% Add Response time marks

trial_time_full.RT(find(isnan(trial_time_full.RT)))=[];

