
maindatadir = '/data/projects/ppi-effect-sizes';
basedir = pwd;

subs = load('LindseySubs.txt');
tasks = { 'SOCIAL', 'GAMBLING' };
run_names = {'LR', 'RL'};

for t = 1:length(tasks)
    task = tasks{t};
    sub_data = zeros(length(subs),3);
    
    for r = 1:length(run_names)
        for s = 1:length(subs)
            subnum = subs(s);
            idx = 0;
            run_name = run_names{r};
            
            datadir = fullfile(maindatadir,'data',num2str(subnum),'MNINonLinear','Results',['tfMRI_' task '_' run_name]);
            
            % extract these
            abs_mean = load(fullfile(datadir,'Movement_AbsoluteRMS_mean.txt'));
            rel_mean = load(fullfile(datadir,'Movement_RelativeRMS_mean.txt'));
            
            fsldir = fullfile(maindatadir,'fsl',num2str(subnum),'MNINonLinear','Results',['tfMRI_' task '_' run_name]);
            motion_ICs_f = fullfile(fsldir,'smoothing.feat','ICA_AROMA','classified_motion_ICs.txt');
            motion_ICs = load(motion_ICs_f);
            n_bad = length(motion_ICs);
            melodic_mix_f = fullfile(fsldir,'smoothing.feat','ICA_AROMA','melodic.ica','melodic_mix');
            melodic_mix = load(melodic_mix_f);
            total = size(melodic_mix,2);
            
            % extract this
            pct_bad = n_bad / total;
            
            % add to matrix
            sub_data(s,1) = abs_mean;
            sub_data(s,2) = rel_mean;
            sub_data(s,3) = pct_bad;
        end
    end
    
    sub_data_demeaned = sub_data - mean(sub_data,1);
    fname = fullfile(basedir,sprintf('headmotion_task-%s_run-%s_demeaned.csv',task,run_name));
    fid = fopen(fname,'w');
    fprintf(fid,'subj,abs_mean,rel_mean,pct_removed\n');
    for s = 1:length(subs)
        subnum = subs(s);
        fprintf(fid,'%d,%f,%f,%f\n',subnum,sub_data_demeaned(s,:));
    end
    fclose(fid);
    
end

