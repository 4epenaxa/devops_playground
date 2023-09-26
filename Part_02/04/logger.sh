#!/bin/bash

METHODS=(GET POST PUT PATCH DELETE)
RESPONSES=(200 201 400 401 403 404 500 501 502 503)
#200 OK
#201 Created
#400 Bad Request
#401 Unauthorized
#403 Forbidden
#404 Not Found
#500 Internal Server Error
#501 Not Implemented
#502 Bad Gateway
#503 Service Unavailable
AGENTS=(Mozilla "Google Chrome" Opera Safari "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library" "net tool")

printProgressBar() {
    local width=50  # Width of the progress bar in characters
    local percent=$(( $1 * 100 / $2 ))  # Calculate percentage
    local numChars=$(( $width * $percent / 100 ))  # Calculate the number of characters to fill
    local numSpaces=$(( $width - $numChars ))  # Calculate the number of spaces

    # Build the progress bar string
    local progressBar="$FILENAME $3 ["
    for ((x = 0; x < numChars; x++)); do
        progressBar+="▓"
    done
    for ((x = 0; x < numSpaces; x++)); do
        progressBar+=" "
    done
    progressBar+="] $percent%"

    # Print the progress bar
    printf "\r%s" "$progressBar"
}


logger() {
	local RANDOMDATE=$1
	local FILENAME=$(date -d @"$RANDOMDATE" '+%Y-%m-%d')".log"
	local AMOUNTOFLOGS=$((RANDOM % 900 + 100))
	local INCREMENT=$((86400 / $AMOUNTOFLOGS))
    local currentlog=0
	for ((j=0; j<$AMOUNTOFLOGS; j++))
	do
		RANDOMIP=$(printf "%d.%d.%d.%d\n" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))")
		RANDOMMETHOD=${METHODS[ $RANDOM % ${#METHODS[@]} ]}
		RANDOMRESPONSE=${RESPONSES[ $RANDOM % ${#RESPONSES[@]} ]}
		RANDOMAGENT=${AGENTS[ $RANDOM % ${#AGENTS[@]} ]}
		RANDOMURL="/"$(echo $RANDOM | md5sum | head -c 20)
		RANDOMINCREMENT=$(($RANDOM % $INCREMENT))
		RANDOMTIME=$(date -d @"$(($RANDOMDATE + $RANDOMINCREMENT))" '+%d/%b/%Y:%T %z')
		RANDOMDATE=$(($RANDOMDATE + $INCREMENT))
		echo "$RANDOMIP - - [$RANDOMTIME] \"$RANDOMMETHOD $RANDOMURL HTTP/1.1\" $RANDOMRESPONSE 0 \"-\" \"$RANDOMAGENT\"" >> $FILENAME

        currentlog=$((currentlog + 1))
        printProgressBar $currentlog $AMOUNTOFLOGS $2

	done
    printf "\n"
}
