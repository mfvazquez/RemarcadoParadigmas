clear all
close all
clc


% Datos del registro a remarcar

% paciente='Paciente5_bis'
% paradigma='Andrea\Sce1\Sce1'

paciente='Paciente5_bis'
paradigma='Andrea\Obj2\Obj2'


% Carga del registro

path=['C:\Users\Fabri\Documents\INECO\Resultados\' paciente '\' paradigma];
channel=2; %Canal con marcas
EEG=import_edf([path '.edf'],channel);
eeglab redraw

%% Armo vector de marcas EEG

[micromed_time]=make_photodiodevector(EEG);
% delta=0.2;
% ev2delete=find_repeatedmark(micromed_time, delta);

% micromed_time([1 ev2delete])=[]; %SceneExp1
% micromed_time(563)=[];

% micromed_time([ev2delete])=[]; % SceneExp2
% micromed_time([563 564])=[];


% micromed_time([ev2delete])=[]; % ObjExp1
% micromed_time([626])=[];


% micromed_time([ev2delete])=[]; % ObjExp2
% micromed_time([626 627])=[];

micromed_time=micromed_time-micromed_time(1);

%%

path=['C:\Users\Fabri\Documents\INECO\Resultados\' paciente '\Andrea\Logs\']
% sheet='results_sceneExp1_mauro'
% name='results_sceneExp1_mauro.xls'
% sheet='results_sceneExp2_mauro'
% name='results_sceneExp2_mauro.xls'
% 
% range='G8:G569'
% 
% sheet='results_objectExp1_mauro'  
% name='results_objectExp1_mauro.xls'


sheet='results_objectExp2_mauro'  
name='results_objectExp2_mauro.xls'

range='G8:G632'



[trial_time]=read_xls(path,name, sheet, range);
trial_time=trial_time-trial_time(1);
trial_time=trial_time/1000;

%%

plot([trial_time(:)';trial_time(:)'],[0;10],'g')
hold on
plot([micromed_time;micromed_time],[-10;0],'r')
hold on

%%

% diff=diff_marcas(micromed_time,trial_time);

%%

% mark_num=[1 ev2delete]; %SceneExp2
mark_num=[ev2delete];
EEG=delete_mark(EEG,mark_num);

eeglab redraw

%%
 
% mark_num=563; %SceneExp1
% mark_num=[563 564] %SceneExp2
% mark_num=[626] %ObjExp1
mark_num=[626 627]
EEG=delete_mark(EEG,mark_num);
eeglab redraw


