function [acc direction]=get_marktypeandacc(path,name, sheet, range,path2,name2, sheet2, range2)

%                                                                           
% [acc direction]=get_marktypeandacc(path,name, sheet, range,path2,name2, sheet2, range2) 
%
% Gives back the accuracy and the direction vector
%

file1=[path name];
file2=[path2 name2];

acc=xlsread(file1,sheet,range);
direction=xlsread(file2,sheet2,range2);
