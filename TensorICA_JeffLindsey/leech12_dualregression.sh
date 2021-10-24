#!/bin/sh

Usage() {
    cat <<EOF

dual_regression v0.6.01 (beta)

***NOTE*** ORDER OF COMMAND-LINE ARGUMENTS IS DIFFERENT FROM PREVIOUS VERSION

Usage: dual_regression <group_IC_maps> <des_norm> <design.mat> <design.con> <n_perm> <output_directory> <input1> <input2> <input3> .........
e.g.   dual_regression groupICA.gica/groupmelodic.ica/melodic_IC 1 design.mat design.con 500 grot restricted_mask \`cat unsmoothed_restricted_list.txt\` _ \`cat smoothed_wb_list.txt\`

<group_IC_maps_4D>            4D image containing spatial IC maps (melodic_IC) from the whole-group ICA analysis
<des_norm>                    0 or 1 (1 is recommended). Whether to variance-normalise the timecourses used as the stage-2 regressors
<design.mat>                  Design matrix for final cross-subject modelling with randomise
<design.con>                  Design contrasts for final cross-subject modelling with randomise
<n_perm>                      Number of permutations for randomise; set to 1 for just raw tstat output, set to 0 to not run randomise at all.
<output_directory>            This directory will be created to hold all output and logfiles
<input1> <input2> ...         List all subjects' preprocessed, standard-space 4D datasets
<design.mat> <design.con>     can be replaced with just -1 for group-mean (one-group t-test) modelling.
<restricted_mask>	      spatially restricted mask for Leech2012JNeuro analysis

If you need to add other randomise option then just edit the line after "EDIT HERE" below

Duke University changes:
-can't execute files over cifs mounts. changed to "bash scriptname"
-executing tmp scripts and working with data across nfs instead of cifs (i.e., \$TMPDIR instead of \$LOGDIR or \$OUTPUT)


EOF
    exit 1
}

############################################################################

[ "$6" = "" ] && Usage

ORIG_COMMAND=$*

ICA_MAPS=`${FSLDIR}/bin/remove_ext $1` ; shift

DES_NORM=--des_norm
if [ $1 = 0 ] ; then
  DES_NORM=""
fi ; shift

if [ $1 = "-1" ] ; then
  DESIGN="-1"
  shift
else
  dm=$1
  dc=$2
  DESIGN="-d $1 -t $2"
  shift 2
fi

NPERM=$1 ; shift

OUTPUT=`${FSLDIR}/bin/remove_ext $1` ; shift

RESTRICTEDMASK=$1 ; shift

while [ _$1 != __ ] ; do
  AINPUTS="$AINPUTS `${FSLDIR}/bin/remove_ext $1`"
  shift
done

PLACEHOLDER=$1 ; shift

while [ _$1 != _ ] ; do
  BINPUTS="$BINPUTS `${FSLDIR}/bin/remove_ext $1`"
  shift
done


############################################################################

##DVS edit start
#REALOUTPUT=$OUTPUT
#mkdir -p $REALOUTPUT #will move everything here at the end
#OUTPUT=$TMPDIR/$OUTPUT #long and ugly dir
mkdir -p $OUTPUT
##DVS edit end

LOGDIR=${OUTPUT}/scripts+logs
mkdir -p $LOGDIR
echo $ORIG_COMMAND > $LOGDIR/command
echo $PLACEHOLDER > $LOGDIR/placeholder
if [ "$DESIGN" != -1 ] ; then
  /bin/cp $dm $OUTPUT/design.mat
  /bin/cp $dc $OUTPUT/design.con
fi

echo "creating common mask from smoothed wb inputs"
j=0
for i in $BINPUTS ; do
  echo "$FSLDIR/bin/fslmaths $i -Tstd -bin ${OUTPUT}/mask_`${FSLDIR}/bin/zeropad $j 5` -odt char" >> ${LOGDIR}/drA
  j=`echo "$j 1 + p" | dc -`
done
# ID_drA=`$FSLDIR/bin/fsl_sub -T 10 -N drA -l $LOGDIR -t ${LOGDIR}/drA`
bash ${LOGDIR}/drA

cat <<EOF > ${LOGDIR}/drB
#!/bin/sh
\$FSLDIR/bin/fslmerge -t ${OUTPUT}/maskALL \`\$FSLDIR/bin/imglob ${OUTPUT}/mask_*\`
\$FSLDIR/bin/fslmaths $OUTPUT/maskALL -Tmin $OUTPUT/mask
\$FSLDIR/bin/imrm $OUTPUT/mask_*
EOF
# chmod a+x ${LOGDIR}/drB
# ID_drB=`$FSLDIR/bin/fsl_sub -j $ID_drA -T 5 -N drB -l $LOGDIR ${LOGDIR}/drB`
bash ${LOGDIR}/drB

echo "doing the dual regressions"
j=0
for i in $AINPUTS ; do
  s=subject`${FSLDIR}/bin/zeropad $j 5`
  echo "$FSLDIR/bin/fsl_glm -i $i -d $ICA_MAPS -o $OUTPUT/dr_stage1_${s}.txt --demean -m $RESTRICTEDMASK" >> ${LOGDIR}/drC1
  j=`echo "$j 1 + p" | dc -`
done
#ID_drC=`$FSLDIR/bin/fsl_sub -j $ID_drB -T 30 -N drC -l $LOGDIR -t ${LOGDIR}/drC`
bash ${LOGDIR}/drC1

j=0
for i in $BINPUTS ; do
  s=subject`${FSLDIR}/bin/zeropad $j 5`
  echo "$FSLDIR/bin/fsl_glm -i $i -d $OUTPUT/dr_stage1_${s}.txt -o $OUTPUT/dr_stage2_$s --out_z=$OUTPUT/dr_stage2_${s}_Z --demean -m $OUTPUT/mask $DES_NORM ; \
        $FSLDIR/bin/fslsplit $OUTPUT/dr_stage2_$s $OUTPUT/dr_stage2_${s}_ic" >> ${LOGDIR}/drC2
  j=`echo "$j 1 + p" | dc -`
done
#ID_drC=`$FSLDIR/bin/fsl_sub -j $ID_drB -T 30 -N drC -l $LOGDIR -t ${LOGDIR}/drC`
bash ${LOGDIR}/drC2


echo "sorting maps and running randomise"
j=0
Nics=`$FSLDIR/bin/fslnvols $ICA_MAPS`
while [ $j -lt $Nics ] ; do
  jj=`$FSLDIR/bin/zeropad $j 4`

  RAND=""
  if [ $NPERM -eq 1 ] ; then
    RAND="$FSLDIR/bin/randomise -i $OUTPUT/dr_stage2_ic$jj -o $OUTPUT/dr_stage3_ic$jj -m $OUTPUT/mask $DESIGN -n 1 -V -R"
  fi
  if [ $NPERM -gt 1 ] ; then
    # EDIT HERE
    RAND="$FSLDIR/bin/randomise -i $OUTPUT/dr_stage2_ic$jj -o $OUTPUT/dr_stage3_ic$jj -m $OUTPUT/mask $DESIGN -n $NPERM -T -V"
  fi

  echo "$FSLDIR/bin/fslmerge -t $OUTPUT/dr_stage2_ic$jj \`\$FSLDIR/bin/imglob $OUTPUT/dr_stage2_subject*_ic${jj}.*\` ; \
        $FSLDIR/bin/imrm \`\$FSLDIR/bin/imglob $OUTPUT/dr_stage2_subject*_ic${jj}.*\` ; $RAND" >> ${LOGDIR}/drD
  j=`echo "$j 1 + p" | dc -`
done
# ID_drD=`$FSLDIR/bin/fsl_sub -j $ID_drC -T 60 -N drD -l $LOGDIR -t ${LOGDIR}/drD`
bash ${LOGDIR}/drD

##move everything at the end
#mv $OUTPUT $REALOUTPUT
