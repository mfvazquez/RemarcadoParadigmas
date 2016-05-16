function ev2delete=find_repeatedmark(micromed_time, delta)

%                                                                         %
% ev_delete=find_repeatedmark(micromed_time)
% 
% This function find repeated mark due to photodiode mark error 
% If diff mark(i+1)-mark(i) < delta the mark is appended in the ev_delete
% vector
%

lenght=max(size(micromed_time));
ev2delete=[];

for i=1:lenght-1
   
    diff(i)=micromed_time(i+1)-micromed_time(i);
    
    if diff(i)<delta
    
        ev2delete=[ev2delete i+1];
    
    end
    
end