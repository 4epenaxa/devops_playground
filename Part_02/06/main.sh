#!/bin/bash

sudo cat $(pwd)/../04/*.log | sudo docker run --rm -i -e LANG=$LANG allinurl/goaccess -a -o html --log-format COMBINED - > report.html