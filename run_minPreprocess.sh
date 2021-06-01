#!/bin/bash


for subj in `cat TensorICA_JeffLindsey/LindseySubs.txt`; do
  for task in GAMBLING SOCIAL; do
  	for run in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=minPreprocess.sh
  		NCORES=40
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash $SCRIPTNAME $subj $task $run &
  		sleep 1s

  	done
  done
done
