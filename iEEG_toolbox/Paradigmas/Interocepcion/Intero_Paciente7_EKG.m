
close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just

% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente7_JuanCasco'
    paradigma='Intero'
    archivo='intero';
    
end

%% Load log file

path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Logs\' paradigma '\'];

load([path 'INTRA.mat'])

%%

srate=200;
filt_long=200;

band=[1 80];

b = firws(filt_long, band / (srate/2));
ekgfilt= firfiltdcpadded(b, data(:,2), 0);  % Causal Filter
%%

x=0:1:size(ekgfilt,1)-1;
y=0:200/1024:size(ekgfilt,1)-1;
ecgresampl=interp1(x,ekgfilt,y);
ecgsoundresampl=interp1(x,data(:,1),y);

%%
% 
% plot(1:1:max(size(data)),ekgfilt+3,'r')
% hold on
% plot(1:1:max(size(data)),data(:,1))

%% Block Peak detect (busco los inicios de bloques)

blockpeaksindex=find(abs(ecgsoundresampl(1,:))>0.5);
repeat=find_repeatedmark(blockpeaksindex, 2000);
blockpeaksindex(repeat)=[];
blockpeaksmark=zeros(max(size(ecgsoundresampl)),1);
blockpeaksmark(blockpeaksindex)=1;

%%

plot(1:1:max(size(ecgsoundresampl)),ecgsoundresampl+3,'r')
hold on
plot(blockpeaksmark)

%%

trial_marks=find(blockpeaksmark==1);

