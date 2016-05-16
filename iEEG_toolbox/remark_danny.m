function EEG=remark_danny(EEG,triggers)


%                                                                          
%   EEG=remark_danny(EEG,triggers)                                                                       %
%   
%   This function remarks the EEG using mark type in trigger vector struct
%

if max(size(EEG.event))==max(size(triggers))
    
    for i=1:max(size(EEG.event))
        
         EEG = pop_editeventvals(EEG,'changefield',{i 'type' triggers(i).name});
        
    end
    
else
    
    printf('Size does not match!');
    
end