#!/bin/bash

gcc miniserver.c -o miniserver -lfcgi
spawn-fcgi -p 8080 ./miniserver
nginx -g "daemon off;"