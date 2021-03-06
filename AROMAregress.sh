#!/bin/bash

sub=$1
task=$2
run=$3

# input data
if [ $sub -eq 171532 ]; then # accounts for the one broken subject
  hcpdatadir=/data/projects/hcp_extra/human-connectome-project-openaccess/HCP1200
else
  hcpdatadir=/data/projects/human-connectome-project-openaccess/HCP1200
fi
indata=${hcpdatadir}/${sub}/MNINonLinear/Results/tfMRI_${task}_${run}/tfMRI_${task}_${run}.nii.gz

# project dir (outputs and some inputs will be beneath here)
ppidir=/data/projects/ppi-effect-sizes

# aroma stuff
aromadir=${ppidir}/fsl/${sub}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA
mask=${aromadir}/mask.nii.gz
badICs=${aromadir}/classified_motion_ICs.txt
melodic_mix=${aromadir}/melodic.ica/melodic_mix
outdata=${aromadir}/denoised_func_data_nonaggr_nosmoothing

# regress out aroma components
if [ ! -e ${outdata}.nii.gz ]; then
	echo "denoising $indata"
	fsl_regfilt -i $indata \
	    -f $(cat ${badICs}) \
	    -d $melodic_mix \
	    -o $outdata \
      -m $mask
fi
