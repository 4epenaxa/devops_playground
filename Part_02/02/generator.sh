# generator.sh

create_files() {
	GENERATED_PATH_FILE=""
	RUNDATE=$(date +%d%m%y)
	PDATE=$(date +%d-%m-%y)
	BEFOREDOT=${3%.*}
	AFTERDOT=${3#*.}
	SIZE=$(echo $4 | grep -o '[0-9]*')
	if [ ${#BEFOREDOT} -ge 4 ]; then
		filenameparam=1
	elif [ ${#BEFOREDOT} -eq 3 ]; then
		filenameparam=2
	elif [ ${#BEFOREDOT} -eq 2 ]; then
		filenameparam=2
	elif [ ${#BEFOREDOT} -eq 1 ]; then
		filenameparam=4
	fi
	for (( m=0; m<$2; m++ )) do
		for (( j=0; j<=${#BEFOREDOT}; j++ )) do
			for (( k=1; k<=$filenameparam + $m; k++ )) do
				GENERATED_PATH_FILE="$GENERATED_PATH_FILE${BEFOREDOT:$j:1}"
			done
		done
		GENERATED_PATH_FILE="$1/$GENERATED_PATH_FILE""_""$RUNDATE"".""$AFTERDOT"
		checkFreeSpace $startTime $filesSize
		dd if=/dev/zero of=$GENERATED_PATH_FILE bs=1M count=$SIZE 2>/dev/null
		echo $GENERATED_PATH_FILE" "$PDATE" "$4 >>"$logFile"
		GENERATED_PATH_FILE=""
	done
}

fileGenerator() {
    GENERATED_PATH=""
	RUNDATE=$(date +%d%m%y)
	logDATE=$(date +%d-%m-%y)

	for (( i=0; i<$SUBFOLDERS; i++ )) do
		for (( j=0; j<${#subfoldersName}; j++ )) do
			for (( k=1; k<=5 + $i; k++ )) do
				GENERATED_PATH="$GENERATED_PATH${subfoldersName:$j:1}"
			done
		done
		GENERATED_PATH="$1/$GENERATED_PATH""_""$RUNDATE"
		checkFreeSpace $startTime $filesSize

		mkdir -p $GENERATED_PATH
		echo $GENERATED_PATH" "$logDATE" 4Kb" >>"$logFile"
		create_files $GENERATED_PATH $FILENUM $filesName $filesSize
		GENERATED_PATH=""
	done
}