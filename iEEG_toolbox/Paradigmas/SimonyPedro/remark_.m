
[micromed_time]=make_photodiodevector(EEG);
micromed_time=micromed_time-micromed_time(1);


%%

path='C:\Users\Ineco\Documents\IEEG\Pacientes\Paciente4_Peirone13072013\SimonyPedro\dia1\Simon\'
name='peirone.xls'
sheet='peirone'
range='i2:i161'


%%

trial_time2(:,1)=make_logtimevector2(path,name, sheet, range);

range='j2:j161'

trial_time2(:,2)=make_logtimevector2(path,name, sheet, range);

range='h2:h161'

trial_time2(:,3)=make_logtimevector2(path,name, sheet, range);

[trial_time]=merge_trialtime(trial_time2);

trial_time=trial_time-trial_time(1);


%%

plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on

plot([micromed_time;micromed_time],[-100;0],'r')
hold on   

%%

range='k2:k161'

marktype=read_xls(path,name, sheet, range);


range='p2:p161'


accuracy=read_xls(path,name, sheet, range);


%%

if max(size(marktype)) == max(size(accuracy))

    for i=1:max(size(marktype))
        
        if accuracy(i) == 1
           
            marktype(i)=marktype(i)+11;
            
        else
           
            
            marktype(i)=marktype(i)+21;
            
        end
        
    end
    
end


for i=1:max(size(marktype))

    marcas(3*(i-1)+1)=marktype(i);
    marcas(3*(i-1)+2)=marktype(i);
    marcas(3*(i-1)+3)=marktype(i);
    
end


for i=1:max(size(marcas))

    EEG = pop_editeventvals(EEG,'changefield',{i 'type' marcas(i)});    

end


%%

for i=1:max(size(EEG.event))/3
   
    marca_1=EEG.event(3*(i-1)+1).type;
    marca_2=EEG.event(3*(i-1)+2).type;
    marca_3=EEG.event(3*(i-1)+3).type;
    
    
    EEG = pop_editeventvals(EEG,'changefield',{3*(i-1)+1 'type' ['1' marca_1]});    
    EEG = pop_editeventvals(EEG,'changefield',{3*(i-1)+2 'type' ['2' marca_2]});    
    EEG = pop_editeventvals(EEG,'changefield',{3*(i-1)+3 'type' ['3' marca_3]});    

end

eeglab redraw