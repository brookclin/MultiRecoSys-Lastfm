#!/bin/bash
times=10
mkdir conf_interval
for (( i=1; i<=$times; i++ ))
do
    mkdir $i
    cd $i
    nohup ../../generateEverything_8-1-1.sh &
    cd ..
done
#cd conf_interval
#python ../../conf_interval.py