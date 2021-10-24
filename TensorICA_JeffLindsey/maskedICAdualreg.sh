#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
task=$1 # Soc or Gam
dim=$2 # 00 or 25


cd ..
basedir=`pwd`
cd fsl

# inputs
masked_list=${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-${task}_paths_sm-2_merged_striatum.txt
wb_list=${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-${task}_paths_sm-2_merged.txt
melodicdir=${basedir}/fsl/concat_${dim}dim_task-${task}_LindseySubs_sm-2_merged_z_striatum.ica

# remove old output
rm -rf ${melodicdir}/dual_regression

# run dr
bash leech12_dualregression.sh ${melodicdir}/melodic_IC \
  1 ${basedir}/TensorICA_JeffLindsey/L3_n279.mat ${basedir}/TensorICA_JeffLindsey/L3_n279.con 1 \
  ${melodicdir}/dual_regression \
	${basedir}/TensorICA_JeffLindsey/StriatumMask_atlas.nii \
	`cat ${masked_list}` \
  `cat ${wb_list}`
