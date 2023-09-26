#!/bin/bash

source ./check.sh
source ./clogging.sh

subfoldersName=$1
filesName=$2
filesSize=$3
logFile="report.log"
totalFolders=0
currentFolder=0

if [ $# -ne 3 ]; then
    echo "Error: Not correct usage."
    echo "Usage: bash $0 [SUBFOLDERNAME] [FILENAME] [FILESIZE]"
    echo " "
    echo "      [SUBFOLDERNAME] - is a list of English alphabet letters used in folder names"
    echo "      [FILENAME] - the list of English alphabet letters used in the file name and extension"
    echo "      [FILESIZE] - file size (in Megabytes)"
    echo " "
    echo "Example:"
    echo "      bash ./main.sh az az.az 3Mb"
    exit 1
fi

check_subfolders_name "$subfoldersName"
check_files_name "$filesName"
check_files_size "$filesSize"

systemClogging $subfoldersName $filesName $filesSize