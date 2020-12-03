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

    melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths.txt \
    -o tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns_wCovs.ica -v --nobet --bgimage=mean_func \
    --report --guireport=report.html -d 0 \
    --Tdes=L1_task-${task}_run-${run}_design.mat --Tcon=L1_task-${task}_run-${run}_design.con \
    --Sdes=L3_n279_withCovs.mat --Scon=L3_n279_withCovs.con \
    --mmthresh=0.5 --Ostats -a tica


    melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths.txt \
    -o tica_00dim_task-${task}_run-${run}_LindseySubs_wDesigns.ica -v --nobet --bgimage=mean_func \
    --report --guireport=report.html -d 0 \
    --Tdes=L1_task-${task}_run-${run}_design.mat --Tcon=L1_task-${task}_run-${run}_design.con \
    --Sdes=L3_n279.mat --Scon=L3_n279.con \
    --mmthresh=0.5 --Ostats -a tica


  done
done
