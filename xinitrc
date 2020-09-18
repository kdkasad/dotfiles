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

# Start statusbar
~/.config/polybar/start-polybar.sh >/dev/null 2>&1 &

# Set desktop background
#wallchanger &
bgs -z ~/pictures/wallpapers/dynamic/current/08.jpg &

# set Caps Lock to act as Escape
setxkbmap -option 'caps:escape_shifted_capslock' &

# Set keyboard repeat rate
xset r rate 250 40 &

# Start notification daemon
dunst &

# Start keybinding daemon
xbindkeys -f ~/.config/xbindkeysrc &

# Start idle timer
xautolock -time 10 -notify 20 -notifier "notify-send -a 'xautolock' 'sleeping in 20 seconds...'" -locker "$HOME/.local/bin/scripts/idlehandler" -detectsleep -corners "-000" &

# Start composition manager
picom -b --experimental-backends

# Start nm-applet (if not running)
pgrep -x nm-applet >/dev/null 2>&1 || setsid -f nm-applet

# load xresources
xrdb -load ~/.config/xresources

# Become dwm
exec dwm
