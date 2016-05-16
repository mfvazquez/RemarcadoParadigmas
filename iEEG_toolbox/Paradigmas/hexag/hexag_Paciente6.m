
close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente6_LizandroAusello'
    paradigma='Hexagono'
    archivo='hexagono_day1';
    
end

%%
     
path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path archivo '.edf'],channel);

eeglab redraw


%%
for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end
 
micro1=micromed_time(1);

micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1);


path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Logs\' paradigma '\'];
sheet='Ausello_10_06_14 20140610_hexag'
name='Ausello_10_06_14 20140610_hexag_0.xls'
range='F2:F15380'

[trial_time.strobe]=read_xls(path,name, sheet, range);

range='A2:A15380'

[trial_time.time]=read_xls(path,name, sheet, range);


range='G2:G15380'
[trial_time.win]=read_xls(path,name, sheet, range);

trial_time.time(1492:max(size(trial_time.time)))=trial_time.time(1492:max(size(trial_time.time)))*1000;

trial_time.time=trial_time.time-trial_time.time(1);

trial_time.time=trial_time.time/1000;

trial_time.time(find(trial_time.strobe==0))=[];


micromed_time=micromed_time+trial_time.time(10);

%%


plot([trial_time.time(:,1)';trial_time.time(:,1)'],[0;150],'b')

hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%%

for i=1:max(size(trial_time.time),1)


        rest=micromed_time-trial_time.time(i); %OS1
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['Strobe_' num2str(i)];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end
%%

% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan2') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end


%%

% stem(trial_time.strobe,'r')
% hold on
% stem(trial_time.win,'b')
% ylim([0 5])
% axis on

%%

