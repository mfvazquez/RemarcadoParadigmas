clear all
close all
clc

eeglab

% EEGLAB history file generated on the 28-May-2013
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig('C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\GloLoc\GloLoc_3_Paciente2_Visual_Bloque2.edf');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = pop_chanevent(EEG, 64,'oper','X>1000','edge','leading','edgelen',0,'delchan','off','nbtype',1);
EEG = eeg_checkset( EEG );

eeglab redraw;

%%

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(3);

%%

cd  'C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\GloLoc'

trial_time=xlsread('visual_bloque1.xls','Hoja1');

%%

for i=1:max(size(trial_time))
   
    if trial_time(i,1)>10000
        
        trial_time(i,1)=trial_time(i,1)/1000;
        
    end
       
end

trial_time=trial_time-trial_time(1);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%%

%Borro pulsos BEND


 EEG = pop_editeventvals(EEG,'delete',969);
 EEG = pop_editeventvals(EEG,'delete',968);
 EEG = pop_editeventvals(EEG,'delete',967);
 EEG = pop_editeventvals(EEG,'delete',966);
 EEG = pop_editeventvals(EEG,'delete',965);
 EEG = pop_editeventvals(EEG,'delete',964);
 EEG = pop_editeventvals(EEG,'delete',963);


 EEG = pop_editeventvals(EEG,'delete',639);
 EEG = pop_editeventvals(EEG,'delete',638);
 EEG = pop_editeventvals(EEG,'delete',637);
 EEG = pop_editeventvals(EEG,'delete',636);
 EEG = pop_editeventvals(EEG,'delete',635);
 EEG = pop_editeventvals(EEG,'delete',634);
 EEG = pop_editeventvals(EEG,'delete',633);

 EEG = pop_editeventvals(EEG,'delete',344);
 EEG = pop_editeventvals(EEG,'delete',343);
 EEG = pop_editeventvals(EEG,'delete',342);
 EEG = pop_editeventvals(EEG,'delete',341);

 EEG = pop_editeventvals(EEG,'delete',340);
 EEG = pop_editeventvals(EEG,'delete',338);
 EEG = pop_editeventvals(EEG,'delete',338);
 

 EEG = pop_editeventvals(EEG,'delete',4);
 EEG = pop_editeventvals(EEG,'delete',3);
 EEG = pop_editeventvals(EEG,'delete',2);
 EEG = pop_editeventvals(EEG,'delete',1);

 eeglab redraw;

%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);



%%

micromed_time=micromed_time+trial_time(3);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')




%%


for i=1:max(size(micromed_time))-1
   
    t_diff(i)=micromed_time(i+1)-micromed_time(i);
    
end
%%

for i=1:max(size(trial_time))-1
   
    t_diff_tt(i)=trial_time(i+1)-trial_time(i);
    
end

%%

for i=1:max(size(micromed_time))

    
    t_diff_trial(i)=abs(trial_time(i+4)-micromed_time(i));
    
end

%%

error=find(t_diff_tt<0.09)


%%

anss=EEG.event(1).latency/512;

 for i=1:max(size(error))
     
     t_time=trial_time(error(i));
     
     d=abs(micromed_time-t_time);
     [C I]=min(d)
     EEG = pop_editeventvals(EEG,'insert',{I+1 [] [] []},'changefield',{I+1 'type' 2},'changefield',{I+1 'latency' ''},'changefield',{I+1 'latency' (trial_time(error(i)+1,1)+anss-trial_time(3))});
 
     
 end

 eeglab redraw

 %%
 
clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);



%%

micromed_time=micromed_time+trial_time(3);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%%

     EEG = pop_editeventvals(EEG,'insert',{699 [] [] []},'changefield',{699 'type' 2},'changefield',{699 'latency' ''},'changefield',{699 'latency' (trial_time(709,1)+anss-trial_time(3))});


 eeglab redraw

 %%
 
clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);



%%

micromed_time=micromed_time+trial_time(3);

%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')

%%


     EEG = pop_editeventvals(EEG,'insert',{1036 [] [] []},'changefield',{1036 'type' 2},'changefield',{1036 'latency' ''},'changefield',{1036 'latency' (trial_time(1050,1)+anss-trial_time(3))});


 eeglab redraw

 %%
 
 EEG = pop_editeventvals(EEG,'delete',1014);
 EEG = pop_editeventvals(EEG,'delete',1013);
 EEG = pop_editeventvals(EEG,'delete',1012);
 EEG = pop_editeventvals(EEG,'delete',1011);

 eeglab redraw
