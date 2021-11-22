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

# Start GNOME PolicyKit agent
setsid -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Start session manager
# (requires masking lxpolkit(1) or error popup will appear)
setsid -f lxsession

# Start keybinding daemon
"$HOME"/.config/xbindkeysrc/start.sh

# Configure displays
xr --no-polybar

# Set desktop background
bgs -z ~/pictures/wallpapers/current &

# set xkb options
kb &

# load xresources
xrdb -load ~/.config/xresources

# Start statusbar
~/.config/polybar/start-polybar.sh >"$HOME"/.local/log/polybar/log 2>&1 &

# Start composition manager
picom -b >"$HOME"/.local/log/picom/log 2>&1

# start pulseaudio
pulseaudio --start --exit-idle-time=-1

# start IBus
ibus-daemon -drx

# Start notification daemon
setsid -f dunst &

# Start AppArmor violation notifier
setsid -f aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log >"$HOME"/.local/log/aa-notify/log 2>&1

# Start idle timer
setsid -f xautolock -time 10 -notify 20 -notifier "notify-send -a 'xautolock' 'sleeping in 20 seconds...'" -locker "$HOME/.local/bin/scripts/idlehandler" -detectsleep -corners "-000" &

# start MPRIS proxy
setsid -f mpris-proxy >"$HOME"/.local/log/mpris-proxy/log 2>&1

# start music player daemon
mpd

# start mpDris2
#setsid -f mpDris2 >"$HOME"/.local/log/mpdris2/log 2>&1

# Start KDE Connect daemon
setsid -f /usr/lib/kdeconnectd >"$HOME"/.local/log/kdeconnectd/log 2>&1
setsid -f kdeconnect-indicator >"$HOME"/.local/log/kdeconnect-indicator/log 2>&1

# Start Nextcloud desktop sync client
# setsid -f nextcloud --background >"$HOME"/.local/log/nextcloud/log 2>&1

# Start safeeyes
# setsid -f safeeyes >"$HOME"/.local/log/safeeyes/log 2>&1

# Become dwm
exec dwm
