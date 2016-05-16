%% RUN AFTER GO RIGHT Hay algun problema con este revisar!!
%%

%% Vuelvo a cargar el vector de micromed sin las marcas que ya fueron
% remarcadas

clear micromed_time
marktype='chan2';
[micromed_time indexes]=make_photodiodevector_marktype2(EEG,marktype);
micromed_time=micromed_time-micromed_time(1);

%%

clear log_times;
clear trial_time;

mtype='Response'
j=1;
for i=1:size(log_cell.event_time,1)-1
   
    strings.etype=cell2mat(log_cell.event_time(i+1,3));
    strings.apress=cell2mat(log_cell.event_time(i+1,6));
    
    if strcmp(strings.etype,mtype) 
        
                   
            log_times(j)=cell2mat(log_cell.event_time(i+1,4))/1000;
            j=j+1;

       
    end
    
    clear strings;
end


%% Look at the marks and decide which is the first one

plot([log_times(:)';log_times(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on

%% Complete start_log and correct time vector

start_log=1;
trial_time=log_times(start_log:max(size(log_times)))-log_times(start_log);


%%

trial_time=trial_time+micromed_time(2); %Response

%%

plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time;micromed_time],[-100;0],'r')
hold on



%% Search for repeated marks

delta=0.1;
ev2delete=find_repeatedmark(micromed_time, delta);
micromed_time(ev2delete)=[];

delta=0.1;
ev2delete=find_repeatedmark(micromed_time, delta);
micromed_time(ev2delete)=[];

delta=0.1;
ev2delete=find_repeatedmark(micromed_time, delta);
micromed_time(ev2delete)=[];

%% Find the indices of the event associated with a defined type

clear ev2mark
ev2mark=[];
while (size(ev2mark,2)+1)<size(trial_time,2)

     ev2mark=find_mark2remark2(micromed_time,trial_time,0.05); 
     trial_time(size(ev2mark,2)+1)=[];

end
%% 
plot([trial_time(:)';trial_time(:)'],[0;150],'g')
hold on
plot([micromed_time(ev2mark);micromed_time(ev2mark)],[-100;0],'r')
hold on




%% I have to change the mark type




if max(size(trial_time))==max(size(ev2mark))
    
    for i=1:max(size(ev2mark))
        
        if strcmp(EEG.event(1,indexes(ev2mark(i))).type,'chan2') 
         
            EEG = pop_editeventvals(EEG,'changefield',{indexes(ev2mark(i)) 'type' mtype});
        
        end
    end
    
end

disp('done');

%% Test

test=[];

for i=1:max(size(EEG.event))
   
    if strcmp (EEG.event(1,i).type,'Response')
       
       test=[test i]; 
        
    end
    
end