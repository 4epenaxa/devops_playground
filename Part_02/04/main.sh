#!/bin/bash

source ./check.sh
source ./logger.sh

for ((i=0; i<5; i++))
do
	RANDOMDATE=$(date -d "$((RANDOM % 365)) days ago" '+%s')
	logger $RANDOMDATE
done
