# vim: ft=sh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# load environment configuration
[ -f "$HOME/.config/env" ] && . "$HOME/.config/env"

# configure gpg tty
export GPG_TTY="$(tty)"

# start ssh-agent(1)
eval $(ssh-agent) >/dev/null 2>&1

# start gnome-keyring-daemon(1)
eval $(gnome-keyring-daemon --start --components=secrets,pkcs11)
export GNOME_KEYRING_CONTROL

# start syncthing
pgrep -x syncthing >/dev/null || setsid -f \
	syncthing -no-browser -logflags=3 -logfile="${XDG_DATA_HOME:-$HOME/.local/share}/syncthing/syncthing.log" \
	>/dev/null 2>/dev/null

# Start GeoClue2 agent
[ -x /usr/lib/geoclue-2.0/demos/agent ] && \
	setsid -f /usr/lib/geoclue-2.0/demos/agent >"$HOME/.local/log/geoclue2-agent/log" 2>&1

# if logged in on tty1, start the X server
if [ "$(tty)" = "/dev/tty1" ]; then
	ps -o cmd -C Xorg | grep -Fq vt1 || exec startx >/dev/null 2>&1
fi
