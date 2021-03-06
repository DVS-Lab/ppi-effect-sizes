#!/bin/sh

# --Tdes	        design matrix across time-domain
# --Tcon	        t-contrast matrix across time-domain
# --Sdes	        design matrix across subject-domain
# --Scon	        t-contrast matrix across subject-domain

cd ..
basedir=`pwd`
cd fsl

for task in Soc Gam; do
  for run in LR RL; do

    melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt \
    -o tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs_new_unsmoothed-concat.ica -v --nobet --bgimage=mean_func \
    --report --guireport=report.html -d 0 \
    --Tdes=${basedir}/TensorICA_JeffLindsey/L1_task-${task}_run-${run}_design.mat --Tcon=${basedir}/TensorICA_JeffLindsey/L1_task-${task}_run-${run}_design.con \
    --Sdes=${basedir}/TensorICA_JeffLindsey/L3_task-${task}_run-${run}_withCovs.mat --Scon=${basedir}/TensorICA_JeffLindsey/L3_task-${task}_run-${run}_withCovs.con \
    --mmthresh=0.5 --Ostats -a concat


    melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths_unsmoothed.txt \
    -o tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_new_unsmoothed-concat.ica -v --nobet --bgimage=mean_func \
    --report --guireport=report.html -d 0 \
    --Tdes=${basedir}/TensorICA_JeffLindsey/L1_task-${task}_run-${run}_design.mat --Tcon=${basedir}/TensorICA_JeffLindsey/L1_task-${task}_run-${run}_design.con \
    --Sdes=${basedir}/TensorICA_JeffLindsey/L3_n279.mat --Scon=${basedir}/TensorICA_JeffLindsey/L3_n279.con \
    --mmthresh=0.5 --Ostats -a concat


  done
done
