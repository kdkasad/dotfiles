#!/bin/sh

# set session environment file
cat << eof > "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/session-env" &
DISPLAY=$DISPLAY
export DISPLAY
XAUTHORITY=$XAUTHORITY
export XAUTHORITY
DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_ADDRESS
eof

# set volume to 20%
command -v amixer >/dev/null 2>&1 && amixer sset Master 20%

# Start statusbar manager
dwmblocks &

# Set desktop background dynamically
wallchanger &

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
picom -b &

# load xresources
xrdb -load ~/.config/xresources

# Become dwm
exec dwm
