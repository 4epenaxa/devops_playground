#!/bin/bash

delete_log() {
	read -p "Enter path to log file:" LOG
	echo "$LOG"
	if [ -f $LOG ]; then
	TOREMOVE=$(cat $LOG | awk '{print $1}')
	rm -rf $TOREMOVE
	else
		echo "Log file does not exist"
		exit 1
	fi
}