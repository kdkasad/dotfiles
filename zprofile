# vim: ft=sh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

[ -f "$HOME/.config/env" ] && . $HOME/.config/env

# if logged in on tty1, start the X server
if [ $(tty) = "/dev/tty1" ]; then
	pgrep -x Xorg >/dev/null || exec startx >/dev/null 2>&1
fi
