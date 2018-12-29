#!/bin/bash

basedir=`pwd`
MAINDATADIR=${basedir}/data
MAINOUTPUTDIR=${basedir}/fsl

task=WM
run=$1
subj=$2

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_PPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_Act.feat/filtered_func_data.nii.gz
NVOLUMES=`fslnvols ${DATA}`

# checking L1 output
if [ -e ${OUTPUT}.feat/cluster_mask_zstat1.nii.gz ]; then
  echo "output exists, skipping...."
  exit
else
  rm -rf ${OUTPUT}.feat
fi

#EV files
EVDIR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs
rm -rf ${EVDIR}/2bk_all.txt ${EVDIR}/0bk_all.txt
cat ${EVDIR}/2bk_body.txt ${EVDIR}/2bk_faces.txt ${EVDIR}/2bk_places.txt ${EVDIR}/2bk_tools.txt > ${EVDIR}/2bk_all.txt
cat ${EVDIR}/0bk_body.txt ${EVDIR}/0bk_faces.txt ${EVDIR}/0bk_places.txt ${EVDIR}/0bk_tools.txt > ${EVDIR}/0bk_all.txt

#generate mask's timecourse
MASK=${basedir}/Masks/MFG_func.nii.gz
TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/my_timecourse.txt
fslmeants -i $DATA -o $TIMECOURSE -m $MASK

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_WM_PPI.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_PPI.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVDIR@'$EVDIR'@g' \
-e 's@TIMECOURSE@'$TIMECOURSE'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
