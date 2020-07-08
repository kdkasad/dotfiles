# vim: ft=sh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# load environment configuration
[ -f "$HOME/.config/env" ] && . $HOME/.config/env

# configure gpg tty
export GPG_TTY="$(tty)"

# start ssh-agent(1)
eval $(ssh-agent) >/dev/null 2>&1

# if logged in on tty1, start the X server
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x Xorg >/dev/null || exec dbus-launch --exit-with-session startx >/dev/null 2>&1
fi
