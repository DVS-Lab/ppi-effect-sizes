#!/bin/bash


for task in WM Emo Soc Gam; do
  for subj in `cat newsubs_n116.txt`; do

    #Manages the number of jobs and cores
    SCRIPTNAME=L2_${task}_Act.sh
    NCORES=10
    while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
      sleep 1m
    done
    bash $SCRIPTNAME $subj &
    sleep 5s

  done
done


for task in WM Emo Soc Gam; do
  for subj in `cat sublist`; do

    #Manages the number of jobs and cores
    SCRIPTNAME=L2_${task}_Act.sh
    NCORES=10
    while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
      sleep 1m
    done
    bash $SCRIPTNAME $subj &
    sleep 5s

  done
done
