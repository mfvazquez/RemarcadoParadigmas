
log=xlsread('visual_log2.xls','Hoja1','A1:A300');

%%


for i=1:max(size(log))

        EEG = pop_editeventvals(EEG,'changefield',{i 'type' log(i)});
       i 
 
end

