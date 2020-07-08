#!/bin/sh

# check if HOME is set
if [ -z "$HOME" ]; then
	echo 'error: HOME is not set' >&2
	exit 1
fi

install_dots() {
	cat << EOF >&2
	This script does not install any dependencies or programs other than the following:
	  * dwm
	  * dwmblocks
	  * dmenu
	  * slock
	  * pause
	
	It also does not install any dependencies required to build the programs listed above.
	You will need at least:
	  * git
	  * make
	  * cc (any C compiler should work)
	  * xorg
	  * xorg-xext
	  * libxft (libxft-bgra is required for emojis. it is available in the AUR)

	There may be more. If so, edit this and submit a pull request at https://gitlab.com/kdkasad/dotfiles

	Press [enter] to continue...
EOF
	read cont

	mkdir -p "$HOME/.local/share"
	# create directories
	mkdir -p "$HOME/.local/opt"
	mkdir -p "$HOME/.local/bin"

	# get dotfiles
	cd "$HOME/.local/share"
	git clone https://git.kasad.com/dotfiles.git dotfiles
	cd dotfiles

	# install dotfiles
	find . -mindepth 1 -not -path '*/.git*' -type d -print0 | sed -z 's/^\.\///' | xargs -r0i%p mkdir -vp "$HOME/.%p"
	find . -mindepth 1 -not -path '*/.git*' -not -path './LICENSE' -type f -print0 | sed -z 's/^\.\///' | xargs -r0i%p ln -v ./%p "$HOME/.%p"

	# get utilities/programs
	cd "$HOME/.local/opt"
	git clone https://git.kasad.com/dwm.git dwm
	git clone https://git.kasad.com/dwmblocks.git dwmblocks
	git clone https://git.kasad.com/dmenu.git dmenu
	git clone https://git.kasad.com/slock.git slock
	git clone https://git.kasad.com/pause.git pause

	# make and install utilites/programs
	cd "$HOME/.local/opt/dwm"
	make install; make clean
	cd "$HOME/.local/opt/dwmblocks"
	make install; make clean
	cd "$HOME/.local/opt/dmenu"
	make install; make clean
	cd "$HOME/.local/opt/slock"
	sudo make PREFIX="$HOME/.local" install; sudo make clean
	cd "$HOME/.local/opt/pause"
	make install; make clean

	# reload xresources
	xrdb -load "$HOME/.config/xresources"
}

refresh_repo() {
	cd "$HOME/.local/share/dotfiles"
	find . -mindepth 1 -not -path '*/.git*' -not -path './LICENSE' -type f -print0 | sed -z 's/^\.\///' | xargs -r0i%p ln -vf "$HOME/.%p" ./%p
}

if [ "$1" = "refresh" ]; then
	refresh_repo
elif [ "$1" = "install" -o -z "$1" ]; then
	install_dots
fi
