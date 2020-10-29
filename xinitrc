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
xrandr | grep 'HDMI[0-9] connected' &&
	xrandr --output eDP1 --auto --output HDMI1 --primary --right-of eDP1

# map touchscreen to only laptop display
xinput --map-to-output 'GTCH7503:00 2A94:D64D' eDP1

# Start statusbar
~/.config/polybar/start-polybar.sh >/dev/null 2>&1 &

# Set desktop background
#wallchanger &
bgs -z ~/pictures/wallpapers/current &

# set xkb options
kb &

# Start notification daemon
dunst &

# Start keybinding daemon
xbindkeys -f ~/.config/xbindkeysrc &

# Start idle timer
setsid -f xautolock -time 10 -notify 20 -notifier "notify-send -a 'xautolock' 'sleeping in 20 seconds...'" -locker "$HOME/.local/bin/scripts/idlehandler" -detectsleep -corners "-000" &

# Start composition manager
picom -b

# Start nm-applet (if not running)
pgrep -x nm-applet >/dev/null 2>&1 || setsid -f nm-applet

# load xresources
xrdb -load ~/.config/xresources

# Become dwm
exec dwm
