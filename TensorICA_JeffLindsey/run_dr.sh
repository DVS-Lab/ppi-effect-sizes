#!/bin/sh

task=$1 # Soc Gam
run=$2 # LR RL

cd ..
basedir=`pwd`
cd fsl


dual_regression tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/melodic_IC \
1 -1 1 0 \ # <des_norm> <design.mat> <design.con> <n_perm> [--thr] (note: -1 sets "<design.mat> <design.con>" to one sample t-test)
tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/dual_regression \
`cat ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt`


dual_regression tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica/melodic_IC \
1 -1 1 0 \ # <des_norm> <design.mat> <design.con> <n_perm> [--thr] (note: -1 sets "<design.mat> <design.con>" to one sample t-test)
tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_new_unsmoothed-concat.ica/dual_regression \
`cat ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt`
