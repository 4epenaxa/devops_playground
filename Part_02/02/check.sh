# check.sh

check_subfolders_name() {
    local subfoldersName="$1"
    if ! [[ "$subfoldersName" =~ ^[a-zA-Z]{1,7}$ ]]; then
        echo "Error:    The first argument '$subfoldersName' is not valid."
        echo "          It should consist of English alphabet letters (up to 7 characters)."
        exit 1
    fi
}

check_files_name() {
    local filesName="$1"
    if ! [[ "$filesName" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
        echo "Error:    The second argument '$filesName' is not valid."
        echo "          It should be in the format 'name.ext'"
        echo "          with up to 7 characters for the name and up to 3 characters for the extension,"
        echo "          containing only English alphabet letters, and one dot between."
        exit 1
    fi
}

check_files_size() {
    local filesSize="$1"
    if ! [[ "$filesSize" =~ ^[1-9][0-9]?Mb$|100Mb$ ]]; then
        echo "Error:    The third argument '$filesSize' is not valid. It should be in the format 'numberMb'"
        echo "          (e.g., '1Mb', '50Mb', '100Mb') with a number greater than 0 and less than or equal to 100."
        exit 1
    fi
}

logTime() {
    endTime=$(date +%T)
    totalTime=$(date -u -d @$(( $(date -d "$endTime" +%s) - $(date -d "$startTime" +%s) )) +"%T")
    echo "Start Time: $startTime" >>"$logFile"
    echo "End Time: $endTime" >>"$logFile"
    echo "Total Running Time: $totalTime" >>"$logFile"

    echo "Start Time: $startTime"
    echo "End Time: $endTime"
    echo "Total Running Time: $totalTime"
}

checkFreeSpace() {
    		FREESPACE=$(df -k / | tail -1 | awk '{print $4}')
            local sizeWithOutSuffix="${2%"Mb"}"
		if [ $FREESPACE -lt $((1048576 + sizeWithOutSuffix * 1024)) ]; then
			echo "Not enough space to create files"
			logTime $startTime
			exit 1
		fi
}