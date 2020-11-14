#!/bin/sh

## wait for dwm

while ! pgrep -x dwm
do
	sleep 0.05
done
sleep 0.04

## start polybar(s)

for monitor in $(polybar --list-monitors | cut -d: -f1)
do
	MONITOR=$monitor polybar ${POLYBAR_BAR:-statusbar} &
done
