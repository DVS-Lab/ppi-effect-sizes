#!/bin/sh

task=$1 # Soc Gam
run=$2 # LR RL

cd ..
basedir=`pwd`
cd fsl

# Usage: dual_regression <group_IC_maps> <des_norm> <design.mat> <design.con> <n_perm> [--thr] <output_directory> <input1> <input2> <input3> .........
# e.g.   dual_regression groupICA.gica/groupmelodic.ica/melodic_IC 1 design.mat design.con 500 0 grot `cat groupICA.gica/.filelist`

rm -rf tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/dual_regression
dual_regression tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/melodic_IC \
  1 ${basedir}/TensorICA_JeffLindsey/L3_task-${task}_run-${run}_withCovs.mat ${basedir}/TensorICA_JeffLindsey/L3_task-${task}_run-${run}_withCovs.con 1 \
  tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/dual_regression \
  `cat ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt`

rm -rf tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_new_unsmoothed-concat.ica/dual_regression
dual_regression tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/melodic_IC \
  1 ${basedir}/TensorICA_JeffLindsey/L3_n279.mat ${basedir}/TensorICA_JeffLindsey/L3_n279.con 1 \
  tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_new_unsmoothed-concat.ica/dual_regression \
  `cat ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt`
