#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
rm -rf LindseySubs_task-*paths_unsmoothed.txt
for run in LR RL; do
  for s in `cat LindseySubs.txt`; do
    fname_gam=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_${run}/preprocess_sub-${s}_task-GAMBLING_run-${run}_hp-200_sm-0.feat/filtered_func_data.nii.gz
    echo $fname_gam >> LindseySubs_task-Gam_run-${run}_paths_unsmoothed.txt
    fname_soc=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/preprocess_sub-${s}_task-SOCIAL_run-${run}_hp-200_sm-0.feat/filtered_func_data.nii.gz
    echo $fname_soc >> LindseySubs_task-Soc_run-${run}_paths_unsmoothed.txt
  done
done
