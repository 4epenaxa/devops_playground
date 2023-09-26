#!/bin/bash

sudo docker compose up -d
while true;
do
	> ./html/metrics
	timestamp=$(date +%s)
	cpu_time=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1}')
	free_ram=$(free -m | awk 'NR == 2 {print $4}')
	hdd_space=$(df / | awk '{print $4}' | tail -1)
	echo "mynode_cpu_time $cpu_time" >> ./html/metrics
	echo "mynode_free_ram $free_ram" >> ./html/metrics
	echo "mynode_hdd_space "$hdd_space >> ./html/metrics
	#echo "Generated metrics at $timestamp"

	sleep 5
done
