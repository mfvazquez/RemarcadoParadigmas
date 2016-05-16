% EEGLAB history file generated on the 23-Feb-2015
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
[EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'time',[100 133] );
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
