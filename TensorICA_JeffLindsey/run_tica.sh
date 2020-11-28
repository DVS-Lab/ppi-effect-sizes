#!/bin/sh

for 
melodic -i filelist_social_RL.txt -o tica_00dim_social_RL_WB.ica -v --nobet --bgimage=mean_func --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica
melodic -i filelist_social_LR.txt -o tica_00dim_social_LR_WB.ica -v --nobet --bgimage=mean_func --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica

melodic -i filelist_gambling_RL.txt -o tica_00dim_gambling_RL_WB.ica -v --nobet --bgimage=mean_func --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica
melodic -i filelist_gambling_LR.txt -o tica_00dim_gambling_LR_WB.ica -v --nobet --bgimage=mean_func --report --guireport=report.html -d 0 --mmthresh=0.5 --Ostats -a tica

LindseySubs_task-Soc_run-LR_paths.txt