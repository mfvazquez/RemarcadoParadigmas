clear all
close all
clc

addpath(genpath('D:\LUCILA\LUK_WORK 2014\VWM\VWM PARADIGM ANALISIS CONECTIVIDAD_agosto2014\Paciente Dellmans\VWM_ANALISIS MI\Analisis_canales limpios\analisis conectividad MI condiciones colapsadas_ limpias'))
addpath(genpath('C:\Users\INECO\Documents\MATLAB\eeglab'))

eeglab

fileName = 'WholeBinding.set';
filePath = 'D:\LUCILA\LUK_WORK 2014\VWM\VWM PARADIGM ANALISIS CONECTIVIDAD_agosto2014\Paciente Dellmans\VWM_ANALISIS MI\Analisis_canales limpios\analisis conectividad MI condiciones colapsadas_ limpias';

EEG = pop_loadset('filename','WholeBinding.set','filepath','D:\LUCILA\LUK_WORK 2014\VWM\VWM PARADIGM ANALISIS CONECTIVIDAD_agosto2014\Paciente Dellmans\VWM_ANALISIS MI\Analisis_canales limpios\analisis conectividad MI condiciones colapsadas_ limpias\\');
EEG = eeg_checkset( EEG );

%cargas tu señal
%signalCondition1 = load('VWM_S2left_single.mat'); 
%signalCondition1= load('BLdata');
%EEG.data = signalCondition1;

load('VWM_S1left_single.mat'); 
EEG.data = BLdata;

EEG.srate = 512; %cambiar 

typeproc = 1; %deprecated - useless NO TOCAR
tlimits = [-200  800]; %time limits in ms MODIFICAR
cycles = 0; %? NO TOCAR
frequencyRange = [1 150]; %MODIFICAR
alpha = 0.05; 
%alpha = 0;
weightedSignificance = 0;
surroundingsWeight = 0.3;

%CARGAR TU ARCHIVO CON ROIS (ver y correr antes createEmpathyForPain_P8_Electrode)
load 'VWM_DELLMANS_Electrode.mat'

titleName = 'VWM_Dellmans_single_BL_left';

[erpsMapsByTrialByROIsINT,erpsByROIsINT, meanERPSMap, R, Pboot, Rboot, ~, freqs, timesout, mbase, maskerspINT, maskitc, g,PboottrialsINT] = PlotERPSByROI(VWM_DELLMANS_Electrode,EEG,tlimits,frequencyRange,alpha,titleName,weightedSignificance,surroundingsWeight);

%lo mismo para condicion2
%cargo la senal
load('VWM_S1left_single.mat'); 
EEG.data = SOLdata;

EEG.srate = 512; %cambiar

titleName = 'VWM_Dellmans_single_SOL_left';
[erpsMapsByTrialByROIsACC,erpsByROIsACC, meanERPSMap, R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskerspACC, maskitc, g,PboottrialsACC] = PlotERPSByROI(VWM_DELLMANS_Electrode,EEG,tlimits,frequencyRange,alpha,titleName,weightedSignificance,surroundingsWeight);

display('DONE......')
%%

erpsDIFF = erpsByROIsINT - erpsByROIsACC;
%maskerspDIFF = maskerspINT - maskerspACC;
maskerspDIFF = [];

titleName = 'WHOLE BINDING-WHOLE SHAPE ONLY LEFT';

for i = 1 : size(VWM_DELLMANS_Electrode,2)
    plotTitleName = [titleName ' - ' VWM_DELLMANS_Electrode(i).name];
    channels = VWM_DELLMANS_Electrode(i).channels;
        
    erpsDiff = squeeze(erpsDIFF(i,:,:));
    baselntmp = 1:40; %todo ver como calcular esto en codigo, se su valor por imprimirlo
    formula = 'mean(arg1,3);';            
    [ PbootDIFF PboottrialstmpDIFF PboottrialsDIFF] = bootstat(erpsDiff, formula, 'boottype', 'shuffle', ...
        'label', 'ERSP', 'bootside', 'both', 'naccu', g.naccu, ...
        'basevect', baselntmp, 'alpha', g.alpha, 'dimaccu', 2 );
     exactp_ersp = mycompute_pvals(erpsDiff, PboottrialsDIFF);
      maskersp = exactp_ersp <= g.alpha;

      plottimef(plotTitleName,erpsDiff, R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskersp, maskitc, g);
end
display ('DONE....')
