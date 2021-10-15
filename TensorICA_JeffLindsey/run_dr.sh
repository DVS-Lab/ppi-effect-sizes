#!/bin/sh

task=$1 # Soc Gam
dim=$2 # 00 25

cd ..
basedir=`pwd`
cd fsl

# Usage: dual_regression <group_IC_maps> <des_norm> <design.mat> <design.con> <n_perm> [--thr] <output_directory> <input1> <input2> <input3> .........
# e.g.   dual_regression groupICA.gica/groupmelodic.ica/melodic_IC 1 design.mat design.con 500 0 grot `cat groupICA.gica/.filelist`

melodicdir=${basedir}/fsl/concat_${dim}dim_task-${task}_LindseySubs_sm-2_merged_z.ica

# remove old output
rm -rf ${melodicdir}/dual_regression

# run dr
dual_regression ${melodicdir}/melodic_IC \
  1 ${basedir}/TensorICA_JeffLindsey/L3_n279.mat ${basedir}/TensorICA_JeffLindsey/L3_n279.con 1 \
  ${melodicdir}/dual_regression \
  `cat ${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-${task}_paths_sm-2_merged.txt`
