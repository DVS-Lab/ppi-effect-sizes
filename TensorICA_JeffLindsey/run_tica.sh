#!/bin/sh

# --Tdes	        design matrix across time-domain
# --Tcon	        t-contrast matrix across time-domain
# --Sdes	        design matrix across subject-domain
# --Scon	        t-contrast matrix across subject-domain

cd ..
basedir=`pwd`
cd fsl


 melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-Soc_paths_unsmoothed.txt \
 -o tica_00dim_task-Soc_LindseySubs_unsmoothed_merged.ica -v --nobet --bgimage=mean_func \
 --report --guireport=report.html -d 0 \
 --mmthresh=0.5 --Ostats -a tica &


 melodic -i ${basedir}/TensorICA_JeffLindsey/LindseySubs_task-Gam_paths_unsmoothed.txt \
 -o tica_00dim_task-Gam_LindseySubs_unsmoothed_merged.ica -v --nobet --bgimage=mean_func \
 --report --guireport=report.html -d 0 \
 --mmthresh=0.5 --Ostats -a tica

