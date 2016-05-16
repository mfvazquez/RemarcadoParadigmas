
clear all
close all

eeglab

path='C:\Users\Fabri\Documents\INECO\Pacientes\Paciente4_Peirone\Masters\Intero\Paciente4_Intero.edf'

ev_channel=56;
[EEG]=import_edf(path,ev_channel);
eeglab redraw


%%

load('C:\Users\Fabri\Documents\INECO\Pacientes\Paciente4_Peirone\Logs\Intero\Lunes_15_julio\nicolas-all-intero.mat');

%%


x=0:1:size(data(:,1),1)-1;
y=0:200/1024:size(data(:,1),1)-1;
ecgresampl=interp1(x,data(:,1),y);
ecgsoundresampl=interp1(x,data(:,2),y);

%%

blockpeaksindex=find(abs(ecgsoundresampl(1,:))>0.05);
repeat=find_repeatedmark(blockpeaksindex, 2000);
blockpeaksindex(repeat)=[];
blockpeaksmark=zeros(max(size(ecgsoundresampl)),1);
blockpeaksmark(blockpeaksindex)=1;


% plot(1:1:max(size(ecgsoundresampl)),ecgsoundresampl+30,'r')
% hold on
% plot(blockpeaksmark)


trial_marks=find(blockpeaksmark==1);

%%

% soundchan=[zeros(321303-222511,1) blockpeaksmark]';
soundchan=cat(1,zeros(321303-262050,1),blockpeaksmark);
EEG.data(65,:)=10000*soundchan(1:2712576,1)';


%%
path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\Intero\'
name='nicolas_2.xls'
sheet='nicolas_2'
range='C2:C1261'

trial_time=make_logtimevector2(path,name, sheet, range);
trial_time=trial_time-trial_time(1);



%% old

% mark_vector=[1 2];
% EEG=delete_mark(EEG,mark_vector);
% eeglab redraw
% 
% [micromed_time]=make_photodiodevector(EEG);
% m1=micromed_time(1);
% micromed_time=micromed_time-micromed_time(1);
% 
% %%
% 
% 
% plot([trial_time(:)';trial_time(:)'],[0;150],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on   
% 
% 
% %%  
% 
% delta=0.3;
% ev2delete=find_repeatedmark(micromed_time, delta);
% EEG=delete_mark(EEG,ev2delete);
% 
% %%
% 
% 
% [micromed_time]=make_photodiodevector(EEG);
% micromed_time=micromed_time-micromed_time(1);
% 
% %%
% 
% ECG=open('C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\Intero\PROTOCOLO_INTRACRANEAL\Lunes_15_julio\nicolas-all-intero.mat');
% 
% %% Deteccion de inicio y fin de bloque
% 
% [vector_se]=find(ECG.data(:,2)>0.07);
% lenght=max(size(vector_se));
% 
% for i=1:lenght-1
%    
%     diff(i)=vector_se(i+1)-vector_se(i);
%     
% end
% 
% indices=vector_se(find(diff>5000)+1);
% start_end_vect=[vector_se(1) indices']; %vector de tiempos de inicio y fin de bloque
%                                         %falta el inicio del primer bloque
% 
% %% Change init - fin marks into EEG signal
% 
% EEG = pop_editeventvals(EEG,'changefield',{218 'type' 'finb1'});
% EEG = pop_editeventvals(EEG,'changefield',{286 'type' 'finb2'});
% EEG = pop_editeventvals(EEG,'changefield',{287 'type' 'inb3'});
% EEG = pop_editeventvals(EEG,'changefield',{545 'type' 'finb3'});
% EEG = pop_editeventvals(EEG,'changefield',{546 'type' 'inb4'});
% EEG = pop_editeventvals(EEG,'changefield',{805 'type' 'finb4'});
% EEG = pop_editeventvals(EEG,'changefield',{806 'type' 'inb5'});
% EEG = pop_editeventvals(EEG,'changefield',{1059 'type' 'finb5'});
% EEG = pop_editeventvals(EEG,'changefield',{1060 'type' 'inb6'});
% EEG = pop_editeventvals(EEG,'changefield',{1329 'type' 'finb6'});
% EEG = pop_editeventvals(EEG,'changefield',{1330 'type' 'inb7'});
% EEG = pop_editeventvals(EEG,'changefield',{1608 'type' 'finb7'});
