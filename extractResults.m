% set basic variables
basedir = pwd;

masks = {'roi-1_ofc', 'roi-2_tpole', 'roi-3_pcc', 'roi-4_mtg', 'roi-5_dmpfc', 'roi-6_sfg' };

for m = 1:length(masks)
    mask = fullfile(basedir,'Masks',[ masks{m} '.nii.gz']);
    subs = load('EuniceSubs.txt');
    
    % create output file with 13 columns (subj + 4 tasks * 3 DVs): p < 0.0021
    fname = fullfile(basedir,['results_' masks{m} '_zstat.csv']);
    fid = fopen(fname,'w');
    fprintf(fid,'subj,WorkingMemory,Reward\n');
    
    % loop through data
    for s = 1:length(subs)
        subnum = subs(s);
        datadir = fullfile(basedir,'fsl',num2str(subnum),'MNINonLinear','Results');
        
        % make cope variables
        WM_Act = fullfile(datadir,'L2_WM_Act.gfeat','cope3.feat','stats','zstat1.nii.gz');
        Gambling_Act = fullfile(datadir,'L2_Gam_Act.gfeat','cope3.feat','stats','zstat1.nii.gz');
        
        % extract data
        if subnum == 668361
            WM_Act  = NaN;
            WM_FC  = NaN;
            WM_PPI = NaN;
        else
            cmd = ['fslstats ' WM_Act ' -k ' mask ' -m '];
            [~,result] = system(cmd);
            WM_Act = str2double(result);
        end
        cmd = ['fslstats ' Gambling_Act ' -k ' mask ' -m '];
        [~,result] = system(cmd);
        Gambling_Act = str2double(result);
        
        results_mat(1,1) = WM_Act;
        results_mat(1,2) = Gambling_Act;
        
        fprintf(fid,'%d,%f,%f\n',subnum,results_mat);
        
    end
end

