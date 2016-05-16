function [trial_time]=merge_trialtime(trial_time2)

%                                                                         %
% [trial_time]=merge_trialtime(trial_time2)
%
% This function makes a merge of a N x K - dimension vector to a 3N dimension
% vector

lenght=max(size(trial_time2));
dim=min(size(trial_time2));
trial_time=[];

for i=1:lenght

    for j=1:dim
        
        trial_time=[trial_time trial_time2(i,j)];
        
    end
    
end
