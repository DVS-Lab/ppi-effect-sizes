#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
rm -rf LindseySubs_task-*paths.txt
for run in LR RL; do
  for s in `cat LindseySubs.txt`; do
    fname_gam=${basedir}/${s}/MNINonLinear/Results/tfMRI_GAMBLING_${run}/L1_Gam_Act.feat/filtered_func_data.nii.gz
    echo $fname_gam >> LindseySubs_task-Gam_run-${run}_paths.txt
    fname_soc=${basedir}/${s}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/filtered_func_data.nii.gz
    echo $fname_soc >> LindseySubs_task-Soc_run-${run}_paths.txt
  done
done
