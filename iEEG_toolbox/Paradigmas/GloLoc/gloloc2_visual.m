clear all
close all
clc

eeglab

% EEGLAB history file generated on the 28-May-2013
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_biosig('C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\GloLoc\GloLoc_3_Paciente2_Visual_Bloque1.edf');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = pop_chanevent(EEG, 64,'oper','X>1000','edge','leading','edgelen',0,'delchan','off','nbtype',1);
EEG = eeg_checkset( EEG );

eeglab redraw;

%%

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(2);

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

 EEG = pop_editeventvals(EEG,'delete',1636);
 EEG = pop_editeventvals(EEG,'delete',1635);
 EEG = pop_editeventvals(EEG,'delete',1634);
 EEG = pop_editeventvals(EEG,'delete',1633);
 EEG = pop_editeventvals(EEG,'delete',1632);
 EEG = pop_editeventvals(EEG,'delete',1631);
 EEG = pop_editeventvals(EEG,'delete',1630);
 
 
 EEG = pop_editeventvals(EEG,'delete',1314);
 EEG = pop_editeventvals(EEG,'delete',1313);
 EEG = pop_editeventvals(EEG,'delete',1312);
 EEG = pop_editeventvals(EEG,'delete',1311);
 EEG = pop_editeventvals(EEG,'delete',1310);
 EEG = pop_editeventvals(EEG,'delete',1309);
 EEG = pop_editeventvals(EEG,'delete',1308);
 
 
 EEG = pop_editeventvals(EEG,'delete',984);
 EEG = pop_editeventvals(EEG,'delete',983);
 EEG = pop_editeventvals(EEG,'delete',982);
 EEG = pop_editeventvals(EEG,'delete',981);
 EEG = pop_editeventvals(EEG,'delete',980);
 EEG = pop_editeventvals(EEG,'delete',979);
 EEG = pop_editeventvals(EEG,'delete',978);
 
 
 EEG = pop_editeventvals(EEG,'delete',691);
 EEG = pop_editeventvals(EEG,'delete',690);
 EEG = pop_editeventvals(EEG,'delete',689);
 EEG = pop_editeventvals(EEG,'delete',688);
 EEG = pop_editeventvals(EEG,'delete',687);
 EEG = pop_editeventvals(EEG,'delete',686);
 EEG = pop_editeventvals(EEG,'delete',685);

 
 
 EEG = pop_editeventvals(EEG,'delete',334);
 EEG = pop_editeventvals(EEG,'delete',333);
 EEG = pop_editeventvals(EEG,'delete',332);
 EEG = pop_editeventvals(EEG,'delete',331);
 EEG = pop_editeventvals(EEG,'delete',330);
 EEG = pop_editeventvals(EEG,'delete',329);
 EEG = pop_editeventvals(EEG,'delete',328);

 EEG = pop_editeventvals(EEG,'delete',677);
 EEG = pop_editeventvals(EEG,'delete',676);
 EEG = pop_editeventvals(EEG,'delete',675);
 EEG = pop_editeventvals(EEG,'delete',674);
 EEG = pop_editeventvals(EEG,'delete',673);
 EEG = pop_editeventvals(EEG,'delete',672);
 EEG = pop_editeventvals(EEG,'delete',671);
 
 EEG = pop_editeventvals(EEG,'delete',670);
 EEG = pop_editeventvals(EEG,'delete',669);
 EEG = pop_editeventvals(EEG,'delete',668);
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

micromed_time=micromed_time+trial_time(4);



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


%% Bloque 1


