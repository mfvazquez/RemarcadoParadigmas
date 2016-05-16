function insert=insert_missingmarks(micromed_time, trial_time)

%%
i_micro=1;
i_trial=1;
lenght=max(size(trial_time));
lenghtm=max(size(micromed_time));
insert=[];

for j=1:lenght
    
    
   if i_micro<lenghtm && i_trial<lenght 
        
       d=abs(micromed_time(i_micro)- trial_time(i_trial));
        if d<0.5

            i_micro=i_micro+1;
            i_trial=i_trial+1;

        else

            i_trial=i_trial+1;
            insert=[insert i_trial];

        end

   end
end

%%
