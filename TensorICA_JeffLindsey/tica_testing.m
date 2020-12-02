close all
clear all

% load all pairwise correlations
load corr_vals.txt
figure,hist(corr_vals(:,3),50)
title('Pairwise Correlations Between Spatial Maps')

figure,plot(corr_vals(1:10,3))
hline(0)
title('First 10 correlations')
xlabel('LR IC number')
ylabel('correlation')

%{
IC_RL IC_LR corr
  1   1 0.93
  1   2 0.92
  1   3 0.84
  1   4 -0.89
  1   5 0.70
  1   6 0.61
  1   7 0.26
  1   8 -0.24
  1   9 -0.35
  1  10 -0.12
%}

nICs = 10;

% compare LR and RL subject modes
load tica_00dim_gambling_RL_WB.ica/melodic_Smodes
RL_IC1 = melodic_Smodes(:,1);
load tica_00dim_gambling_LR_WB.ica/melodic_Smodes
LR_ICs = melodic_Smodes(:,1:nICs);
corr_mat = corr([RL_IC1 LR_ICs]);
figure,imagesc(corr_mat);
title('Correlation Between Subject Modes')
colorbar

% compare temporal modes
subject = 1;
RL_t1 = load('tica_00dim_gambling_RL_WB.ica/report/t1.txt');
RL_t1 = RL_t1(:,subject+1);
LR_ts = zeros(length(RL_t1),nICs);
for i = 1:nICs
    tmp_mat = load(sprintf('tica_00dim_gambling_LR_WB.ica/report/t%d.txt',i));
    LR_ts(:,i) = tmp_mat(:,subject+1);
end
corr_mat = corr([RL_t1 LR_ts]);
figure,imagesc(corr_mat);
title('Correlation Between Temporal Modes')
colorbar

