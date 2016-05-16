function [EEG]=import_set(filename, path,ev_channel)

%                                                                         %  
%                                                                         
% [EEG]=import_set(path,ev_channel)
%                                           
% This function import set file and gives back the EEG structure
% It also extract photodiode events in channel ev_channel using a voltage
% offset of 1000. It doesn t erase channel event or apply any filter.
% Outputs: eeglab EEG structure
%                                                                          
% Fabricio Baglivo 2015 - baglivofabricio@gmail.com

    EEG = pop_loadset('filename',[filename '.set'],'filepath',path);
    EEG = eeg_checkset( EEG );
    EEG = pop_chanevent(EEG, ev_channel,'oper','X>1000','edge','leading','edgelen',0,'delchan','off','nbtype',1);
    EEG = eeg_checkset( EEG );


    eeglab redraw
