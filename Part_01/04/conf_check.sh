#!/bin/bash
FILE=./colors.conf
default1=0
default2=0
default3=0
default4=0
if [ ! -f "$FILE" ]; then
    echo Warning: missing file colors.conf 
    echo Using default color scheme.
    column1_background=1
    column1_font_color=2
    column2_background=6
    column2_font_color=3
    default1=1
    default2=1
    default3=1
    default4=1
else
    source $FILE
    if [ -z ${column1_background+x} ]; then
        default1=1
        column1_background=1
    elif [[ $column1_background != [1-6] ]]; then
        echo Error: Color must be from 1 to 6,
        echo Change colors.conf and repeat your prompt.
        exit
    fi
    if [ -z ${column1_font_color+x} ]; then
        default2=1
        column1_font_color=2
    elif [[ $column1_font_color != [1-6] ]]; then
        echo Error: Color must be from 1 to 6,
        echo Change colors.conf and repeat your prompt.
        exit
    fi
    if [ -z ${column2_background+x} ]; then
        default3=1
        column2_background=6
    elif [[ $column2_background != [1-6] ]]; then
        echo Error: Color must be from 1 to 6,
        echo Change colors.conf and repeat your prompt.
        exit
    fi
    if [ -z ${column2_font_color+x} ]; then
        default4=1
        column2_font_color=3
    elif [[ $column2_font_color != [1-6] ]]; then
        echo Error: Color must be from 1 to 6,
        echo Change colors.conf and repeat your prompt.
        exit
    fi
fi

# микс дефолтных цветов для избежания повтора 
if [[ $column1_background -eq $column1_font_color ]]; then
    if [[ $default1 -eq 1 && $default2 -eq 0 ]]; then
        column1_background=2
    fi
fi
if [[ $column1_background -eq $column1_font_color ]]; then
    if [[ $default1 -eq 0 && $default2 -eq 1 ]]; then
        column1_font_color=1
    fi
fi
if [[ $column2_background -eq $column2_font_color ]]; then
    if [[ $default3 -eq 1 && $default4 -eq 0 ]]; then
        column2_background=3
    fi
fi
if [[ $column2_background -eq $column2_font_color ]]; then
    if [[ $default3 -eq 0 && $default4 -eq 1 ]]; then
        column2_font_color=6
    fi
fi