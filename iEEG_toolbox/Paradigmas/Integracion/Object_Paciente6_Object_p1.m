%%
close all
clear all
clc

addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\')


%% Enter Patient info. Ask if we  are using the default patient (just
%  in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No' | automatic=='NO' | automatic=='no'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente6_LizandroAusello'
    paradigma='Integracion'
    archivo='\Objetos\Parra_Objetos_ParteI'
    
end
%%
path=['D:\_INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;


EEG=import_edf([path  archivo '.edf'],channel); %Paciente5

eeglab redraw



%%


for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micro1=micromed_time(1);


micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1);

%%

path=['D:\_INECO\Pacientes\' paciente '\Logs\' paradigma '\']
file='\Objetos\Parra_ObjectBindingFeatures_Ausello_09_06_14'
sheet='Parra_ObjectBindingFeatures_Aus'


Range='C2:C66'
Range2='D2:D66'
Range3='E2:E66'
Range4='F2:F66'
Range5='G2:G66'
Range6='I2:I66'

% Range='A90:A179'
% Range2='B90:B179'
% Range3='C90:C179'

trial_time(:,1)=make_logtimevector(path,file,sheet,Range);  %OS1
trial_time(:,2)=make_logtimevector(path,file,sheet,Range2); %OS2
trial_time(:,3)=make_logtimevector(path,file,sheet,Range3); %0S3
trial_time(:,4)=make_logtimevector(path,file,sheet,Range4); %OTS2
trial_time(:,5)=make_logtimevector(path,file,sheet,Range5); %R
acc=make_logtimevector(path,file,sheet,Range6);



trial_time=(trial_time-trial_time(1));

% %%
% %Paciente 5 Sequence
% 
% micromed_time=micromed_time-trial_time(1,2);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[0;150],'b')
hold on

for t=2:5
    plot([trial_time(:,t)';trial_time(:,t)'],[0;150],'g')
    hold on
end
hold on
plot([micromed_time;micromed_time],[-100;100],'r')


%% Remark PARA BINDING
% 
for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,1); %OS1
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['1Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end

for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,2); %OS2
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['2Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end

for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,3); %OS3
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['3Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
        end
        
end


for i=1:max(size(trial_time),1)


        rest=micromed_time-trial_time(i,4); %OTS2
        mmark=find(abs(rest)<0.05);
        if ~isempty(mmark)
            
            tipo=['5Acc' num2str(acc(i))];
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            mmark(1)
            
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

% %%
% 
% % ev2delete=[];
% % ok_mark=[];
% %   f=1;
% % for i=1:max(size(micromed_time))
% %    
% %     j=1
% %     fin=0;
% %   
% %     while(fin==0)
% %         
% %         if(abs(micromed_time(i)-trial_time(j))<0.01)
% %             
% %             ok_mark(f)=micromed_time(i);
% %             f=f+1;
% %             fin=1;
% %             
% %         else
% %             
% %             j=j+1;
% %             
% %         end
% %         
% %     
% %         if j==max(size(trial_time))
% %             
% %             ev2delete=[ev2delete i];
% %             fin=1;
% %         end
% %     end
% %     
% %     
% % end
% % 
% % %%
% % plot([trial_time;trial_time],[-150;150],'b')
% % hold on
% % plot([ok_mark;ok_mark],[-100;100],'r')
% % 
% % %%
% % 
% % ev2delete=ev2delete+9;
% % ev2delete=[1:9 ev2delete];
% % 
% % %%
% % 
% % EEG=delete_mark(EEG,ev2delete);
% % eeglab redraw
% % %% 
% % 
% % clear micromed_time
% % 
% % 
% % 
% % for i=1:max(size(EEG.event))
% %          
% %     micromed_time(i)=EEG.event(i).latency;
% %        
% % end
% % 
% % micro1=micromed_time(1);
% % 
% % micromed_time=micromed_time/EEG.srate;
% % micromed_time=micromed_time-micromed_time(1)+trial_time(2);
% % %%
% % 
% % plot([trial_time;trial_time],[-150;150],'b')
% % hold on
% % plot([micromed_time;micromed_time],[-100;100],'r')
% % 
% % 
% %%
% % 
% % ev2insert=[];
% % f=1;
% % 
% % for i=1:max(size(trial_time))
% %    
% %     j=1
% %     fin=0;
% %   
% %     while(fin==0)
% %         
% %         if(abs(micromed_time(j)-trial_time(i))<0.01)
% %             
% %             fin=1;
% %             
% %         else
% %             
% %             j=j+1;
% %             
% %         end
% %         
% %     
% %         if j==max(size(micromed_time))
% %             
% %             ev2insert=[ev2insert i];
% %             fin=1;
% %      
% %         end
% %         
% %     end
% %        
% % end
% % 
% % 
% % %%
% % clear i;
% % 
% % for i=2:max(size(ev2insert))
% %   
% %     EEG = pop_editeventvals(EEG,'append',{ev2insert(i)-2 [] [] []},'changefield',{ev2insert(i)-1 'latency' trial_time(ev2insert(i))-trial_time(2)+micro1/EEG.srate},'changefield',{ev2insert(i)-1 'type' '''new'''});
% %     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
% %     eeglab redraw;
% % 
% % end
% % 
% % %%
% % % 
% % ev2=find_repeatedmark(micromed_time, 0.01);
% % 
% % %%
% % 
% % EEG=delete_mark(EEG,ev2);
% % eeglab redraw
% % 
% % 
% % %%
% % % 
% % % for t=2:size(logmat,2)
% % % 
% % %     EEG = pop_editeventvals(EEG,'changefield',{t-1 'type' logmat(t).tipo});
% % %        
% % % end
% % %%%%%%%%%%%%%%%%%5
% % 
% % % 
% % %
% % % 
% % % %%
% % % 
% % % for i=1:max(size(EEG.event))
% % %          
% % %     micromed_time(i)=EEG.event(i).latency;
% % %        
% % % end
% % % 
% % % micromed_time=micromed_time/EEG.srate;
% % % micromed_time=micromed_time-micromed_time(1)+trial_time(2);
% % % 
% % % plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
% % % hold on
% % % plot([micromed_time;micromed_time],[-100;100],'r')
% % % 
