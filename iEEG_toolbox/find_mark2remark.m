function ev2mark=find_mark2remark(micromed_time,trial_time)

%                                                                          %
% ev2mark=find_mark2remark(micromed_time,trial_time)
%

ev2erase=[];
ev2mark=[];
i_micro=1;
i_trial=1;
tam(1)=max(size(micromed_time));
tam(2)=max(size(trial_time));
long=min(tam);

while i_trial<tam(2) & i_micro<tam(1) 

       
    diff=micromed_time(i_micro)-trial_time(i_trial);
    if abs(diff)<0.1
         ev2mark=[ev2mark  i_micro];
        i_micro=i_micro+1;
        i_trial=i_trial+1;
       
        
    else
        
        ev2erase=[ev2erase i_micro];
        i_micro=i_micro+1;
        
    end
    
    
end
