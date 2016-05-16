
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

path=['C:\Users\Fabri\Documents\INECO\Pacientes\Paciente7_JuanCasco\Logs\Intero\Casco\Casco\Datos\'];

load([path 'casco_bloque1.mat'])


%%

path=['C:\Users\Fabri\Documents\INECO\Pacientes\' paciente '\Masters\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path archivo '.edf'],channel);

eeglab redraw


%% Load iEEG Signal

for i=1:max(size(EEG.event))
         
    micromed_time(i)=EEG.event(i).latency;
       
end
 
micro1=micromed_time(1);

micromed_time=micromed_time/EEG.srate;
micromed_time=micromed_time-micromed_time(1);

% INICIO DEL BLOQUE 1. Marca 5. 27,25s
% INICIO DEL BLOQUE 2. Marca 225. 187,8s
% INICIO DEL BLOQUE 3. Marca 438. 461s
% INICIO DEL BLOQUE 4. Marca . 
%%

plot([tiempo_actual+micromed_time(5);tiempo_actual+micromed_time(5)],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on   
plot([tiempo_actual_2+micromed_time(225);tiempo_actual_2+micromed_time(225)],[0;150],'g')
hold on
plot([tiempo_actual_3+micromed_time(438);tiempo_actual_3+micromed_time(438)],[0;150],'g')
hold on