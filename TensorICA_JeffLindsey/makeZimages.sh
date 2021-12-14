#!/bin/bash

cd ..
basedir=`pwd`
cd fsl

dim=25

for task in Soc Gam; do
  melodicdir=${basedir}/fsl/concat_${dim}dim_task-${task}_LindseySubs_sm-2_merged_z_striatum.ica
  for i in `seq 0 24`; do
    icnum=`zeropad $i 4`
    fsl_glm -i ${melodicdir}/dual_regression/dr_stage2_ic${icnum}.nii.gz \
    -d ${basedir}/fsl/L3_n279_onesample-ttest.mat -o ${basedir}/fsl/task-${task}_ic${icnum}_cope --out_z=${basedir}/fsl/task-${task}_ic${icnum}_z
  done
  rm -rf ${basedir}/fsl/task-${task}_ic*_cope.nii.gz
  fslmerge -t task-${task}_merged_z task-${task}_ic*_z.nii.gz
done
