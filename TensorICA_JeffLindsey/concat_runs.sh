#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
rm -rf LindseySubs_task-*paths_unsmoothed_merged.txt

for s in `cat LindseySubs.txt`; do
	 fname_gam_LR=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_LR/preprocess_sub-${s}_task-GAMBLING_run-LR_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fname_gam_RL=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_RL/preprocess_sub-${s}_task-GAMBLING_run-RL_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fname_gam_merged=${basedir}/${s}/MNINonLinear/Results/sub-${s}_task-GAMBLING_filtered_func_data_merged.nii.gz
	 fslmerge -t $fname_gam_merged $fname_gam_LR $fname_gam_RL
	 echo $fname_gam_merged >> LindseySubs_task-Gam_paths_unsmoothed_merged.txt
	  
	 fname_soc_LR=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_LR/preprocess_sub-${s}_task-SOCIAL_run-LR_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fname_soc_RL=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_RL/preprocess_sub-${s}_task-SOCIAL_run-RL_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fname_soc_merged=${basedir}/${s}/MNINonLinear/Results/sub-${s}_task-SOCIAL_filtered_func_data_merged.nii.gz
	 fslmerge -t $fname_soc_merged $fname_soc_LR $fname_soc_RL
	 echo $fname_soc_merged >> LindseySubs_task-Soc_paths_unsmoothed_merged.txt

done

