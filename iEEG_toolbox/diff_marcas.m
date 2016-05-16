function diff=diff_marcas(micromed_time,trial_time)


tam(1)=max(size(micromed_time));
tam(2)=max(size(trial_time));

for i=1:min(tam)
    
    diff(i)=abs(micromed_time(i)-trial_time(i));
    
end