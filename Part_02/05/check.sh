#!/bin/bash

if [ $# -ne 1 ] || [ "$1" != "1" ] && [ "$1" != "2" ] && [ "$1" != "3" ] && [ "$1" != "4" ]; then
    echo "Error: Not correct usage."
    echo "Usage: bash $0 [1-4]"
    echo " "
    echo "Use one of three options to clean the system:"
    echo "      1 - All entries sorted by response code"
    echo "      2 - All unique IPs found in the entries"
    echo "      3 - All requests with errors (response code - 4xx or 5xxx)"
	echo "      4 - All unique IPs found among the erroneous requests"
    echo " "
    echo "Example:"
    echo "      bash ./main.sh 1"
    exit 1
fi