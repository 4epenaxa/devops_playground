#!/bin/bash

if [ $# -ne 1 ] || [ "$1" != "1" ] && [ "$1" != "2" ] && [ "$1" != "3" ]; then
    echo "Error: Not correct usage."
    echo "Usage: bash $0 [1-3]"
    echo " "
    echo "Use one of three options to clean the system:"
    echo "      1 - by log file"
    echo "      2 - by creation date and time"
    echo "      3 - by name mask(i.e. characters, underlining and date)"
    echo " "
    echo "Example:"
    echo "      bash ./main.sh 1"
    exit 1
fi