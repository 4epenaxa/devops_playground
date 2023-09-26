#!/bin/bash
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
echo -e $1$2HOSTNAME =$5$3$4 $(hostname)$5
echo -e $1$2TIMEZONE =$5$3$4 $(timedatectl | grep 'Time zone: ' | sed 's/Time zone: //')$5
echo -e $1$2USER =$5$3$4 $USER$5
echo -e $1$2OS =$5$3$4 $(hostnamectl | grep 'Operating' | sed 's/Operating System: //')$5
echo -e $1$2DATE =$5$3$4 $(date +"%d %b %Y %X")$5
echo -e $1$2UPTIME =$5$3$4 $(uptime -p | sed 's/up //')$5
echo -e $1$2UPTIME_SEC =$5$3$4 $(awk '{print $1}' /proc/uptime)$5
echo -e $1$2IP =$5$3$4 $(ip a | grep 'inet ' | sed -n '2'p | awk '{print $2}' | awk -F '/' '{print $1}')$5
echo -e $1$2MASK =$5$3$4 ${maskArray[$(ip a | grep 'inet ' | sed -n '2'p | awk '{print $2}' | awk -F '/' '{print $2}')]}$5
echo -e $1$2GATEWAY =$5$3$4 $(ip r | grep default | awk '{print $3}')$5
echo -e $1$2RAM_TOTAL =$5$3$4 $(free | grep Mem | awk '{printf "%.3f GB", $2 / 1048576}')$5
echo -e $1$2RAM_USED =$5$3$4 $(free | grep Mem | awk '{printf "%.3f GB", $3 / 1048576}')$5
echo -e $1$2RAM_FREE =$5$3$4 $(free | grep Mem | awk '{printf "%.3f GB", $4 / 1048576}')$5
echo -e $1$2SPACE_ROOT =$5$3$4 $(df -BK | grep '/$' | awk '{printf "%.2f MB", $2 / 1024}')$5
echo -e $1$2SPACE_ROOT_USED =$5$3$4 $(df -BK | grep '/$' | awk '{printf "%.2f MB", $3 / 1024}')$5
echo -e $1$2SPACE_ROOT_FREE =$5$3$4 $(df -BK | grep '/$' | awk '{printf "%.2f MB", $4 / 1024}')$5