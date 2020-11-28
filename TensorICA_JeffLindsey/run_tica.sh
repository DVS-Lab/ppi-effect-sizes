#!/bin/sh

cd ..
basedir=`pwd`
cd fsl
for task in Soc Gam; do
  for run in LR RL; do

    melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-${task}_run-${run}_paths.txt \
    -o tica_00dim_task-${task}_run-${run}_LindseySubs.ica -v --nobet --bgimage=mean_func \
    --report --guireport=report.html -d 0 \
    --mmthresh=0.5 --Ostats -a tica

  done
done
