
close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No' | automatic=='no' | automatic=='NO'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente5_Mauro'
    paradigma='TMaze'
    
end

     
path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path paciente '.edf'],channel);

eeglab redraw


%%


path=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente5_Mauro\Log\TMaze\']
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
%%

clear micromed_time;
[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);

%%

strobe=find(trial_time_struct.strobe>0);
trial_time=trial_time_struct.times(strobe);
trial_time(25:321)=trial_time(25:321)*1000;
trial_time=trial_time-trial_time(1);
trial_time=trial_time/1000;

%% busco los estímulos 1 (guía)
  
Slose=find(trial_time_struct.strobe>0 & trial_time_struct.win == 1); %lose
trial_time2=trial_time_struct.times(Slose);
trial_time2(3:38)=trial_time2(3:38)*1000;
trial_time2=trial_time2-trial_time2(1);
trial_time2=trial_time2/1000;
trial_time2=trial_time2+trial_time(4);

%%

for i=1:max(size(trial_time2))

    j=1;
    while(j<max(size(EEG.event)))
        
        marca=EEG.event(j).latency/EEG.srate-EEG.event(1).latency/EEG.srate;
        
        diff=abs(marca-trial_time2(i))
        
        if(diff<0.5)
           
            EEG = pop_editeventvals(EEG,'changefield',{j 'type' 'lose'});
            j
         j=1000;   
        else
            
            j=j+1;
            
        end
        
    end
    
end

%%

plot([trial_time(:)';trial_time(:)'],[5;150],'g')
hold on
plot([trial_time2(:)';trial_time2(:)'],[0;5],'b')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on


%% busco los estímulos 1 (guía)
  
Swin=find(trial_time_struct.strobe>0 & trial_time_struct.win == 2); %lose
trial_time3=trial_time_struct.times(Swin);
trial_time3(4:42)=trial_time3(4:42)*1000;
trial_time3=trial_time3-trial_time3(1);
trial_time3=trial_time3/1000;
trial_time3=trial_time3+trial_time(8);


%%

for i=1:max(size(trial_time3))

    j=1;
    while(j<max(size(EEG.event)))
        
        marca=EEG.event(j).latency/EEG.srate-EEG.event(1).latency/EEG.srate;
        
        diff=abs(marca-trial_time3(i))
        
        if(diff<0.5)
           
            EEG = pop_editeventvals(EEG,'changefield',{j 'type' 'win'});
            j
         j=1000;   
        else
            
            j=j+1;
            
        end
        
    end
    
end

%%

micromed_win=make_photodiodevector_marktype2(EEG,'win');
micromed_lose=make_photodiodevector_marktype2(EEG,'lose');
%%

micromed_win=micromed_win-micromed_win(1)+trial_time3(1);
micromed_lose=micromed_lose-micromed_lose(1)+trial_time2(1);

plot([trial_time2(:)';trial_time2(:)'],[0;10],'b')
hold on
plot([trial_time3(:)';trial_time3(:)'],[0;10],'b')
hold on
plot([micromed_win;micromed_win],[-10;0],'g')
hold on
plot([micromed_lose;micromed_lose],[-10;0],'r')
hold on
%%

for j=1:max(size(EEG.event))
        
        
        if strcmp(EEG.event(j).type,'win') 
           
            EEG = pop_editeventvals(EEG,'changefield',{j-1 'type' 'S2W'});
            EEG = pop_editeventvals(EEG,'changefield',{j-2 'type' 'S1W'});
               
        else 
            
            if strcmp(EEG.event(j).type,'lose')
            
                EEG = pop_editeventvals(EEG,'changefield',{j-1 'type' 'S2L'});
                EEG = pop_editeventvals(EEG,'changefield',{j-2 'type' 'S1L'});
            
                
            end
            
        end
        
    
end

%%
% 
% micromed_S1=make_photodiodevector_marktype2(EEG,'S1');
% micromed_S2=make_photodiodevector_marktype2(EEG,'S2');
% %%lo
% 
% diferecias_entre_stim=micromed_S1-micromed_S2;

%%

