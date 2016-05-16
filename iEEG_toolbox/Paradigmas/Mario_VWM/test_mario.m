%%

path='C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\9_VWM_Mario\Single_color\'
file='VWM_Color_Single_Bloque1'
sheet='Sheet1'
Range='A1:A179'
Range2='B1:B179'
Range3='C1:C179'
 
% Range='A90:A179'
% Range2='B90:B179'
% Range3='C90:C179'

trial_time(:,1)=make_logtimevector(path,file,sheet,Range);
trial_time(:,2)=make_logtimevector(path,file,sheet,Range2);
trial_time(:,3)=make_logtimevector(path,file,sheet,Range3);

%% Cargo vector de marcas de photodiode

[micromed_time]=make_photodiodevector(EEG);
micro_1= micromed_time(1,1);

%% referencio todo al inicio

micromed_time=micromed_time- micromed_time(1,1);
trial_time=trial_time-trial_time(1,1);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on
plot([trial_time(:,2)';trial_time(:,2)'],[0;150],'b')
hold on
plot([trial_time(:,3)';trial_time(:,3)'],[0;150],'k')
hold on

%% WBW Bloque 1
  insertar=trial_time(6:80,3)+micro_1;
 


for i=1:max(size(insertar))

    EEG = pop_editeventvals(EEG,'insert',{(18+3*(i-1)) [] [] []},'changefield',{(18+3*(i-1)) 'type' 2},'changefield',{(18+3*(i-1)) 'latency' ''},'changefield',{(18+3*(i-1)) 'latency' insertar(i)});

end
eeglab redraw

%% WBW  Bloque2

indices=[6 19 20 23 27 32 47 49 51 53 60 62 68 82 89 90];

insertar=trial_time([6 19 20 23 27 32 47 49 51 53 60 62 68 82 89 90],3)+micro_1;

%% WC  Bloque1

indices=[26 73 80];

insertar=trial_time(indices,3)+micro_1;



%%

for i=1:max(size(insertar))

    EEG = pop_editeventvals(EEG,'insert',{indices(i) [] [] []},'changefield',{indices(i) 'type' 2},'changefield',{indices(i) 'latency' ''},'changefield',{indices(i) 'latency' insertar(i)});

end

eeglab redraw

%% Whole color

 EEG = pop_editeventvals(EEG,'delete',232);
 EEG = pop_editeventvals(EEG,'delete',141);
 eeglab redraw

%% WholeBW

 EEG = pop_editeventvals(EEG,'delete',269);
 
 eeglab redraw
 
 %% SP color

 EEG = pop_editeventvals(EEG,'delete',239);
 EEG = pop_editeventvals(EEG,'delete',238);
 eeglab redraw