anss=EEG.event(1).latency/512;
EEG = pop_editeventvals(EEG,'insert',{88 [] [] []},'changefield',{88 'type' 2},'changefield',{88 'latency' ''},'changefield',{88 'latency' (trial_time(92,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{82 [] [] []},'changefield',{82 'type' 2},'changefield',{82 'latency' ''},'changefield',{82 'latency' (trial_time(85,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{94 [] [] []},'changefield',{94 'type' 2},'changefield',{94 'latency' ''},'changefield',{94 'latency' (trial_time(97,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{138 [] [] []},'changefield',{138 'type' 2},'changefield',{138 'latency' ''},'changefield',{138 'latency' (trial_time(141,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{142 [] [] []},'changefield',{142 'type' 2},'changefield',{142 'latency' ''},'changefield',{142 'latency' (trial_time(146,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{146 [] [] []},'changefield',{146 'type' 2},'changefield',{146 'latency' ''},'changefield',{146 'latency' (trial_time(151,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{186 [] [] []},'changefield',{186 'type' 2},'changefield',{186 'latency' ''},'changefield',{186 'latency' (trial_time(190,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{212 [] [] []},'changefield',{212 'type' 2},'changefield',{212 'latency' ''},'changefield',{212 'latency' (trial_time(217,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{216 [] [] []},'changefield',{216 'type' 2},'changefield',{216 'latency' ''},'changefield',{216 'latency' (trial_time(222,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{252 [] [] []},'changefield',{252 'type' 2},'changefield',{252 'latency' ''},'changefield',{252 'latency' (trial_time(256,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{263 [] [] []},'changefield',{263 'type' 2},'changefield',{263 'latency' ''},'changefield',{263 'latency' (trial_time(268,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{282 [] [] []},'changefield',{282 'type' 2},'changefield',{282 'latency' ''},'changefield',{282 'latency' (trial_time(288,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{153 [] [] []},'changefield',{153 'type' 2},'changefield',{153 'latency' ''},'changefield',{153 'latency' (trial_time(156,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{302 [] [] []},'changefield',{302 'type' 2},'changefield',{302 'latency' ''},'changefield',{302 'latency' (trial_time(305,1)+anss-trial_time(4))});
eeglab redraw


%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);

%%

micromed_time=micromed_time+trial_time(4);


%% Bloque 2

EEG = pop_editeventvals(EEG,'insert',{348 [] [] []},'changefield',{348 'type' 2},'changefield',{348 'latency' ''},'changefield',{348 'latency' (trial_time(355,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{367 [] [] []},'changefield',{367 'type' 2},'changefield',{367 'latency' ''},'changefield',{367 'latency' (trial_time(375,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{371 [] [] []},'changefield',{371 'type' 2},'changefield',{371 'latency' ''},'changefield',{371 'latency' (trial_time(380,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{375 [] [] []},'changefield',{375 'type' 2},'changefield',{375 'latency' ''},'changefield',{375 'latency' (trial_time(385,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{379 [] [] []},'changefield',{379 'type' 2},'changefield',{379 'latency' ''},'changefield',{379 'latency' (trial_time(390,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{388 [] [] []},'changefield',{388 'type' 2},'changefield',{388 'latency' ''},'changefield',{388 'latency' (trial_time(400,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{446 [] [] []},'changefield',{446 'type' 2},'changefield',{446 'latency' ''},'changefield',{446 'latency' (trial_time(459,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{514 [] [] []},'changefield',{514 'type' 2},'changefield',{514 'latency' ''},'changefield',{514 'latency' (trial_time(528,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{586 [] [] []},'changefield',{586 'type' 2},'changefield',{586 'latency' ''},'changefield',{586 'latency' (trial_time(601,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{634 [] [] []},'changefield',{634 'type' 2},'changefield',{634 'latency' ''},'changefield',{634 'latency' (trial_time(650,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{645 [] [] []},'changefield',{645 'type' 2},'changefield',{645 'latency' ''},'changefield',{645 'latency' (trial_time(662,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{654 [] [] []},'changefield',{654 'type' 2},'changefield',{654 'latency' ''},'changefield',{654 'latency' (trial_time(672,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{675 [] [] []},'changefield',{675 'type' 2},'changefield',{675 'latency' ''},'changefield',{675 'latency' (trial_time(693,1)+anss-trial_time(4))});


%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);

%%

micromed_time=micromed_time+trial_time(4);


%% Bloque 3

EEG = pop_editeventvals(EEG,'insert',{715 [] [] []},'changefield',{715 'type' 2},'changefield',{715 'latency' ''},'changefield',{715 'latency' (trial_time(727,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{737 [] [] []},'changefield',{737 'type' 2},'changefield',{737 'latency' ''},'changefield',{737 'latency' (trial_time(749,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{758 [] [] []},'changefield',{758 'type' 2},'changefield',{758 'latency' ''},'changefield',{758 'latency' (trial_time(771,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{762 [] [] []},'changefield',{762 'type' 2},'changefield',{762 'latency' ''},'changefield',{762 'latency' (trial_time(776,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{771 [] [] []},'changefield',{771 'type' 2},'changefield',{771 'latency' ''},'changefield',{771 'latency' (trial_time(786,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{841 [] [] []},'changefield',{841 'type' 2},'changefield',{841 'latency' ''},'changefield',{841 'latency' (trial_time(857,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{845 [] [] []},'changefield',{845 'type' 2},'changefield',{845 'latency' ''},'changefield',{845 'latency' (trial_time(862,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{898 [] [] []},'changefield',{898 'type' 2},'changefield',{898 'latency' ''},'changefield',{898 'latency' (trial_time(916,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{914 [] [] []},'changefield',{914 'type' 2},'changefield',{914 'latency' ''},'changefield',{914 'latency' (trial_time(933,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{945 [] [] []},'changefield',{945 'type' 2},'changefield',{945 'latency' ''},'changefield',{945 'latency' (trial_time(965,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{986 [] [] []},'changefield',{986 'type' 2},'changefield',{986 'latency' ''},'changefield',{986 'latency' (trial_time(997,1)+anss-trial_time(4))});

eeglab redraw;


%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);


%%

micromed_time=micromed_time+trial_time(4);


%% Bloque 4

EEG = pop_editeventvals(EEG,'insert',{1059 [] [] []},'changefield',{1059 'type' 2},'changefield',{1059 'latency' ''},'changefield',{1059 'latency' (trial_time(1063,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1079 [] [] []},'changefield',{1079 'type' 2},'changefield',{1079 'latency' ''},'changefield',{1079 'latency' (trial_time(1083,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1089 [] [] []},'changefield',{1089 'type' 2},'changefield',{1089 'latency' ''},'changefield',{1089 'latency' (trial_time(1095,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1152 [] [] []},'changefield',{1152 'type' 2},'changefield',{1152 'latency' ''},'changefield',{1152 'latency' (trial_time(1159,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1183 [] [] []},'changefield',{1183 'type' 2},'changefield',{1183 'latency' ''},'changefield',{1183 'latency' (trial_time(1191,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1212 [] [] []},'changefield',{1212 'type' 2},'changefield',{1212 'latency' ''},'changefield',{1212 'latency' (trial_time(1221,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1228 [] [] []},'changefield',{1228 'type' 2},'changefield',{1228 'latency' ''},'changefield',{1228 'latency' (trial_time(1238,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1239 [] [] []},'changefield',{1239 'type' 2},'changefield',{1239 'latency' ''},'changefield',{1239 'latency' (trial_time(1250,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1289 [] [] []},'changefield',{1289 'type' 2},'changefield',{1289 'latency' ''},'changefield',{1289 'latency' (trial_time(1301,1)+anss-trial_time(4))});

eeglab redraw;

%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);


%%

micromed_time=micromed_time+trial_time(4);

%% Borro mas marcas repetidas

 EEG = pop_editeventvals(EEG,'delete',996);
 EEG = pop_editeventvals(EEG,'delete',963);
 EEG = pop_editeventvals(EEG,'delete',930);
 EEG = pop_editeventvals(EEG,'delete',912);
 EEG = pop_editeventvals(EEG,'delete',857);
 EEG = pop_editeventvals(EEG,'delete',851);
 EEG = pop_editeventvals(EEG,'delete',779);
 EEG = pop_editeventvals(EEG,'delete',768);
 EEG = pop_editeventvals(EEG,'delete',762);
 EEG = pop_editeventvals(EEG,'delete',739);
 EEG = pop_editeventvals(EEG,'delete',716);
eeglab redraw

%% Bloque 5

EEG = pop_editeventvals(EEG,'insert',{1360 [] [] []},'changefield',{1360 'type' 2},'changefield',{1360 'latency' ''},'changefield',{1360 'latency' (trial_time(1369,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1365 [] [] []},'changefield',{1365 'type' 2},'changefield',{1365 'latency' ''},'changefield',{1365 'latency' (trial_time(1374,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1379 [] [] []},'changefield',{1379 'type' 2},'changefield',{1379 'latency' ''},'changefield',{1379 'latency' (trial_time(1389,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1383 [] [] []},'changefield',{1383 'type' 2},'changefield',{1383 'latency' ''},'changefield',{1383 'latency' (trial_time(1394,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1388 [] [] []},'changefield',{1388 'type' 2},'changefield',{1388 'latency' ''},'changefield',{1388 'latency' (trial_time(1404,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1441 [] [] []},'changefield',{1441 'type' 2},'changefield',{1441 'latency' ''},'changefield',{1441 'latency' (trial_time(1454,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1444 [] [] []},'changefield',{1444 'type' 2},'changefield',{1444 'latency' ''},'changefield',{1444 'latency' (trial_time(1459,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1461 [] [] []},'changefield',{1461 'type' 2},'changefield',{1461 'latency' ''},'changefield',{1461 'latency' (trial_time(1476,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1477 [] [] []},'changefield',{1477 'type' 2},'changefield',{1477 'latency' ''},'changefield',{1477 'latency' (trial_time(1493,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1488 [] [] []},'changefield',{1488 'type' 2},'changefield',{1488 'latency' ''},'changefield',{1488 'latency' (trial_time(1505,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1521 [] [] []},'changefield',{1521 'type' 2},'changefield',{1521 'latency' ''},'changefield',{1521 'latency' (trial_time(1539,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1542 [] [] []},'changefield',{1542 'type' 2},'changefield',{1542 'latency' ''},'changefield',{1542 'latency' (trial_time(1561,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1583 [] [] []},'changefield',{1583 'type' 2},'changefield',{1583 'latency' ''},'changefield',{1583 'latency' (trial_time(1603,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1614 [] [] []},'changefield',{1614 'type' 2},'changefield',{1614 'latency' ''},'changefield',{1614 'latency' (trial_time(1635,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1618 [] [] []},'changefield',{1618 'type' 2},'changefield',{1618 'latency' ''},'changefield',{1618 'latency' (trial_time(1640,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1666 [] [] []},'changefield',{1666 'type' 2},'changefield',{1666 'latency' ''},'changefield',{1666 'latency' (trial_time(1693,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1682 [] [] []},'changefield',{1682 'type' 2},'changefield',{1682 'latency' ''},'changefield',{1682 'latency' (trial_time(1710,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1686 [] [] []},'changefield',{1686 'type' 2},'changefield',{1686 'latency' ''},'changefield',{1686 'latency' (trial_time(1715,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1697 [] [] []},'changefield',{1697 'type' 2},'changefield',{1697 'latency' ''},'changefield',{1697 'latency' (trial_time(1727,1)+anss-trial_time(4))});
EEG = pop_editeventvals(EEG,'insert',{1706 [] [] []},'changefield',{1706 'type' 2},'changefield',{1706 'latency' ''},'changefield',{1706 'latency' (trial_time(1737,1)+anss-trial_time(4))});




eeglab redraw;


%%

error=find(t_diff_tt<0.09)

%%

clear micromed_time;

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end

micromed_time=micromed_time/512;
micromed_time=micromed_time-micromed_time(1);


%%

micromed_time=micromed_time+trial_time(4);



%%

plot([trial_time(:,1)';trial_time(:,1)'],[-150;150],'b')
hold on
plot([micromed_time;micromed_time],[-100;100],'r')


