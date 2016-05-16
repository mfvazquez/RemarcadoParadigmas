
clear micromed_time;
marktype='chan2';
[micromed_time indexes]=make_photodiodevector_marktype2(EEG,marktype);
EEG=delete_mark(EEG,indexes);
disp('done');
