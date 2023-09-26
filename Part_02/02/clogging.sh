# clogging.sh

source ./generator.sh

systemClogging() {
	startTime=$(date +%T)
	checkFreeSpace $startTime $filesSize
	FOLDERLIST=$(find / -type d 2>/dev/null)
	REMOVE_BIN=$(echo "$FOLDERLIST" | grep -v bin)
	FOLDERLIST=$(echo "$REMOVE_BIN" | sort -R)

	for folder in $FOLDERLIST; do
		if [ -w "$folder" ]; then
			SUBFOLDERS=$(shuf -i 1-100 -n 1)
			FILENUM=$(shuf -i 1-100 -n 1)
			fileGenerator $folder $SUBFOLDERS $1 $FILENUM $2 $3
		fi

	done
	logTime $startTime
}