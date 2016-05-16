function [raw]=read_xls(path,name, sheet, range)

%  Read xls in RAW format (both numbers and txt)
%
% [trial_time]=read_xls2(path name, sheet, range)
% 


filexls= [ path name]

[trial_time txt raw]=xlsread(filexls,sheet,range);

