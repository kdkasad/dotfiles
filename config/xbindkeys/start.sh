#!/bin/sh

dir=$(dirname $(realpath "$0"))

# kill existing pkill(1) instances
pkill -x xbindkeys

# if keymaps specified, start only those
if [ $# -ge 1 ]; then
	if [ "$1" = "-l" ]; then
		find "$dir" -type f -name '*.keys' -print | sed 's:^.*/:: ; s:\.keys::' | xargs
		exit 0
	fi

	for map in "$@"; do
		setsid -f xbindkeys -f "$dir/${map%.keys}.keys"
	done
	exit
fi

# if none specified, start all
find "$dir" -type f -name '*.keys' -exec setsid -f xbindkeys -f {} \;
