#!/bin/bash

source check.sh
source log.sh
source time.sh
source mask.sh

param=$1

if [ "$param" == "1" ]; then
	delete_log 
elif [ "$param" == "2" ]; then
	delete_time
elif [ "$param" == "3" ]; then
	delete_mask
fi