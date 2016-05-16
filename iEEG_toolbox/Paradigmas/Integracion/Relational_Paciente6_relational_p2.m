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
    
    paciente='Paciente6_LizandroAusello'
    paradigma='Integracion'
    archivo='\Relational\Parra_Relational_ParteII'
    
end
%%
     
path=['D:\_INECO\Pacientes\' paciente '\Masters\' paradigma '\'];


% Open EDF file into EEGLAB 

channel=2;


EEG=import_edf([path  archivo '.edf'],channel); %Paciente5

eeglab redraw



%%
ev2delete=1:25;
EEG=delete_mark(EEG,ev2delete);
eeglab redraw


for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micro1=micromed_time(1);

micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1);

%%

path=['D:\_INECO\Pacientes\' paciente '\Logs\' paradigma '\']
file='\Relational\relational_integracion_Ausello3_parte2'
sheet='ausello_parte2_12_06_14'


Range='C67:C131'
Range2='D67:D131'
Range3='E67:E131'
Range4='F67:F131'
Range5='G67:G131'
Range6='I67:I131'

% Range='A90:A179'
% Range2='B90:B179'
% Range3='C90:C179'

trial_time(:,1)=make_logtimevector(path,file,sheet,Range);
trial_time(:,2)=make_logtimevector(path,file,sheet,Range2);
trial_time(:,3)=make_logtimevector(path,file,sheet,Range3);
trial_time(:,4)=make_logtimevector(path,file,sheet,Range4);
trial_time(:,5)=make_logtimevector(path,file,sheet,Range5);
acc=make_logtimevector(path,file,sheet,Range6);

trial_time=(trial_time-trial_time(1));

%%

%Paciente 6

 
% micromed_time=micromed_time+trial_time(3,1);


%%

plot([trial_time(:,1)';trial_time(:,1)'],[0;150],'b')
hold on

for t=2:4
    plot([trial_time(:,t)';trial_time(:,t)'],[0;150],'g')
    hold on
end
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%% Remark PARA BINDING
 
for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,1); %OS1
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['22Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end

for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,2); %OS2
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['23Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end

for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,3); %OS3
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['24Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end


for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,4); %OTS2
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['26Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end


% %%
% 
% % %% Elimino las marcas que están de más
% 
p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan2') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end

%%



clear micromed_time

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micro1=micromed_time(1);

micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1);


plot([trial_time(:,1)';trial_time(:,1)'],[0;150],'b')
hold on

for t=2:5
    plot([trial_time(:,t)';trial_time(:,t)'],[0;150],'g')
    hold on
end
hold on
plot([micromed_time;micromed_time],[-100;100],'r')
% % 