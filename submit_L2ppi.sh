#!/bin/bash



for task in Soc; do
  for subj in `cat sublist`; do

    #Manages the number of jobs and cores
    SCRIPTNAME=L2_${task}_PPI.sh
    NCORES=12
    while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
      sleep 1m
    done
    bash $SCRIPTNAME $subj &
    sleep 5s

  done
done

