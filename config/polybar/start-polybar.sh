#!/bin/sh

while ! pgrep -x dwm
do :
done

for monitor in $(polybar --list-monitors | cut -d: -f1)
do
	MONITOR=$monitor polybar -r ${POLYBAR_BAR:-statusbar} &
done
