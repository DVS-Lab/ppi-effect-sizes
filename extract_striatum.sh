#!/bin/bash

basedir=`pwd`
#rm -rf wb_data_hc2_final.txt str_data_hc2_final.txt
#for i in `cat hc2_final.txt`; do
#	datadir=${basedir}/fsl/${i}/MNINonLinear/Results/tfMRI_GAMBLING_RL/smoothing.feat/ICA_AROMA
#	indata=${datadir}/denoised_func_data_nonaggr.nii.gz
#	outdata=${datadir}/str_denoised_func_data_nonaggr.nii.gz
#	fslmaths ${indata} -mas StriatumMask_atlas.nii ${outdata}
#	echo $indata >> wb_data_hc2_final.txt
#	echo $outdata >> str_data_hc2_final.txt
#done

bgimage=/usr/share/fsl/5.0/data/standard/MNI152_T1_2mm_brain.nii.gz
des=${basedir}/fsl/101309/MNINonLinear/Results/tfMRI_GAMBLING_RL/L1_Gam_Act.feat/design.mat
con=${basedir}/fsl/101309/MNINonLinear/Results/tfMRI_GAMBLING_RL/L1_Gam_Act.feat/design.con

melodic -i wb_data_hc2_final.txt -o fsl/tica_wb_00dim_GAMBLING_RL_n53_new2.ica -v --bgimage=$bgimage --Tdes=$des --Tcon=$con --nobet --tr=0.72 --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica &

melodic -i wb_data_hc2_final.txt -o fsl/tica_wb_20dim_GAMBLING_RL_n53_new2.ica -v --bgimage=$bgimage --Tdes=$des --Tcon=$con --nobet --tr=0.72 --report --guireport=report.html -d 20 --mmthresh=0.5 --Ostats -a tica &

melodic -i str_data_hc2_final.txt -o fsl/tica_str_00dim_GAMBLING_RL_n53_new2.ica -v --bgimage=$bgimage --Tdes=$des --Tcon=$con --nobet --tr=0.72 --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica &

melodic -i str_data_hc2_final.txt -o fsl/tica_str_07dim_GAMBLING_RL_n53_new2.ica -v --bgimage=$bgimage --Tdes=$des --Tcon=$con --nobet --tr=0.72 --report --guireport=report.html -d 7 --mmthresh=0.5 --Ostats -a tica




