#!/bin/bash


for task in Soc Gam WM Emo; do
  for subj in `cat EuniceSubs.txt`; do
  	for RUN in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=L1_${task}_Act.sh
  		NCORES=40
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash $SCRIPTNAME $RUN $subj &
  		sleep 1s

  	done
  done
done

