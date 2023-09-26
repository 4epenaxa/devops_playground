#!/bin/bash

delete_mask() {
	read -p "Enter the mask: " MASK
	MASKLIST=$(find / -name "$MASK" 2>/dev/null)
	for i in $MASKLIST; do
		if [ -d "$i" ]; then
			rm -rf "$i" 2>/dev/null
		elif [ -f "$i" ]; then
			rm -f "$i" 2>/dev/null
		fi
	done
}