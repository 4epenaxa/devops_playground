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
		FREESPACE=$(df -k / | tail -1 | awk '{print $4}')
		if [ $FREESPACE -lt 1048576 ]; then
			echo "Not enough space to create files"
			exit 1
		fi
		dd if=/dev/zero of=$GENERATED_PATH_FILE bs=1K count=$SIZE 2>/dev/null
		echo $GENERATED_PATH_FILE" "$PDATE" "$4 >> file.log
		GENERATED_PATH_FILE=""
	done
}

fileGenerator() {
    GENERATED_PATH=""
	RUNDATE=$(date +%d%m%y)
	logDATE=$(date +%d-%m-%y)
	if [ ${#subfoldersName} -ge 4 ]; then
		folderparam=1
	elif [ ${#subfoldersName} -eq 3 ]; then
		folderparam=2
	elif [ ${#subfoldersName} -eq 2 ]; then
		folderparam=2
	elif [ ${#subfoldersName} -eq 1 ]; then
		folderparam=4
	fi

	for (( i=0; i<$subfoldersNumber; i++ )) do
		for (( j=0; j<${#subfoldersName}; j++ )) do
			for (( k=1; k<=$folderparam + $i; k++ )) do
				GENERATED_PATH="$GENERATED_PATH${subfoldersName:$j:1}"
			done
		done
		GENERATED_PATH="$1/$GENERATED_PATH""_""$RUNDATE"
		mkdir -p $GENERATED_PATH
		echo $GENERATED_PATH" "$logDATE" 4Kb" >> file.log
		create_files $GENERATED_PATH $filesNumber $filesName $filesSize
		GENERATED_PATH=""
	done
}