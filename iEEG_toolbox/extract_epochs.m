function epochs=extract_epochs(hband_sig_r,micromed_time_type1,pretime,postime,srate)


%%
len=max(size(micromed_time_type1));
chan_size=size(hband_sig_r,2)


for i=1:len
   
    i
    for j=1:chan_size
        
        epochs(i,:,j)=hband_sig_r((micromed_time_type1(i)-pretime+1):(micromed_time_type1(i)+postime),j);
        baseline(i,:,j)=hband_sig_r((micromed_time_type1(i)-0.2*srate):(micromed_time_type1(i)-1),j);
        epochs_nb(i,:,j)=(epochs(i,:,j)-mean(baseline(i,:,j)))/std(baseline(i,:,j));
        
        
    end
    
end

