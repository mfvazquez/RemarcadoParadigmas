
close all
clear all

%% Enter Patient info. Ask if we  are using the default patient (just
% in case that we want to work always with the same patient)

automatic= input('Quiere el paciente por deafult? (si/no)','s')

if automatic=='No'

    paciente= input('Ingrese el nombre del paciente:','s')
    paradigma=input('Ingrese el paradigma a trabajar:','s')

else
    
    paciente='Paciente5'
    paradigma='hexagono'
    
end

     
path=['C:\Users\Ineco\Documents\IEEG\Pacientes\' paciente '\' paradigma '\'];

% Open EDF file into EEGLAB 

channel=2;

EEG=import_edf([path paciente '.edf'],channel);

eeglab redraw




%%
path=['C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente5\hexagono\']
sheet='hernandezmauro_hexa'
name='hernandezmauro_hexa.xls'
range='F2:F35484'

[trial_time.strobe]=read_xls(path,name, sheet, range);


%%

range='G2:G35484'
[trial_time.win]=read_xls(path,name, sheet, range);

%%

stem(trial_time.strobe,'r')
hold on
stem(trial_time.win,'b')
ylim([0 5])
axis on

%%

