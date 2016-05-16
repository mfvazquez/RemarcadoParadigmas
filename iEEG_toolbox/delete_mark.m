function EEG=delete_mark(EEG,mark_vector)

%                                                                          %
% delete_mark(EEG,mark_num)
%
% Erase the events on mark_num vector from EEG structure
%

long=max(size(mark_vector))

for i=1:long

    EEG = pop_editeventvals(EEG,'delete',mark_vector(long-i+1))
    
end
