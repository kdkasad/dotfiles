#!/bin/sh

# start dbus daemon (if not running)
[ -z "$DBUS_SESSION_BUS_ADDRESS" ] && 
	eval $(dbus-launch --exit-with-x11 --sh-syntax)

# set session environment file
cat << eof > "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/session-env" &
DISPLAY=$DISPLAY
export DISPLAY
XAUTHORITY=$XAUTHORITY
export XAUTHORITY
DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_ADDRESS
eof

# Configure external display
xrandr | grep 'HDMI-1 connected' &&
	xrandr --output eDP-1 --auto --output HDMI-1 --primary --right-of eDP-1

# map touchscreen to only laptop display
xinput --map-to-output 'GTCH7503:00 2A94:D64D' eDP-1

# Start statusbar
~/.config/polybar/start-polybar.sh >/dev/null 2>&1 &

# Set desktop background
bgs -z ~/pictures/wallpapers/current &

# set xkb options
kb &

# Start notification daemon
setsid -f dunst &

# Start keybinding daemon
xbindkeys -f ~/.config/xbindkeysrc &

# Start idle timer
setsid -f xautolock -time 10 -notify 20 -notifier "notify-send -a 'xautolock' 'sleeping in 20 seconds...'" -locker "$HOME/.local/bin/scripts/idlehandler" -detectsleep -corners "-000" &

# Start composition manager
picom -b

# load xresources
xrdb -load ~/.config/xresources

# start pulseaudio
pulseaudio --start --exit-idle-time=-1 &

# start music player daemon
mpd

# Start Nextcloud desktop sync client
setsid -f nextcloud --background >/dev/null 2>&1

# Become dwm
exec dwm
