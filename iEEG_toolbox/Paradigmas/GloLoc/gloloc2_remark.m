
log=xlsread('sequence_log4.xls','Hoja1','A1:A300');

%%


for i=1:max(size(log))

    if log(i)>0 && log(i)<10 
    
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
    elseif log(i)>10 && log(i)<20
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
    elseif log(i)>20 && log(i)<30
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
    
    elseif log(i)>30 && log(i)<40
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
        
    elseif log(i)>40 && log(i)<50
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
        
    elseif log(i)>50 && log(i)<60
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
        
    elseif log(i)>60 && log(i)<70
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
        
    elseif log(i)>70 && log(i)<80
    
       
        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
        
    end
 
end

% 
% for i=1:max(size(log))
% 
%     if log(i)>80 && log(i)<90 
%     
%         EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
%         
%     elseif log(i)>90 && log(i)<100
%     
%        
%         EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
%         
%     elseif log(i)>100 && log(i)<110
%     
%        
%         EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
%         
%     end
%  
% end