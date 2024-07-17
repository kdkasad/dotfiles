###
### ZSH environment file
###
### This is sourced every time ZSH starts.
###
### Copyright (C) 2024 Kian Kasad <kian@kasad.com>
### MIT License. See LICENSE file for details.
###

# Set NVM install directory
NVM_DIR="$HOME/.nvm"

# Load ZSH if our shell is not interactive. If it is interactive, it will be
# lazy-loaded in .zshrc.
if ! [[ -o interactive ]]
then
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
