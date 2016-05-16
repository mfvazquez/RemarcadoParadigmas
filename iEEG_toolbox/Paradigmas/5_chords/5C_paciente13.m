
clear all
close all
clc

restoredefaultpath
addpath('D:\FLOR\iEEG_toolbox\')
addpath('C:\Toolbox\eeglab11_0_4_3b\')


%%
eeglab

path_file=['D:\FLOR\Pacientes\Paciente13_RM\Masters\5Chords\'];
   
path=[path_file '5ChordsRamiroMillia.edf' ];
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

path=['D:\FLOR\Pacientes\Paciente13_RM\Logs Millia Ramiro\5 chords\'];
time_file=[path 'MiliaRamiro_log.mat'];
load (time_file);

stimuli_time1=[1986426.13260878;1986438.50333298;1986447.05600590;1986455.50159294;1986464.19034745;1986472.42181146;1986480.75632492;1986488.82466249;1986496.92703329;1986505.32554769;1986513.92929975;1986522.06068592;1986530.36418183;1986538.86381064;1986547.59749663;1986556.51440142;1986565.41729650;1986573.63674143;1986582.43656054;1986591.16733520;1986600.06824136;1986608.50382604;1986616.87137634;1986625.12085142;1986633.94268084;1986642.20815797;1986650.59270756;1986659.12637260;1986667.78009451;1986676.22966965;1986684.71137292;1986692.99875943;1986701.24726250;1986710.29725972;1986718.90095961;1986727.96714448;];
response_time1=[1986435.48012188;1986444.02868823;1986452.47813210;1986461.15796446;1986469.39759157;1986477.73014304;1986485.80248498;1986493.89838354;1986502.30042592;1986510.90309094;1986519.03595672;1986527.33358036;1986535.84615450;1986544.57118861;1986553.48972054;1986562.39314589;1986570.61605765;1986579.41003913;1986588.15418418;1986597.03993586;1986605.48621309;1986613.85160769;1986622.09529346;1986630.91311638;1986639.17889371;1986647.56969061;1986656.10863991;1986664.76158481;1986673.20484808;1986681.69100900;1986689.97678890;1986698.22414634;1986707.27749535;1986715.87434070;1986724.94604674;1986732.26054908;];

diff_time1=response_time1-stimuli_time1;

for n=1:8
    stimuli_time1(n)=micromed_time(2*n-1);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=9:21
    
    stimuli_time1(n)=micromed_time(2*n);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=22:27
    stimuli_time1(n)=micromed_time(2*n+1);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end
% 
%     stimuli_time1(28)=micromed_time(2*28+2);
%     response_time1(28)= stimuli_time1(28)+diff_time1(28);

for n=28:32
    stimuli_time1(n)=micromed_time(2*n+2);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=33:33
    stimuli_time1(n)=micromed_time(2*n+3);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end

for n=34:36
    stimuli_time1(n)=micromed_time(2*n+4);
    response_time1(n)= stimuli_time1(n)+diff_time1(n);
end



%% Segunda prueba
% 
path=['D:\FLOR\Pacientes\Paciente13_RM\Logs Millia Ramiro\5 chords\'];
time_file2=[path 'Milia2Ramiro_log.mat'];
load (time_file2);



stimuli_time2=[1986426.13260878;1965828.07635485;1965835.52729458;1965844.29410079;1965853.06086724;1965861.62963245;1965871.84935107;1965881.53572110;1965890.28257264;1965898.41893733;1965906.61738545;1965915.22208172;1965924.10497937;1965933.45615557;1965942.47213453;1965951.18888580;1965959.42639997;1965967.64481473;1965975.49721140;1965983.54353525;1965991.49781565;1965999.79731018;1966007.92873998;1966016.08109431;1966023.94931643;1966032.05067716;1966040.90354808;1966048.73572965;1966057.20329321;1966065.38572986;1966074.35666232;1966083.60677671;1966094.59210246;1966103.35889328;1966111.46022878;1966120.17704334;];
response_time2=[1965825.05226624;1965832.50361522;1965841.26330390;1965850.02956574;1965858.60518164;1965868.81382155;1965878.51220680;1965887.26305715;1965895.39584468;1965903.58799846;1965912.19708268;1965921.07435866;1965930.43310056;1965939.45269730;1965948.16865146;1965956.39995809;1965964.61462764;1965972.46613740;1965980.51510188;1965988.46503282;1965996.76385170;1966004.90608779;1966013.05276487;1966020.92269067;1966029.02245975;1966037.87806453;1966045.70547457;1966054.17527721;1966062.35943125;1966071.33287605;1966080.56885458;1966091.56987748;1966100.32097158;1966108.42670701;1966117.14903889;1966124.33924565;];
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

%
stimuli_time=[stimuli_time1' stimuli_time2'];
response_time=[response_time1' response_time2'];

%%

marks_file=[path 'MiliaRamiro_log.mat'];

load (marks_file);
stimuli_marks1=log.Stimuli(1,:);
response_marks1=log.Trials(:,3);

marks_file2=[path 'Milia2Ramiro_log.mat'];

load (marks_file2);
stimuli_marks2=log.Stimuli(1,:);
response_marks2=log.Trials(:,3);

stimuli_marks=[stimuli_marks1 stimuli_marks2];
response_marks=[response_marks1' response_marks2'];

stimuli_marks=[stimuli_marks1];
response_marks=[response_marks1'];
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
        mmark=find(abs(rest)<0.1);
        
        if ~isempty(mmark) & ~isempty(response_marks(j))
    
                EEG = pop_editeventvals(EEG,'changefield',{mmark 'type' response_marks(j)});
         
                        
        end
        
end

%%

% %% Elimino las marcas que están de más

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