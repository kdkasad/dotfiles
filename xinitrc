#!/bin/sh

# load xresources
xrdb -merge ~/.config/xresources &

# Start statusbar manager
dwmblocks &

# Set desktop background
feh --no-fehbg --bg-fill ~/.config/background.jpg &

# set Caps Lock to act as Escape
setxkbmap -option 'caps:escape_shifted_capslock' &

# Start notification daemon
dunst &

# Start keybinding daemon
xbindkeys -f ~/.config/keymap &

# Start idle timer
xautolock -time 10 -notify 20 -notifier "notify-send -a 'xautolock' 'sleeping in 20 seconds...'" -locker "systemctl suspend-then-hibernate" -detectsleep -corners "-000" &

# Start composition manager
picom -b &

# Set keyboard repeat rate
xset r rate 150 40

# Become dwm
exec dwm
