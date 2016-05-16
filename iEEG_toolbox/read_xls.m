function [trial_time]=read_xls(path,name, sheet, range)

%
% [trial_time]=read_xls(path name, sheet, range)
% 


filexls= [ path name]

trial_time=xlsread(filexls,sheet,range);

for i=1:max(size(trial_time))
   
    if trial_time(i,1)>100000
        
        trial_time(i,1)=trial_time(i,1)/1000;
        
    end
   
    
end
