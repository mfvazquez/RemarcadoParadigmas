
clear all
close all
clc

restoredefaultpath
addpath('D:\FLOR\iEEG_toolbox\')
addpath('C:\Toolbox\eeglab11_0_4_3b\')


%%
eeglab

path_file=['D:\FLOR\Pacientes\Paciente12_LB\Masters\5_chords\'];
   
path=[path_file 'five_chords_1y2.edf' ];
channel=8;  

EEG=import_edf(path,channel);

eeglab redraw
  
% ev2delete=[1:6];
%  
% EEG=delete_mark(EEG,ev2delete)

eeglab redraw

%% Leo los tiempos de las marcas del fotodiodo

micromed_time=make_photodiodevector(EEG);
% 
% micromed_time(1:164)=[];

micromed_time=micromed_time-micromed_time(1,1);
%micromed_time=micromed_time(1,26:end);
% micromed_time=micromed_time(1,5:end);

%% Primera prueba

path=['D:\FLOR\Pacientes\Paciente12_LB\Logs\5_chords\'];
time_file=[path 'BarreiroLoana_1_log.mat'];
load (time_file);



stimuli_time1=[1974837.40865274;1974849.15012081;1974857.76881610;1974866.50160363;1974875.22039214;1974883.75204216;1974893.93779897;1974903.59019137;1974912.30895379;1974920.41033035;1974928.57472386;1974937.14341850;1974945.99527764;1974955.31043383;1974964.29639761;1974972.97914473;1974981.18257778;1974989.38401847;1974997.20215442;1975005.21748637;1975013.13372875;1975021.40120208;1975029.50252432;1975036.43714939;1975044.27135239;1975052.33969937;1975061.15653959;1975068.95770746;1975077.39231713;1975085.54169514;1975094.47659304;1975103.69271740;1975114.62796211;1975123.34973166;1975130.23325408;1975138.91802861;];
response_time1=[1974846.12915991;1974854.74713550;1974863.47377836;1974872.18973380;1974880.73200282;1974890.90753148;1974900.57239753;1974909.28989758;1974917.38962176;1974925.54800231;1974934.12393808;1974942.96782955;1974952.29352563;1974961.27983878;1974969.96240416;1974978.16028224;1974986.35825012;1974994.17653617;1975002.19219355;1975010.10851804;1975018.37423507;1975026.48311061;1975033.41293549;1975041.24955890;1975049.31595031;1975058.13828989;1975065.93236588;1975074.36875623;1975082.51961812;1975091.45962710;1975100.66243452;1975111.61329513;1975120.33098890;1975127.20309906;1975135.89246467;1975144.24936732;]; %Levanto el tiempo de las respuestas

diff_time1=response_time1-stimuli_time1;

for n=1:6
    stimuli_time1(n)=micromed_time(2*n-1);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=7:17
    
    stimuli_time1(n)=micromed_time(2*n);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=18:32
    stimuli_time1(n)=micromed_time(2*n+1);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=33:36
    stimuli_time1(n)=micromed_time(2*n+2);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end



%% Segunda prueba

path=['D:\FLOR\Pacientes\Paciente12_LB\Logs\5_chords\'];
time_file2=[path 'BarreiroLoana_2_log.mat'];
load (time_file2);



stimuli_time2=[1982114.42758964;1982122.86988903;1982130.67183519;1982138.87030298;1982147.88763198;1982156.10709444;1982164.24047425;1982172.38939084;1982180.87794907;1982188.99373388;1982198.14379439;1982206.27920075;1982214.39369668;1982222.84829866;1982230.79566593;1982239.03412431;1982247.01440741;1982255.84894610;1982262.97063782;1982271.86972952;1982280.00512220;1982288.43670166;1982296.20474759;1982304.43720328;1982312.97507879;1982320.77424961;1982328.86061023;1982336.97765785;1982345.30916291;1982353.39601745;1982361.51096709;1982369.79444931;1982377.91426116;1982386.06667793;1982394.69766726;1982403.80069490;];
response_time2=[1982119.83696038;1982127.64197524;1982135.84254014;1982144.87247065;1982153.07934016;1982161.21244457;1982169.36916462;1982177.84726592;1982185.97277042;1982195.11759242;1982203.25124548;1982211.36749000;1982219.81927174;1982227.77836601;1982236.00676046;1982243.98986594;1982252.83351322;1982259.93869315;1982268.84064615;1982276.97231585;1982285.41010114;1982293.17919006;1982301.40900169;1982309.94286258;1982317.74459835;1982325.83156364;1982333.95127242;1982342.29189549;1982350.36479634;1982358.48967906;1982366.76806517;1982374.88829695;1982383.03792170;1982391.68290192;1982400.77246894;1982407.81701854;]; %Levanto el tiempo de las respuestas

diff_time2=response_time2-stimuli_time2;

for n=1:8
    stimuli_time2(n)=micromed_time(77+2*n-1);
    response_time2(n)= stimuli_time2(n)+diff_time2(n);
end

for n=9:24
    
    stimuli_time2(n)=micromed_time(77+2*n);
    response_time2(n)= stimuli_time2(n)+diff_time2(n);
end

for n=25:30
    stimuli_time2(n)=micromed_time(77+2*n+1);
    response_time2(n)= stimuli_time2(n)+diff_time2(n);
end

for n=30:36
    stimuli_time2(n)=micromed_time(77+2*n+2);
    response_time2(n)= stimuli_time2(n)+diff_time2(n);
end
for n=34:36
    stimuli_time2(n)=micromed_time(77+2*n+3);
    response_time2(n)= stimuli_time2(n)+diff_time2(n);
end

%%
stimuli_time=[stimuli_time1' stimuli_time2'];
response_time=[response_time1' response_time2'];
%%

marks_file=[path 'BarreiroLoana_1_log.mat'];

load (marks_file);
stimuli_marks1=log.Stimuli(1,:);
response_marks1=log.Trials(:,3);

marks_file2=[path 'BarreiroLoana_2_log.mat'];

load (marks_file2);
stimuli_marks2=log.Stimuli(1,:);
response_marks2=log.Trials(:,3);

stimuli_marks=[stimuli_marks1 stimuli_marks2];
response_marks=[response_marks1' response_marks2'];
%%

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([stimuli_time;stimuli_time],[0;100],'b')

hold on
plot([response_time;response_time],[0;100],'g')
hold on   
 %%

for i=1:max(size(stimuli_time))
   
        rest=micromed_time-stimuli_time(i); 
        mmark=find(abs(rest)<0.05);
        
        if ~isempty(mmark) & ~isempty(stimuli_marks{i})
    
         
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' stimuli_marks{i}});
         
                        
        end
        
end

for j=1:max(size(response_time))
   
        rest=micromed_time-response_time(j); 
        mmark=find(abs(rest)<0.15);
        
        if ~isempty(mmark) & ~isempty(response_marks(j))
    
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' response_marks(j)});
         
                        
        end
        
end

%%

% %% Elimino las marcas que est�n de m�s

p=1;

while p<size(EEG.event,2)
   
    if strcmp(EEG.event(p).type,'chan8') == 1
        
        EEG=delete_mark(EEG,p);
        
    else
        
        p=p+1;
        
    end
    
end


%%

clear micromed_time
figure
micromed_time=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1,1)+stimuli_time(1,1);

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

plot([stimuli_time;stimuli_time],[0;100],'b')
hold on   
 
plot([response_time;response_time],[0;100],'g')
hold on   