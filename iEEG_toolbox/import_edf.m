function [EEG]=import_edf(path,ev_channel)

%                                                                         %  
%                                                                         
% [EEG]=import_edf(path,ev_channel)
%                                           
% This function import the edf database and gives back the EEG structure
% It also extract photodiode events in channel ev_channel using a voltage
% offset of 1000. It doesn t erase channel event or apply any filter.
% Inputs: path=complete edf file path. Example 'C:\database.edf'
%         ev_channel= events channel number
% Outputs: eeglab EEG structure
%                                                                          
% Fabricio Baglivo 2013 - baglivofabricio@gmail.com

 
    EEG = pop_biosig(path);
    EEG = eeg_checkset( EEG );
    EEG = pop_chanevent(EEG, ev_channel,'oper','X>700','edge','leading','edgelen',0,'delchan','off','nbtype',1);
    EEG = eeg_checkset( EEG );


    eeglab redraw
