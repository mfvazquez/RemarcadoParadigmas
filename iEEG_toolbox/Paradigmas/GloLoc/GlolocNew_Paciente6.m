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
    paradigma='GlobalLocal'
    archivo='gloloc_visual_8trials'
    
end
%%
     
path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

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
load(['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Logs\GlobalLocal\Ausello_Visual_10_06_14_VISUAL_.mat'])
trial_time=[];
logmat(1)=[];
for i=1:size(logmat,2)
   
    trial_time(i)=logmat(i).tiempo;
    
end

trial_time=(trial_time-trial_time(1));

%%
%Paciente 5 Sequence

% micromed_time=micromed_time+trial_time(1);

%%

plot([trial_time;trial_time],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')


%% Remark

for i=1:max(size(trial_time))


        rest=micromed_time-trial_time(i);
        mmark=find(abs(rest)<0.03);
        if ~isempty(mmark)
            tipo=logmat(i).tipo;
            EEG = pop_editeventvals(EEG,'changefield',{mmark(1) 'type' tipo});
            i
        end    
        
end
%% Elimino las marcas que están de más 

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan2') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end

%%

% ev2delete=[];
% ok_mark=[];
%   f=1;
% for i=1:max(size(micromed_time))
%    
%     j=1
%     fin=0;
%   
%     while(fin==0)
%         
%         if(abs(micromed_time(i)-trial_time(j))<0.01)
%             
%             ok_mark(f)=micromed_time(i);
%             f=f+1;
%             fin=1;
%             
%         else
%             
%             j=j+1;
%             
%         end
%         
%     
%         if j==max(size(trial_time))
%             
%             ev2delete=[ev2delete i];
%             fin=1;
%         end
%     end
%     
%     
% end
% 
% %%
% plot([trial_time;trial_time],[-150;150],'b')
% hold on
% plot([ok_mark;ok_mark],[-100;100],'r')
% 
% %%
% 
% ev2delete=ev2delete+9;
% ev2delete=[1:9 ev2delete];
% 
% %%
% 
% EEG=delete_mark(EEG,ev2delete);
% eeglab redraw
% %% 
% 
% clear micromed_time
% 
% 
% 
% for i=1:max(size(EEG.event))
%          
%     micromed_time(i)=EEG.event(i).latency;
%        
% end
% 
% micro1=micromed_time(1);
% 
% micromed_time=micromed_time/EEG.srate;
% micromed_time=micromed_time-micromed_time(1)+trial_time(2);
% %%
% 
% plot([trial_time;trial_time],[-150;150],'b')
% hold on
% plot([micromed_time;micromed_time],[-100;100],'r')
% 
% 
%%
% 
% ev2insert=[];
% f=1;
% 
% for i=1:max(size(trial_time))
%    
%     j=1
%     fin=0;
%   
%     while(fin==0)
%         
%         if(abs(micromed_time(j)-trial_time(i))<0.01)
%             
%             fin=1;
%             
%         else
%             
%             j=j+1;
%             
%         end
%         
%     
%         if j==max(size(micromed_time))
%             
%             ev2insert=[ev2insert i];
%             fin=1;
%      
%         end
%         
%     end
%        
% end
% 
% 
% %%
% clear i;
% 
% for i=2:max(size(ev2insert))
%   
%     EEG = pop_editeventvals(EEG,'append',{ev2insert(i)-2 [] [] []},'changefield',{ev2insert(i)-1 'latency' trial_time(ev2insert(i))-trial_time(2)+micro1/EEG.srate},'changefield',{ev2insert(i)-1 'type' '''new'''});
%     [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
%     eeglab redraw;
% 
% end
% 
% %%
% % 
% ev2=find_repeatedmark(micromed_time, 0.01);
% 
% %%
% 
% EEG=delete_mark(EEG,ev2);
% eeglab redraw
% 
% 
% %%
% % 
% % for t=2:size(logmat,2)
% % 
% %     EEG = pop_editeventvals(EEG,'changefield',{t-1 'type' logmat(t).tipo});
% %        
% % end
% %%%%%%%%%%%%%%%%%5
% 
% % 
% %
% % 
% % %%
% % 
% % for i=1:max(size(EEG.event))
% %          
% %     micromed_time(i)=EEG.event(i).latency;
% %        
% % end
% % 
% % micromed_time=micromed_time/EEG.srate;
% % micromed_time=micromed_time-micromed_time(1)+trial_time(2);
% % 
% % plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
% % hold on
% % plot([micromed_time;micromed_time],[-100;100],'r')
% % 
