#!/bin/bash


for task in WM Emo Soc; do
  for subj in `cat sublist`; do
  	for RUN in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=L1_${task}_PPI.sh
  		NCORES=24
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash $SCRIPTNAME $RUN $subj &
  		sleep 5s

  	done
  done
done
