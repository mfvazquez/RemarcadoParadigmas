clear all
close all
clc


eeglab
EEG = pop_loadset('filename','Paciente10_intero_con_eeg_full.set','filepath','D:\\_INECO\\Pacientes\\Paciente10_Repossini\\ConMarcas\\');
EEG = eeg_checkset( EEG );


bloque(1).ini=6;
bloque(1).fin=136;
bloque(1).name='bloque1';

bloque(2).ini=137
bloque(2).fin=255
bloque(2).name='bloque2';

bloque(3).ini=256;
bloque(3).fin=364;
bloque(3).name='bloque3';

bloque(4).ini=366;
bloque(4).fin=469;
bloque(4).name='bloque4';

bloque(5).ini=470;
bloque(5).fin=526;
bloque(5).name='bloque5';

bloque(6).ini=527;
bloque(6).fin=643;
bloque(6).name='bloque6';

bloque(7).ini=644;
bloque(7).fin=781;
bloque(7).name='bloque7';

eeglab redrae 


for i=1:7

    EEG = pop_select( EEG,'time',[EEG.event(bloque(i).ini).latency/EEG.srate EEG.event(bloque(i).fin).latency/EEG.srate]);
    
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

    
    % %% Elimino las marcas que est�n de m�s
    
    p=1;
    
    while p<size(EEG.event,2)
        
        if strcmp(EEG.event(p).type,'chan64') == 1
            
            EEG=delete_mark(EEG,p);
            
        else
            
            p=p+1;
            
        end
        
    end
    
    eeglab redraw
    
    
    EEG = pop_saveset( EEG, 'filename',['Paciente10_intero_con_eeg_' bloque(i).name '.set'],'filepath','D:\\_INECO\\Pacientes\\Paciente10_Repossini\\ConMarcas\\');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
    eeglab redraw;

end


%%

