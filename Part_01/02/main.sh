#!/bin/bash
chmod +rx save_file.sh output.sh file_check.sh
if [ ! -f "file_check.sh" ]; then
    echo Error: missing file : file_check.sh
    exit 1
    fi
set -e
./file_check.sh save_file.sh output.sh
./output.sh
./save_file.sh tmp