#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
rm -rf zLindseySubs_task-*paths_unsmoothed_merged.txt

for s in `cat LindseySubs.txt`; do
	
	 # gambling
	 fname_gam_LR=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_LR/preprocess_sub-${s}_task-GAMBLING_run-LR_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fslmaths $fname_gam_LR -Tmean tmp_mean
	 fslmaths $fname_gam_LR -Tstd tmp_std
	 fslmaths $fname_gam_LR -sub tmp_mean -div tmp_std tmp_z_LR
	 rm -rf tmp_std.nii.gz tmp_mean.nii.gz 
	 
	 fname_gam_RL=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_RL/preprocess_sub-${s}_task-GAMBLING_run-RL_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fslmaths $fname_gam_RL -Tmean tmp_mean
	 fslmaths $fname_gam_RL -Tstd tmp_std
	 fslmaths $fname_gam_RL -sub tmp_mean -div tmp_std tmp_z_RL
	 
	 fname_gam_merged=${basedir}/${s}/MNINonLinear/Results/sub-${s}_task-GAMBLING_filtered_func_data_merged.nii.gz
	 rm -rf $fname_gam_merged
	 fslmerge -t $fname_gam_merged tmp_z_LR.nii.gz tmp_z_RL.nii.gz
	 echo $fname_gam_merged >> zLindseySubs_task-Gam_paths_unsmoothed_merged.txt
	 
	 rm -rf tmp*.nii.gz
	  
	 
	 # social
	 fname_gam_LR=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_LR/preprocess_sub-${s}_task-SOCIAL_run-LR_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fslmaths $fname_soc_LR -Tmean tmp_mean
	 fslmaths $fname_soc_LR -Tstd tmp_std
	 fslmaths $fname_soc_LR -sub tmp_mean -div tmp_std tmp_z_LR
	 rm -rf tmp_std.nii.gz tmp_mean.nii.gz 
	 
	 fname_gam_RL=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_RL/preprocess_sub-${s}_task-SOCIAL_run-RL_hp-200_sm-0.feat/filtered_func_data.nii.gz
	 fslmaths $fname_soc_RL -Tmean tmp_mean
	 fslmaths $fname_soc_RL -Tstd tmp_std
	 fslmaths $fname_soc_RL -sub tmp_mean -div tmp_std tmp_z_RL
	 
	 fname_gam_merged=${basedir}/${s}/MNINonLinear/Results/sub-${s}_task-SOCIAL_filtered_func_data_merged.nii.gz
	 rm -rf $fname_soc_merged
	 fslmerge -t $fname_soc_merged tmp_z_LR.nii.gz tmp_z_RL.nii.gz
	 echo $fname_soc_merged >> zLindseySubs_task-Soc_paths_unsmoothed_merged.txt
	 
	 rm -rf tmp*.nii.gz

done


cd ..
basedir=`pwd`
cd fsl


 melodic -i ${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-Soc_paths_unsmoothed_merged.txt \
 -o tica_00dim_task-Soc_LindseySubs_unsmoothed_merged_z.ica -v --nobet --bgimage=mean_func \
 --report --guireport=report.html -d 0 \
 --mmthresh=0.5 --Ostats -a tica &


 melodic -i ${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-Gam_paths_unsmoothed_merged.txt \
 -o tica_00dim_task-Gam_LindseySubs_unsmoothed_merged_z.ica -v --nobet --bgimage=mean_func \
 --report --guireport=report.html -d 0 \
 --mmthresh=0.5 --Ostats -a tica


