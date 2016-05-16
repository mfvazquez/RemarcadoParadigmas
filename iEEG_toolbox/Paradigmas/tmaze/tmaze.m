
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
    paradigma='TMaze'
    
end

     
path=['C:\Users\Ineco\Documents\IEEG\Pacientes\' paciente '\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path paciente '.edf'],channel);

eeglab redraw


%%


path=['C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente5\TMaze\']
sheet='paciente5 20140209_tmaze_0'
name='paciente5 _tmaze.xls'
range='F2:F35484'

[trial_time_struct.strobe]=read_xls(path,name, sheet, range);


range='G2:G35484'
[trial_time_struct.win]=read_xls(path,name, sheet, range);

range='A2:A35484'
[trial_time_struct.times]=read_xls(path,name, sheet, range);
%%

[micromed_time]=make_photodiodevector(EEG);
delta=0.2;
ev2delete=find_repeatedmark(micromed_time, delta);
micromed_time([1 ev2delete])=[];
micromed_time=micromed_time-micromed_time(1);

EEG=delete_mark(EEG,[1 ev2delete]);

clear micromed_time;
[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);
%%

strobe=find(trial_time_struct.strobe>0);
trial_time=trial_time_struct.times(strobe);
trial_time(25:321)=trial_time(25:321)*1000;
trial_time=trial_time-trial_time(1);
trial_time=trial_time/1000;
%%

% plot([trial_time(:)';trial_time(:)'],[0;150],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on


%% busco los estímulos 1 (guía)
% 
% 
% Slose=find(trial_time_struct.strobe>0 & trial_time_struct.win == 1); %lose
% trial_time2=trial_time_struct.times(Slose);
% trial_time2(3:38)=trial_time2(3:38)*1000;
% trial_time2=trial_time2-trial_time2(1);
% trial_time2=trial_time2/1000;
% trial_time2=trial_time2+trial_time(4);
%%
% 
% 
% plot([trial_time2(:)';trial_time2(:)'],[0;1],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on
% plot([trial_time(:)';trial_time(:)'],[1;150],'b')

%%


delta=0.5;
ev2erase=find_extramarks2(micromed_time,trial_time2,delta)
micromed_time(ev2erase)=[];

EEG=delete_mark(EEG,[ev2erase]);
 
 clear micromed_time;
 [micromed_time]=make_photodiodevector(EEG);
 micromed_time=micromed_time-micromed_time(1);
 
%%

insert=insert_missingmarks(micromed_time, trial_time2)-1

%%

insertar=trial_time(insert)+EEG.event(1).latency/EEG.srate;

%%

for i=1:max(size(insertar))
   
      EEG = pop_editeventvals(EEG,'insert',{insertar(i) [] [] []},'changefield',{insertar(i) 'type' 1},'changefield',{insertar(i) 'latency' ''},'changefield',{insertar(i) 'latency' insertar(i)});
     
    
end

eeglab redraw
 
