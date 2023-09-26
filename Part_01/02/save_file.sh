#!/bin/bash
echo -n "Write data to a file? (Y/N)"
read answ
case "$answ" in
    y|Y) 
    cp $1 $(date +"%d_%m_%y_%H_%M_%S").status
    echo File $(date +"%d_%m_%y_%H_%M_%S").status saved
    ;;
    *) echo "Aborting";;
esac
rm -rf $1