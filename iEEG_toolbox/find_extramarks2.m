function ev2erase=find_extramarks2(micromed_time,trial_time, delta)

%                                                                          %
% ev2erase=find_extramarks(micromed_time,trial_time)
%
% This function compare each photodiode mark to a log mark. If it found a
% difference lower than delta ms its keeps the photodiode mark. Other way it
% mark that mark as erasable. 
%


ev2erase=[];
i_micro=1;
i_trial=1;
tam(1)=max(size(micromed_time));
tam(2)=max(size(trial_time));
long=min(tam);
ok_vect=ones(1,tam(1));


for i=1:tam(1)
   
    for j=1:tam(2)
       
        d=abs(micromed_time(i)-trial_time(j));
        if d<delta
            ok_vect(i)=0;
            break;
        end
        
    end
    
end

ev2erase=find(ok_vect>0);