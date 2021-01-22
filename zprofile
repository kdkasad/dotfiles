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

# create tmux directory
mkdir "$XDG_RUNTIME_DIR/tmux" >/dev/null 2>&1

# start syncthing
pgrep -x syncthing >/dev/null || setsid -f \
	syncthing -no-browser -logflags=3 -logfile="${XDG_DATA_HOME:-$HOME/.local/share}/syncthing/syncthing.log" \
	>/dev/null 2>/dev/null

# if logged in on tty1, start the X server
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x Xorg >/dev/null || exec startx >/dev/null 2>&1
fi
