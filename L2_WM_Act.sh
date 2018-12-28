#!/bin/bash

basedir=`pwd`
MAINDATADIR=${basedir}/data
MAINOUTPUTDIR=${basedir}/fsl

subj=$1

INPUT01=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_WM_LR/L1_WM_Act.feat
INPUT02=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_WM_RL/L1_WM_Act.feat
OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_WM_Act

# checking L2 output
NCOPES=4 #check last cope since they are done sequentially
if [ -e ${OUTPUT}.gfeat/cope${NCOPES}.feat/cluster_mask_zstat1.nii.gz ]; then
  #echo "output exists...."
  exit
else
	echo "missing output for $subj WM" >> re-runL2.log
  rm -rf ${OUTPUT}.gfeat
fi


#find and replace
ITEMPLATE=${basedir}/templates/L2_WM_Act.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_WM_Act.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@INPUT01@'$INPUT01'@g' \
-e 's@INPUT02@'$INPUT02'@g' \
<$ITEMPLATE> $OTEMPLATE

#runs feat on output template
feat $OTEMPLATE

for C in `seq $NCOPES`; do
  rm -rf ${OUTPUT}.gfeat/cope${C}.feat/filtered_func_data.nii.gz
  rm -rf ${OUTPUT}.gfeat/cope${C}.feat/var_filtered_func_data.nii.gz
done
