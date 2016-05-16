
path='C:\Users\Ineco\Documents\IEEG\Pacientes\Juan\Dia3_\9_VWM_Mario\Single_BW\';
path2=path;
name='VWM_BW_Single_Bloque2_log.xls',
name2=name;
sheet='Hoja1'
% range='A1:A90';
range='C10:C88';
sheet2='Hoja2'
% range2='A1:A90';
range2='A10:A88';


[acc direction]=get_marktypeandacc(path,name, sheet, range,path2,name2, sheet2, range2);

%%


for i=1:(max(size(direction)))
i
    
    if direction(i)==1
    
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+1) 'type' 241});
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+2) 'type' 242});
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+3) 'type' 243});
    
    else
    
        
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+1) 'type' 141});
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+2) 'type' 142});
        EEG = pop_editeventvals(EEG,'changefield',{(3*(i-1)+3) 'type' 143});
    
        
    end
 
end
%%



        EEG = pop_editeventvals(EEG,'delete',239);
        EEG = eeg_checkset( EEG );
       
        EEG = pop_editeventvals(EEG,'delete',238);
        EEG = eeg_checkset( EEG );

        eeglab redraw

%%

nr_event=max(size(EEG.event));
% accuracy=acc(1:79,1);
accuracy=acc(:,1);
it=max(size(accuracy));

for i=1:it
    
     if accuracy(it-i+1)==0
         
        
        EEG = pop_editeventvals(EEG,'delete',nr_event-(3*(i-1)));
        EEG = pop_editeventvals(EEG,'delete',nr_event-(3*(i-1)+1));
        EEG = pop_editeventvals(EEG,'delete',nr_event-(3*(i-1)+2));
        EEG = eeg_checkset( EEG );
     
    
     end
     
end