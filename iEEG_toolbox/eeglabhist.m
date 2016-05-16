% EEGLAB history file generated on the 11-Dec-2014
% ------------------------------------------------

EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_loadset('filename','Paciente9_TMaze.set','filepath','D:\\_INECO\\Pacientes\\Paciente9_AlfredoFarinelli\\ConMarcas\\TMAZE\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG.setname='xx';
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '213'  }, [0.1         1.5], 'newname', 'xx epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [99.6094            0]);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
