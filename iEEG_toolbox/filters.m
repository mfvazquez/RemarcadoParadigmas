
close all
clear all

file(1).name='Hexagono.set';
% file(2).name='Paciente2_VWM-WBW_bloque_2_acc1.set';
% file(3).name='VM_Color_Whole_Bloque1_acc1.set';
% file(4).name='VM_Color_Whole_Bloque2_acc1.set';

freq(1).band=[4 8];
freq(1).name='_4to8';
freq(2).band=[8 12];
freq(2).name='_8to12';

path='C:\Users\Fabri\Documents\INECO\Pacientes\Paciente6_LizandroAusello\Remark\Hexagono\'

%%

for i=1:size(freq,2)

    for j=1:size(file,2)

        eeglab
        EEG = pop_loadset('filename',file(j).name,'filepath',path);
        EEG = eeg_checkset( EEG );
        eeglab redraw

        data=EEG.data;
        srate=EEG.srate;
        band=freq(i).band;
        filt_long=512;
        b = firws(filt_long, band / (srate/2));
        band_sig(j).data= firfiltdcpadded(b, data', 0);  % Causal Filter

        EEG.data=band_sig(j).data';
        outf=[freq(i).name file(j).name ];
        path2=[path 'filt\']
        EEG = pop_saveset( EEG, 'filename',outf,'filepath',path2);
        EEG = eeg_checkset( EEG );

        pop_delset(ALLEEG,1);

    end          
    
end