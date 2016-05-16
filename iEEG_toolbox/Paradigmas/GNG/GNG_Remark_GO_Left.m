%% RUN AFTER GO RIGHT
%%

clear log_times;
clear trial_time;

mtype='Go Left'
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

% plot([log_times(:)';log_times(:)'],[0;150],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on

%% Complete start_log and correct time vector

start_log=1;
trial_time=log_times(start_log:max(size(log_times)))-log_times(start_log);


%%

trial_time=trial_time+micromed_time(9); %Go Left 9

%%
% 
% plot([trial_time(:)';trial_time(:)'],[0;150],'g')
% hold on
% plot([micromed_time;micromed_time],[-100;0],'r')
% hold on

%% Search for repeated marks

delta=0.1;
ev2delete=find_repeatedmark(micromed_time, delta);


%% Find the indices of the event associated with a defined type
clear ev2mark
ev2mark=find_mark2remark(micromed_time,trial_time);
ev2mark=[ev2mark 1865];

%% I have to change the mark type

if max(size(trial_time))==max(size(ev2mark))
    
    for i=1:max(size(ev2mark))
        
         EEG = pop_editeventvals(EEG,'changefield',{ev2mark(i) 'type' mtype});
        
    end
    
end

disp('done');