clear all
close all


eeglab

file(1).name='Paciente7Casco_Intero_Bloque3.set';
file(1).path='C:\\Users\\Fabri\\Documents\\INECO\\Pacientes\\Paciente7_JuanCasco\\ConMarcas\\Intero\\';

EEG = pop_loadset('filename',file(1).name,'filepath',file(1).path);
EEG = eeg_checkset( EEG );

eeglab redraw

%%

marktype='chan2'
[micromed_time]=make_photodiodevector_marktype(EEG,marktype);
micromed_time=micromed_time/EEG.srate;

marktype='bloque2'
[init_time]=make_photodiodevector_marktype(EEG,marktype);
init_time=init_time/EEG.srate;

micromed_time=micromed_time-init_time;


%%

log(1).name='casc01_bloque2.mat';
load(['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente7_JuanCasco\Logs\Intero\Casco\Casco\Datos\' log(1).name]);

%%

% delta=0.5;
% ev2erase=find_extramarks2(micromed_time,tiempo_actual, delta);
% 
% micromed_time(ev2erase)=[];
%%

tiempo_actual_2=tiempo_actual_2+micromed_time(2);

%%
index=1;

for i=1:max(size(micromed_time))
   

        rest=tiempo_actual_3-micromed_time(i); 
        mmark=find(abs(rest)<0.2);
        
        if isempty(mmark)
            
            ev2delete(index)=i
            index=index+1;
%             if trial_marks(i)==1
% 
%                 EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'int'});
% 
%             elseif  trial_marks(i)==2
% 
%                 EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'acc'});
% 
%             elseif trial_marks(i)==3
% 
%                 EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'neu'});
% 
%             end

            
            
        end
        
  
end

%%

micromed_time(ev2delete)=[];

%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   
plot([tiempo_actual_3;tiempo_actual_3],[0;150],'g')

