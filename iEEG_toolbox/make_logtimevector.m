function [trial_time]=make_logtimevector(path,name, sheet, range)

%
% [trial_time]=make_logtimevector(path, name, sheet, range)
% Make_logtimevector gets log mark time vector using the information
% that find in the log file. Path, xls data sheet name, range  
% of marks have to be specified. 
% ATENTION: this function should be used with log files created using
% MATLAB
% For python log file look for make_logtimevector2
%


filexls= [ path name]

trial_time=xlsread(filexls,sheet,range);

for i=1:max(size(trial_time))
   
    if trial_time(i,1)>100000
        
        trial_time(i,1)=trial_time(i,1)/1000;
        
    end
   
    
end
