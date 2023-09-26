#!/bin/bash
# Settings
chmod +rx output.sh colors.sh
if [ ! -f "output.sh" ]; then
    echo Error: missing file : output.sh
    exit 1
fi
if [ ! -f "colors.sh" ]; then
    echo Error: missing file : colors.sh
    exit 1
fi

# Color scheme
source colors.sh

# 1 - check only 4 parameters
if [ $# -ne 4 ]; then
echo "Only 4 parameters allowed"
else
# 2 - check only number 1-6
    for var in "$@"
    do
    if [[ $var =~ ^[0-9]+$ ]]; then
        if [[ $var != [1-6] ]]; then
        echo "Parameters should be in range from 1 to 6."
        exit 1
        fi
    else
    echo "Only numeric parameters allowed"
    exit 1
    fi
    done
# 3 - check 1 != 2 and 3 != 4
    if [ $1 == $2 ] || [ $3 == $4 ]; then
        echo Error: Please choose other colors.
        echo 1 and 2 colors should not match, 3 and 4 too
        echo Repeat your prompt.
        exit 1
    fi
    #Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
    case $1 in
        1) param1=${BGWHITE};;
        2) param1=${BGRED};;
        3) param1=${BGGREEN};;
        4) param1=${BGBLUE};;
        5) param1=${BGPURPLE};;
        6) param1=${BGBLACK};;
    esac
    #Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
    case $2 in
        1) param2=${WHITE};;
        2) param2=${RED};;
        3) param2=${GREEN};;
        4) param2=${BLUE};;
        5) param2=${PURPLE};;
        6) param2=${BLACK};;
    esac
    #Parameter 3 is the background of the values (after the '=' sign)
    case $3 in
        1) param3=${BGWHITE};;
        2) param3=${BGRED};;
        3) param3=${BGGREEN};;
        4) param3=${BGBLUE};;
        5) param3=${BGPURPLE};;
        6) param3=${BGBLACK};;
    esac
    #Parameter 4 is the font colour of the values (after the '=' sign)
    case $4 in
        1) param4=${WHITE};;
        2) param4=${RED};;
        3) param4=${GREEN};;
        4) param4=${BLUE};;
        5) param4=${PURPLE};;
        6) param4=${BLACK};;
    esac

    ./output.sh $param1 $param2 $param3 $param4 $resetColor
fi