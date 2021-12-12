#!/bin/sh

dir=$(dirname $(realpath "$0"))

# kill existing pkill(1) instances
pkill -x xbindkeys

# if keymaps specified, start only those
if [ $# -ge 1 ]; then
	for map in "$@"; do
		setsid -f xbindkeys -f "$dir/${map%.keys}.keys"
		exit
	done
	exit
fi

# if none specified, start all
find "$dir" -type f -name '*.keys' -exec setsid -f xbindkeys -f {} \;
