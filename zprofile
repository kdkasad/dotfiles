# vim: ft=sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 037

# set GPG tty to fix ioctl errors
export GPG_TTY=$(tty)

[ -f "$HOME/.config/env" ] && . $HOME/.config/env

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# if logged in on tty1, start the X server
if [ $(tty) = "/dev/tty1" ]; then
	pgrep -x Xorg || exec startx >/dev/null 2>&1
fi
