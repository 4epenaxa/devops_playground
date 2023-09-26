#!/bin/bash
timer_start=$(date +%s)
FILE=folder_info.sh
chmod +rx $FILE
if [ ! -f "$FILE" ]; then
    echo Error: missing script: $FILE
    exit
fi
if [ $# != 1 ]; then
    echo Should be only 1 parameter
elif ! [ -d $1 ]; then
    echo Directory not exist
elif [ ${1: -1} != "/" ]; then
    echo Directory path should end with '/'
else
    ./folder_info.sh $1
    timer_end=$(date +%s)
    echo "Script execution time (in seconds) = $(($timer_end - $timer_start))"
fi