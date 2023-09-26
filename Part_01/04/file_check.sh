#!/bin/bash
for var in "$@"
    do
    if [ ! -f "$var" ]; then
    echo Error: missing file : $var
    exit 1
    fi
done