#!/bin/bash

source ./check.sh
source ./generator.sh

absolutePath=$1
subfoldersNumber=$2
subfoldersName=$3
filesNumber=$4
filesName=$5
filesSize=$6

if [ $# -ne 6 ]; then
    echo "Error: Not correct usage."
    echo "Usage: bash $0 [ABSPATH] [SUBFOLDERNUMBER] [SUBFOLDERNAME] [FILENUMBER] [FILENAME] [FILESIZE]"
    echo " "
    echo "      [ABSPATH] - is the absolute path"
    echo "      [SUBFOLDERNUMBER] - is the number of subfolders"
    echo "      [SUBFOLDERNAME] - is a list of English alphabet letters used in folder names"
    echo "      [FILENUMBER] - is the number of files in each created folder"
    echo "      [FILENAME] - the list of English alphabet letters used in the file name and extension"
    echo "      [FILESIZE] - file size (in kilobytes)"
    echo " "
    echo "Example:"
    echo "      bash ./main.sh /home/jhinelia/Monitoring2/src/01 4 az 5 az.az 3kb"
    exit 1
fi

check_absolute_path "$absolutePath"
check_number_parameter "second argument" "$subfoldersNumber"
check_subfolders_name "$subfoldersName"
check_number_parameter "fourth argument" "$filesNumber"
check_files_name "$filesName"
check_files_size "$filesSize"

fileGenerator $absolutePath $subfoldersNumber $subfoldersName $filesNumber $filesName $filesSize