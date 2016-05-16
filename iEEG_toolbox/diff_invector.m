function diff=diff_invector(micromed_time)


%                                                                       %
%  diff=diff_invector(micromed_time)
%
%  Calculate the difference within vector
%

lenght=max(size(micromed_time));

micromed_time_desp=[micromed_time(2:lenght)' micromed_time(1)'];

diff=micromed_time-micromed_time_desp';

% 
% for i=1:max(size(micromed_time))-1
%    
%     diff(i)=micromed_time(i+1)-micromed_time(i);
%     
% end