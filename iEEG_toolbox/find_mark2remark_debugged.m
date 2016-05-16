function ev2mark=find_mark2remark_debugged(micromed_time,trial_time)

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
  watchdog=1;

while i_trial<tam(2) 

       
    diff=micromed_time(i_micro)-trial_time(i_trial);
   
    if abs(diff)<0.1
         
        ev2mark=[ev2mark  i_micro];
        i_micro=i_micro+1;
        i_trial=i_trial+1;
       
        
    else
        
       i_micro=i_micro+1; 
       watchdog=watchdog+1;
       
       
        
    end
    
    
end
