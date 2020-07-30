#!/bin/sh

## wait for dwm

while ! pgrep -x dwm
do
	sleep 0.05
done
sleep 0.04

## find which thermal zone to monitor

# set $zone to the correct thermal zone
zone="$(grep -m1 ${THERMAL_ZONE_TYPE:-pkg_temp} /sys/class/thermal/thermal_zone*/type | grep -o "thermal_zone[0-9]\+" | sed 's/thermal_zone//')"
# update thermal_zone in polybar config
sed -i "/thermal-zone/s/[0-9]\+/$zone/" ${XDG_CONFIG_HOME:-$HOME/.config}/polybar/config

## start polybar(s)

for monitor in $(polybar --list-monitors | cut -d: -f1)
do
	MONITOR=$monitor polybar ${POLYBAR_BAR:-statusbar} &
done
