#!/bin/bash

for task in SOCIAL EMOTION GAMBLING WM; do
  for subj in `cat EuniceSubs.txt`; do
  	for RUN in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=runAROMA_hcp.sh
  		NCORES=48
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash runAROMA_hcp.sh $task $RUN $subj &


  	done
  done
done

