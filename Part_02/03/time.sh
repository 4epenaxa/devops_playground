#!/bin/bash

delete_time() {
	read -p "Enter start date (YYYY-MM-DD): " start_date
	correct_date $start_date
	read -p "Enter start time (HH:MM): " start_time
	correct_time $start_time
	read -p "Enter end date (YYYY-MM-DD): " end_date
	correct_date $end_date
	read -p "Enter end time (HH:MM): " end_time
	correct_time $end_time
	#convert to linux date
	start_date=$(date -d "${start_date} ${start_time}" +%s)
	end_date=$(date -d "${end_date} ${end_time}" +%s)

	FILELIST=$(find / -newermt "@"$start_date -not -newermt "@"$end_date 2>/dev/null)
	
	if [ -z "$FILELIST" ]; then
		echo "No files found within the specified date and time range."
	else
		echo "Deleting files within the specified date and time range:"
		echo "$FILELIST"
		read -p "Are you sure you want to delete these files? (y/n): " confirmation
		if [ "$confirmation" == "y" ]; then
			for file in $FILELIST; do
				rm -rf $file 2>/dev/null
			done
			echo "Files deleted successfully."
		else
			echo "Operation canceled."
		fi
	fi
}

correct_date() {
	local date=$1
	if [[ ! $date =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$ ]]; then
		echo "Date is not correct format (YYYY-MM-DD)"
		exit 1
	fi
	date=$(echo "$date" | awk -F'-' '{print $1+0"-"$2+0"-"$3+0}')
	year=${date%%-*}
	month=${date#*-}
	month=${month%%-*}
	day=${date##*-}
	if (( year < 1970 || month < 1 || month > 12 || day < 1 || day > 31 )); then
 	 echo "Invalid date. Please enter a valid date in YYYY-MM-DD format."
		exit 1
	fi
}

correct_time() {
	local time=$1
	if [[ ! $time =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
		echo "Time is not correct format"
		exit 1
	fi
	hours=${time%%:*}
	minutes=${time#*:}

	if (( hours > 23 || minutes > 59 )); then
 	 echo "Invalid time. Please enter a valid time in HH:MM format."
  	exit 1
	fi
}