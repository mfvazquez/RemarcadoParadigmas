function [trial_time]=make_logmarkvector(path,name, sheet, range)

%
% [trial_time]=make_logtimevector(path name, sheet, range)
% Make_logtimevector gets log mark time vector using the information
% that find in the log file. Path, xls data sheet name, range  
% of marks have to be specified. 
% ATENTION: this function should be used with log files created using
% Python
% For Matlab log file look for make_logtimevector
%


filexls= [ path name]

trial_time=xlsread(filexls,sheet,range);
