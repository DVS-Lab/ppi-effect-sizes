% set basic variables
basedir = pwd;
mask = fullfile(basedir,'Masks','rEunice_tmp.nii');
subs = load('EuniceSubs.txt');

% create output file with 13 columns (subj + 4 tasks * 3 DVs): p < 0.0021
fname = fullfile(basedir,'resultsOFC_tmp.csv');
fid = fopen(fname,'w');
fprintf(fid,'subj,Social_Act,Social_FC,Social_PPIdiff,WM_Act,WM_FC,WM_PPIdiff,Emotion_Act,Emotion_FC,Emotion_PPIdiff,Gambling_Act,Gambling_FC,Gambling_PPIdiff\n');

% loop through data
for s = 1:length(subs)
    subnum = subs(s);
    datadir = fullfile(basedir,'fsl',num2str(subnum),'MNINonLinear','Results');
    
    % make cope variables
    Social_Act = fullfile(datadir,'L2_Social_Act.gfeat','cope1.feat','stats','cope1.nii.gz');
    Social_FC = fullfile(datadir,'L2_Social_PPI.gfeat','cope3.feat','stats','cope1.nii.gz');
    Social_PPI = fullfile(datadir,'L2_Social_PPI.gfeat','cope6.feat','stats','cope1.nii.gz');
    
    WM_Act = fullfile(datadir,'L2_WM_Act.gfeat','cope3.feat','stats','cope1.nii.gz');
    WM_FC = fullfile(datadir,'L2_WM_PPI.gfeat','cope3.feat','stats','cope1.nii.gz');
    WM_PPI = fullfile(datadir,'L2_WM_PPI.gfeat','cope7.feat','stats','cope1.nii.gz');
    
    Emotion_Act = fullfile(datadir,'L2_Emotion_Act.gfeat','cope1.feat','stats','cope1.nii.gz');
    Emotion_FC = fullfile(datadir,'L2_Emotion_PPI.gfeat','cope3.feat','stats','cope1.nii.gz');
    Emotion_PPI = fullfile(datadir,'L2_Emotion_PPI.gfeat','cope4.feat','stats','cope1.nii.gz');
    
    Gambling_Act = fullfile(datadir,'L2_Gam_Act.gfeat','cope3.feat','stats','cope1.nii.gz');
    Gambling_FC = fullfile(datadir,'L2_Gam_PPI.gfeat','cope3.feat','stats','cope1.nii.gz');
    Gambling_PPI = fullfile(datadir,'L2_Gam_PPI.gfeat','cope6.feat','stats','cope1.nii.gz');
    
    
    % extract data
    if subnum == 317332
        Social_Act  = NaN;
        Social_FC  = NaN;
        Social_PPI = NaN;
    else
        cmd = ['fslstats ' Social_Act ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        Social_Act = str2double(result);
        cmd = ['fslstats ' Social_FC ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        Social_FC = str2double(result);
        cmd = ['fslstats ' Social_PPI ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        Social_PPI = str2double(result);
    end
    
    if subnum == 668361
        WM_Act  = NaN;
        WM_FC  = NaN;
        WM_PPI = NaN;
    else
        cmd = ['fslstats ' WM_Act ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        WM_Act = str2double(result);
        cmd = ['fslstats ' WM_FC ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        WM_FC = str2double(result);
        cmd = ['fslstats ' WM_PPI ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        WM_PPI = str2double(result);
    end
    cmd = ['fslstats ' Emotion_Act ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Emotion_Act = str2double(result);
    cmd = ['fslstats ' Emotion_FC ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Emotion_FC = str2double(result);
    cmd = ['fslstats ' Emotion_PPI ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Emotion_PPI = str2double(result);
    
    cmd = ['fslstats ' Gambling_Act ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Gambling_Act = str2double(result);
    cmd = ['fslstats ' Gambling_FC ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Gambling_FC = str2double(result);
    cmd = ['fslstats ' Gambling_PPI ' -k ' mask ' -m '];
    [~,result] = system(cmd);
    Gambling_PPI = str2double(result);
    
    
    results_mat(1,1) = Social_Act;
    results_mat(1,2) = Social_FC;
    results_mat(1,3) = Social_PPI;
    results_mat(1,4) = WM_Act;
    results_mat(1,5) = WM_FC;
    results_mat(1,6) = WM_PPI;
    results_mat(1,7) = Emotion_Act;
    results_mat(1,8) = Emotion_FC;
    results_mat(1,9) = Emotion_PPI;
    results_mat(1,10) = Gambling_Act;
    results_mat(1,11) = Gambling_FC;
    results_mat(1,12) = Gambling_PPI;
    
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',subnum,results_mat);
    
end


