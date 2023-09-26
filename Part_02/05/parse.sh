#!/bin/bash

parse() {
	read -p "Enter the path to the log file: " LPATH
	if [ -z "$LPATH" ]; then
		echo "No path entered"
		exit 1
	fi
	if [ ! -f "$LPATH" ]; then
		echo "File does not exist"
		exit 1
	fi

	if [ ! -r "$LPATH" ]; then
		echo "File is not readable"
		exit 1
	fi

	if [[ $1 -eq 1 ]]; then
		RES=$(awk '{print |"sort -k9"}' $LPATH)
		echo "$RES"
	elif [[ $1 -eq 2 ]]; then
		RES=$(awk '!x[$1]++' $LPATH)
		echo "$RES"
	elif [[ $1 -eq 3 ]]; then
		RES=$(awk '{if ($9 >= 400 && $9 < 600) print $0;}' $LPATH)
		echo "$RES"
	elif [[ $1 -eq 4 ]]; then
		RES=$(awk '{!x[$1]++; if ($9 >= 400 && $9 < 600) print $0;}' $LPATH)
		echo "$RES"
	fi
}