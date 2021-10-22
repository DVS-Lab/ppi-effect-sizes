#!/bin/bash

basedir=/data/projects/ppi-effect-sizes/fsl
task=$1


rm -rf zLindseySubs_task-${task}_paths_sm-2_merged_striatum.txt

for s in `cat zLindseySubs_task-${task}_paths_sm-2_merged.txt`; do
	outbase=`remove_ext $s`
	fslmaths $s -mas StriatumMask_atlas.nii ${outbase}_striatum
	echo ${outbase}_striatum.nii.gz >> zLindseySubs_task-${task}_paths_sm-2_merged_striatum.txt
done

cd ..
basedir=`pwd`
cd fsl

melodic -i ${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-${task}_paths_sm-2_merged_striatum.txt \
-o concat_00dim_task-${task}_LindseySubs_sm-2_merged_z_striatum.ica -v --nobet --bgimage=mean_func \
--report --guireport=report.html -d 0 \
--mmthresh=0.5 --Ostats -a concat 


melodic -i ${basedir}/TensorICA_JeffLindsey/zLindseySubs_task-${task}_paths_sm-2_merged_striatum.txt \
-o concat_25dim_task-${task}_LindseySubs_sm-2_merged_z_striatum.ica -v --nobet --bgimage=mean_func \
--report --guireport=report.html -d 25 \
--mmthresh=0.5 --Ostats -a concat &
