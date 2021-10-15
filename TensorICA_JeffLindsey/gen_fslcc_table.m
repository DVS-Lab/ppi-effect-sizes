% summarizes the fslcc output from the command below:
% fslcc -t -1 --noabs -m melodic_mask.nii.gz melodic_IC_dim-25_task-Gam.nii.gz PNAS_Smith09_rsn10.nii.gz > fslcc_output_task-Gam.txt
%
% goals are to a) identify the best-matching components with Smith09PNAS,
% b) collect descriptive stats for other components (mean corr, range of corrs),
% and c) output a table for the paper supplement

tasks = {'Soc', 'Gam'};
for t = 1:length(tasks)
    task = tasks{t};
    
    % load in all pairwise spatial correlations (10 * 25)
    % result is 1140 x 3 matrix (col1 is melodic_IC, col2 is Smith09 map, col3 is correlation
    indata = load(['fslcc_output_task-' task '.txt']);
    
    % reshape into 25 x 10 matrix (this could just go into the supplement)
    nICs = 25;
    data_mat = zeros(nICs,10);
    myrownames = cell(nICs,1);
    mycolnames = cell(1,10);
    for i = 1:nICs
        myrownames{i,1} = sprintf('melodicIC_%03d',i);
        for j = 1:10
            if i == 1
                mycolnames{1,j} = sprintf('smith09_%02d',j);
            end
            data_mat(i,j) = indata((indata(:,1)==i & indata(:,2)==j),3);
        end
    end
    
    data_mat_full = data_mat;
    [max_vals,i] = max(data_mat);
    for x = 1:length(i)
        data_mat(i(x),x) = NaN; %replace with NaNs
    end
    
    %get descriptives for each smith09 map after removing max correlation
    mean_corr = nanmean(data_mat);
    std_corr = nanstd(data_mat);
    min_corr = nanmin(data_mat);
    max_corr = nanmax(data_mat);
    
    
    corr_stats = [i; max_vals; mean_corr; std_corr; min_corr; max_corr];
    rownames_corr = {'melodic_IC', 'corr with Smith09', 'mean corr (other)','std corr (other)','min corr (other)','max corr (other)'};
    
    % convert corr_stats to table and output as a spreadsheet
    output = ['corr_statsummary_dim-25_task-' task '.csv'];
    T = array2table(corr_stats,'VariableNames',mycolnames,'RowNames',rownames_corr);
    writetable(T,output,'WriteRowNames',true)
    
    % convert data_mat to table and output as a spreadsheet
    output = ['corrmatrix_dim-25_task-' task '.csv'];
    T = array2table(data_mat_full,'VariableNames',mycolnames,'RowNames',myrownames);
    writetable(T,output,'WriteRowNames',true)
    
end