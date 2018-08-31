
basedir = pwd;

subs = load('sublist');
tasks = { 'SOCIAL', 'WM', 'GAMBLING', 'EMOTION' };
run_names = {'LR', 'RL'};
fname = fullfile(basedir,'headmotion_runs.csv');
fid = fopen(fname,'w');
fprintf(fid,'subj,task,run,abs_mean,rel_mean\n');
idx = 0;
motion_mat = zeros(length(subs)*2*4,2);
for r = 1:length(run_names)
    run_name = run_names{r};
    for t = 1:length(tasks)
        task = tasks{t};
        for s = 1:length(subs)
            idx = idx + 1;
            subnum = subs(s);
            datadir = fullfile(basedir,'data',num2str(subnum),'MNINonLinear','Results',['tfMRI_' task '_' run_name]);
            abs_mean = load(fullfile(datadir,'Movement_AbsoluteRMS_mean.txt'));
            rel_mean = load(fullfile(datadir,'Movement_RelativeRMS_mean.txt'));
            fprintf(fid,'%d,%s,%s,%f,%f\n',subnum,task,run_name,abs_mean,rel_mean);
            motion_mat(idx,1) = abs_mean;
            motion_mat(idx,2) = rel_mean;
        end
    end
end
fclose(fid);
figure,boxplot(motion_mat);
