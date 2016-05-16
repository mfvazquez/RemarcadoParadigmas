
close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No' | automatic=='no' | automatic=='NO'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    
    paciente='Paciente9_AlfredoFarinelli'
    paradigma='Sergio_Tmaze'
    archivo='20141104_Farinelli_TMaze'
end

     
path=['D:\_INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=64;

EEG=import_edf([path archivo '.edf'],channel);

eeglab redraw


%%



path=['D:\_INECO\Pacientes\' paciente '\Logs\tmaze\'];
sheet='20141104_tmaze_1'
name='20141104_tmaze_1.xls'
range='F2:F25220'

[trial_time_struct.strobe]=read_xls(path,name, sheet, range);


range='G2:G25220'
[trial_time_struct.win]=read_xls(path,name, sheet, range);

range='A2:A25220'
[trial_time_struct.times]=read_xls(path,name, sheet, range);

%%

[micromed_time]=make_photodiodevector(EEG);
% delta=0.2;
% ev2delete=find_repeatedmark(micromed_time, delta);
% micromed_time([1 ev2delete])=[];
micromed_time=micromed_time-micromed_time(1);

% EEG=delete_mark(EEG,[1 ev2delete]);
%%

clear micromed_time;
[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);

%%

strobe=find(trial_time_struct.strobe>0);
trial_time=trial_time_struct.times(strobe);
trial_strobe=trial_time_struct.strobe(strobe);
trial_win=trial_time_struct.win(strobe);
trial_time(1:2)=trial_time(1:2)/10;
trial_time(1:7)=[];
trial_time=trial_time-trial_time(1);


% micromed_time=micromed_time+trial_time(8)

%% busco los estímulos 1 (guía)



%%

plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
% plot([trial_time2(:)';trial_time2(:)'],[0;5],'b')
% hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on

%%
tipo1=find(trial_strobe==2);
tipo2=find(trial_strobe==3);
tipo3=find(trial_strobe==4);
tipo4=find(trial_strobe==5);

trial_strobe(tipo1+1)=trial_strobe(tipo1); 
trial_strobe(tipo1+2)=trial_strobe(tipo1); 
trial_strobe(tipo1+3)=trial_strobe(tipo1); 


trial_strobe(tipo2+1)=trial_strobe(tipo2); 
trial_strobe(tipo2+2)=trial_strobe(tipo2); 
trial_strobe(tipo2+3)=trial_strobe(tipo2); 


trial_strobe(tipo3+1)=trial_strobe(tipo3); 
trial_strobe(tipo3+2)=trial_strobe(tipo3); 
trial_strobe(tipo3+3)=trial_strobe(tipo3); 


trial_strobe(tipo4+1)=trial_strobe(tipo4); 
trial_strobe(tipo4+2)=trial_strobe(tipo4); 
trial_strobe(tipo4+3)=trial_strobe(tipo4); 


lose=find(trial_win==1);
win=find(trial_win==2);

for i=1:5

    trial_strobe(lose-i+1)=trial_strobe(lose-i+1)+10;
    trial_strobe(win-i+1)=trial_strobe(win-i+1)+20;
end

trial_strobe(lose-1)=trial_strobe(lose-1)+300; %S2
trial_strobe(win-1)=trial_strobe(win-1)+300;


trial_strobe(lose-2)=trial_strobe(lose-2)+200; %S1
trial_strobe(win-2)=trial_strobe(win-2)+200;


trial_strobe(lose-3)=trial_strobe(lose-3)+100; %I
trial_strobe(win-3)=trial_strobe(win-3)+100;
%%


for i=1:max(size(trial_time))
   

        rest=micromed_time-trial_time(i); 
        mmark=find(abs(rest)<0.05)
        
        if ~isempty(mmark)
    
            
            if trial_strobe(i)==21 && trial_win(i)==3

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'Restw'});

            elseif  trial_strobe(i)==11 && trial_win(i)==3

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' 'Restl'});
    
            elseif  trial_win(i)<3 

                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' trial_strobe(i)});

            end
            
            
        end

end

%%
    

% %% Elimino las marcas que están de más

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan64') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end

