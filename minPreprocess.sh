#!/bin/bash

basedir=`pwd`

sub=$1
task=$2
run=$3

# setting up dirs
mainoutput=${basedir}/fsl/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}
output=${mainoutput}/preprocess_sub-${sub}_task-${task}_run-${run}_hp-200_sm-0
data=${mainoutput}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr_nosmoothing.nii.gz
nvols=`fslnvols ${data}`

# checking output
if [ -e ${output}.feat/filtered_func_data.nii.gz ]; then
  echo "output exists, skipping...."
  exit
else
	echo "re-running $subj $task $run" >> re-run_preprocess.log
  rm -rf ${output}.feat
fi

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/minPreprocess.fsf
OTEMPLATE=${mainoutput}/minPreproces.fsf
sed -e 's@OUTPUT@'$output'@g' \
-e 's@DATA@'$data'@g' \
-e 's@NVOLUMES@'$nvols'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE
