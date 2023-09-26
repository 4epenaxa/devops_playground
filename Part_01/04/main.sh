#!/bin/bash
# Settings
chmod +rx file_check.sh output.sh conf_check.sh colors.sh
if [ ! -f "file_check.sh" ]; then
    echo Error: missing file : file_check.sh
    exit 1
    fi
set -e
./file_check.sh output.sh conf_check.sh colors.sh

# Color scheme
source colors.sh

# Config file
source conf_check.sh

if [ $column1_background -eq $column1_font_color ] || [ $column2_font_color -eq $column2_background ]; then
        echo Error: 1 and 2 colors should not match, 3 and 4 too
        echo Change colors.conf and repeat your prompt.
        exit 1
else
    #Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
    case $column1_background in
        1) param1=${BGWHITE};;
        2) param1=${BGRED};;
        3) param1=${BGGREEN};;
        4) param1=${BGBLUE};;
        5) param1=${BGPURPLE};;
        6) param1=${BGBLACK};;
    esac
    #Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
    case $column1_font_color in
        1) param2=${WHITE};;
        2) param2=${RED};;
        3) param2=${GREEN};;
        4) param2=${BLUE};;
        5) param2=${PURPLE};;
        6) param2=${BLACK};;
    esac
    #Parameter 3 is the background of the values (after the '=' sign)
    case $column2_background in
        1) param3=${BGWHITE};;
        2) param3=${BGRED};;
        3) param3=${BGGREEN};;
        4) param3=${BGBLUE};;
        5) param3=${BGPURPLE};;
        6) param3=${BGBLACK};;
    esac
    #Parameter 4 is the font colour of the values (after the '=' sign)
    case $column2_font_color in
        1) param4=${WHITE};;
        2) param4=${RED};;
        3) param4=${GREEN};;
        4) param4=${BLUE};;
        5) param4=${PURPLE};;
        6) param4=${BLACK};;
    esac

    ./output.sh $param1 $param2 $param3 $param4 $resetColor
    printColorName() {
    res=0
    case $1 in
    1) res="(white)";;
    2) res="(red)";;
    3) res="(green)";;
    4) res="(blue)";;
    5) res="(purple)";;
    6) res="(black)";;
    esac
    echo $res
}
    echo
    echo Column 1 background = $( if [[ $default1 = 1 ]] ; then echo default ; 
        else echo $column1_background ; fi ; ) $(printColorName $column1_background)
    echo Column 1 font color = $( if [[ $default2 = 1 ]] ; then echo default ;
        else echo $column1_font_color ; fi ; ) $(printColorName $column1_font_color)
    echo Column 2 background = $( if [[ $default3 = 1 ]] ; then echo default ;
        else echo $column2_background ; fi ; ) $(printColorName $column2_background)
    echo Column 2 font color = $( if [[ $default4 = 1 ]] ; then echo default ;
        else echo $column2_font_color ; fi ; ) $(printColorName $column2_font_color)
fi