#!/bin/bash
# Temporary file for information:
tmpfile="tmp"
#Array of masks:
maskArray=("0.0.0.0" \
  "128.0.0.0" "192.0.0.0" "224.0.0.0" "240.0.0.0" \
  "248.0.0.0" "252.0.0.0" "254.0.0.0" "255.0.0.0" \
  "255.128.0.0" "255.192.0.0" "255.224.0.0" "255.240.0.0" \
  "255.248.0.0" "255.252.0.0" "255.254.0.0" "255.255.0.0" \
  "255.255.128.0" "255.255.192.0" "255.255.224" "255.255.240.0" \
  "255.255.248.0" "255.255.252.0" "255.255.254" "255.255.255.0")
# use ${maskArray[0]} for 0 element
# use ${maskArray[*]} for count
# Collect all information to tmp file:
echo HOSTNAME = $(hostname) | tee -a $tmpfile;
echo TIMEZONE = $(timedatectl \
  | grep 'Time zone: ' \
  | sed 's/Time zone: //') | tee -a $tmpfile;
echo USER = $USER | tee -a $tmpfile;
echo OS = $(hostnamectl \
  | grep 'Operating' \
  | sed 's/Operating System: //') | tee -a $tmpfile
echo DATE = $(date +"%d %b %Y %X") | tee -a $tmpfile;
echo UPTIME = $(uptime -p \
  | sed 's/up //') | tee -a $tmpfile;
echo UPTIME_SEC = $(awk '{print $1}' /proc/uptime) | tee -a $tmpfile;
echo IP = $(ip a \
  | grep 'inet ' \
  | sed -n '2'p \
  | awk '{print $2}' \
  | awk -F '/' '{print $1}') | tee -a $tmpfile;
echo MASK = ${maskArray[$(ip a \
  | grep 'inet ' \
  | sed -n '2'p \
  | awk '{print $2}' \
  | awk -F '/' '{print $2}')]} | tee -a $tmpfile;
echo GATEWAY = $(ip r \
  | grep default \
  | awk '{print $3}') | tee -a $tmpfile;
echo RAM_TOTAL = $(free \
  | grep Mem \
  | awk '{printf "%.3f GB", $2 / 1048576}') | tee -a $tmpfile;
echo RAM_USED = $(free \
  | grep Mem \
  | awk '{printf "%.3f GB", $3 / 1048576}') | tee -a $tmpfile;
echo RAM_FREE = $(free \
  | grep Mem \
  | awk '{printf "%.3f GB", $4 / 1048576}') | tee -a $tmpfile;
echo SPACE_ROOT = $(df -BK \
  | grep '/$' \
  | awk '{printf "%.2f MB", $2 / 1024}') | tee -a $tmpfile;
echo SPACE_ROOT_USED = $(df -BK \
  | grep '/$' \
  | awk '{printf "%.2f MB", $3 / 1024}') | tee -a $tmpfile;
echo SPACE_ROOT_FREE = $(df -BK \
  | grep '/$' \
  | awk '{printf "%.2f MB", $4 / 1024}') | tee -a $tmpfile;